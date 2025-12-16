import 'package:counter_mvc/shared/task_form.dart';
import 'package:counter_mvc/viewmodels/create_task_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateTaskView extends StatelessWidget {
  const CreateTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    final createTaskVm = Provider.of<CreateTaskViewmodel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(),
        titleSpacing: 5,
        title: Text('Ajouter une tâche'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 60),
          margin: EdgeInsets.only(top: 24),
          child: TaskForm(
            formkey: createTaskVm.formkey,
            isLoading: createTaskVm.isSubmitting,
            onSubmit: createTaskVm.createTask,
          ),
        ),
      ),
    );
  }
}
