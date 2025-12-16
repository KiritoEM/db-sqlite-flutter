// ignore_for_file: use_build_context_synchronously

import 'package:counter_mvc/constants/enums.dart';
import 'package:counter_mvc/shared/snackbar.dart';
import 'package:counter_mvc/utils/colors.dart';
import 'package:counter_mvc/shared/custom_search_bar.dart';
import 'package:counter_mvc/viewmodels/task_list_viewmodel.dart';
import 'package:counter_mvc/viewmodels/user_viewmodel.dart';
import 'package:counter_mvc/views/task_list_view/widgets/empty_task.dart';
import 'package:counter_mvc/views/task_list_view/widgets/task_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({super.key});

  @override
  State<TaskListView> createState() => _TaskListState();
}

class _TaskListState extends State<TaskListView> {
  final FocusNode _searchFocusNode = FocusNode();

  Future<void> _handleMarkTaskAsDone(
    TaskListViewmodel listvm,
    int taskId,
  ) async {
    final message = await listvm.makeTaskDone(context, taskId);

    if (message != null) {
      SnackbarUtils.showInSnackBar(context, message, type: SnackbarType.error);
    }
  }

  Future<void> _handleDeleteTask(TaskListViewmodel listvm, int taskId) async {
    final result = await listvm.deleteTask(context, taskId);

    if (result.message != null) {
      SnackbarUtils.showInSnackBar(
        context,
        result.message!,
        type: result.isSuccess ? SnackbarType.success : SnackbarType.error,
      );
    }
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    final userVm = Provider.of<UserViewmodel>(context, listen: false);
    final taskVm = Provider.of<TaskListViewmodel>(context, listen: false);

    await userVm.getUsername();
    taskVm.getTasks(titleFilter: '');
  }

  @override
  Widget build(BuildContext context) {
    final listvm = Provider.of<TaskListViewmodel>(context);
    final userVm = Provider.of<UserViewmodel>(context);

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: Text.rich(
          TextSpan(
            children: [
              const TextSpan(text: 'Bonjour '),
              TextSpan(
                text: ' ${userVm.username}',
                style: const TextStyle(color: Colors.green),
              ),
            ],
          ),
        ),
        backgroundColor: AppColors.surface,
        actions: [
          PopupMenuItem<String>(
            onTap: () async {
              final message = await userVm.deleteUsername();

              if (message != null) {
                SnackbarUtils.showInSnackBar(
                  context,
                  message,
                  type: SnackbarType.error,
                );
              }

              Navigator.pushNamed(context, '/login');
            },
            value: 'logout',
            child: const Icon(Icons.logout, color: Colors.red),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            listvm.tasks.isNotEmpty ? _buildSearchBar(listvm) : Container(),
            const SizedBox(height: 40),
            Expanded(child: _buildBody(listvm)),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(context, listvm),
    );
  }

  Widget _buildSearchBar(TaskListViewmodel listvm) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: CustomSearchBar(
        placeholderText: 'Rechercher une tache...',
        onSearch: (String value) => listvm.getTasks(titleFilter: value),
      ),
    );
  }

  Widget _buildBody(TaskListViewmodel listvm) {
    if (listvm.loadingTask) {
      return const Center(child: CircularProgressIndicator());
    }

    if (listvm.error.trim().isNotEmpty) {
      return Center(
        child: Text(listvm.error, style: const TextStyle(color: Colors.red)),
      );
    }

    if (listvm.tasks.isEmpty) {
      return EmptyTask(
        onAddClick: () => Navigator.of(context).pushNamed('/create'),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: [
          Column(
            spacing: 20,
            children: listvm.tasks.map((task) {
              return TaskItem(
                title: task.title,
                date: task.date,
                description: task.description,
                isDone: task.isDone,
                onCheck: (_) => _handleMarkTaskAsDone(listvm, task.id),
                onDelete: () => _handleDeleteTask(listvm, task.id),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget? _buildFloatingActionButton(
    BuildContext context,
    TaskListViewmodel listvm,
  ) {
    if (listvm.tasks.isNotEmpty) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create');
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add, color: Colors.white),
      );
    }

    return null;
  }
}
