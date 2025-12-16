import 'package:counter_mvc/model/domain-object/task.dart';
import 'package:counter_mvc/model/schemas/vm_result.dart';
import 'package:counter_mvc/model/task_model.dart';
import 'package:flutter/material.dart';

class TaskListViewmodel extends ChangeNotifier {
  final TaskModel _taskModel = TaskModel();
  List<Task> _tasks = [];
  bool _loadingTask = false;
  String _error = '';
  bool _isSearching = false;

  //getters
  List<Task> get tasks => _tasks;
  bool get loadingTask => _loadingTask;
  String get error => _error;
  bool get isSearching => _isSearching;

  //get all tasks
  Future<void> getTasks({String? titleFilter}) async {
    _loadingTask = true;
    notifyListeners();

    _isSearching = titleFilter != null && titleFilter.trim().isNotEmpty;

    final getTaskResponse = await _taskModel.getAllTasks(
      titleFilter: titleFilter,
    );

    if (getTaskResponse.hasError == true) {
      _loadingTask = false;
      _error = getTaskResponse.message!;
      notifyListeners();
      return;
    }

    _tasks = getTaskResponse.data ?? [];
    _loadingTask = false;
    notifyListeners();
  }

  void clearSearch() {
    _isSearching = false;
    getTasks();
  }

  //Make a task done
  Future<String?> makeTaskDone(BuildContext context, int taskId) async {
    _loadingTask = true;

    final response = await _taskModel.makeTaskDone(taskId);

    if (response.hasError == true) {
      _loadingTask = false;
      _error = response.message!;
      notifyListeners();
      return response.message;
    }

    await getTasks();
    _loadingTask = false;
    notifyListeners();

    return null;
  }

  //Delete a task
  Future<VmResponse> deleteTask(BuildContext context, int taskId) async {
    _loadingTask = true;

    final response = await _taskModel.deleteTask(taskId);

    if (response.hasError == true) {
      _loadingTask = false;
      _error = response.message!;
      notifyListeners();
      return VmResponse(message: response.message);
    }

    await getTasks();
    _loadingTask = false;
    notifyListeners();

    return VmResponse(message: response.message, isSuccess: true);
  }
}
