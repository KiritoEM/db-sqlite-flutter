import 'package:counter_mvc/model/schemas/create_task_schema.dart';
import 'package:counter_mvc/model/task_model.dart';
import 'package:counter_mvc/shared/snackbar.dart';
import 'package:flutter/material.dart';

class CreateTaskViewmodel extends ChangeNotifier {
  final TaskModel _taskModel = TaskModel();
  final _formkey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  //getters
  bool get isSubmitting => _isSubmitting;
  GlobalKey<FormState> get formkey => _formkey;

  //create task
  Future<void> createTask({
    required CreateTaskSchema data,
    required BuildContext context,
  }) async {
    _isSubmitting = true;
    notifyListeners();

    if (!_formkey.currentState!.validate()) return;
    _formkey.currentState!.save();

    final createTaskResponse = await _taskModel.createTask(
      title: data.title,
      description: data.description ?? '',
    );

    if (createTaskResponse.hasError == true) {
      _isSubmitting = false;
      SnackbarUtils.showInSnackBar(context, createTaskResponse.message!);
      notifyListeners();
      return;
    }

    _isSubmitting = false;
    SnackbarUtils.showInSnackBar(context, createTaskResponse.message!);
    Navigator.pushNamedAndRemoveUntil(context, '/list', (_) => false);
    notifyListeners();
  }
}
