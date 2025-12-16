import 'package:counter_mvc/model/schemas/create_task_schema.dart';
import 'package:counter_mvc/model/task_model.dart';
import 'package:flutter/material.dart';

class CreateTaskViewmodel extends ChangeNotifier {
  final TaskModel _taskModel = TaskModel();
  final _formkey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  //getters
  bool get isSubmitting => _isSubmitting;
  GlobalKey<FormState> get formkey => _formkey;

  //create task
  Future<String?> createTask({required CreateTaskSchema data}) async {
    _isSubmitting = true;
    notifyListeners();

    if (!_formkey.currentState!.validate()) return null;
    _formkey.currentState!.save();

    final createTaskResponse = await _taskModel.createTask(
      title: data.title,
      description: data.description ?? '',
    );

    if (createTaskResponse.hasError == true) {
      _isSubmitting = false;
      notifyListeners();
      return createTaskResponse.message;
    }

    _isSubmitting = false;
    notifyListeners();

    return null;
  }
}
