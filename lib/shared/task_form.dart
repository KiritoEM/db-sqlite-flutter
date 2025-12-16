// task_form.dart
// ignore_for_file: use_build_context_synchronously

import 'package:counter_mvc/model/domain-object/task.dart';
import 'package:counter_mvc/model/schemas/create_task_schema.dart';
import 'package:counter_mvc/shared/button_with_spinner.dart';
import 'package:counter_mvc/shared/labeled_widget.dart';
import 'package:counter_mvc/shared/snackbar.dart';
import 'package:flutter/material.dart';

class TaskForm extends StatefulWidget {
  final Future<String?> Function({required CreateTaskSchema data}) onSubmit;
  final GlobalKey<FormState> formkey;
  final bool isLoading;
  final Task? defaultFormData;
  final String buttonLabel;
  final String loadingButtonLabel;

  const TaskForm({
    super.key,
    required this.onSubmit,
    required this.formkey,
    this.isLoading = false,
    this.defaultFormData,
    this.buttonLabel = 'Créer la tâche',
    this.loadingButtonLabel = 'Création en cours...',
  });

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  late CreateTaskSchema _todoData;

  void _handleSubmitForm() async {
    if (widget.formkey.currentState!.validate()) {
      widget.formkey.currentState!.save();

      final message = await widget.onSubmit(data: _todoData);

      if (message != null) {
        SnackbarUtils.showInSnackBar(context, message);
      }

      Navigator.pushNamedAndRemoveUntil(context, '/list', (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeFormData();
  }

  @override
  void didUpdateWidget(covariant TaskForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.defaultFormData != oldWidget.defaultFormData) {
      _initializeFormData();
    }
  }

  //init form values if editing task
  void _initializeFormData() {
    final task = widget.defaultFormData;

    final String title = task?.title ?? '';
    final String description = '';

    _todoData = CreateTaskSchema(title: title, description: description);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Form(
        key: widget.formkey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            LabeledWidget(
              label: 'Nom de la tâche',
              child: TextFormField(
                initialValue: _todoData.title,
                decoration: const InputDecoration(
                  hintText: 'Taper le nom de la tâche',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Le nom de la tâche est obligatoire';
                  }
                  return null;
                },
                onSaved: (value) {
                  _todoData.title = value?.trim() ?? '';
                },
              ),
            ),

            const SizedBox(height: 24),

            LabeledWidget(
              label: 'Description (facultatif)',
              child: TextFormField(
                initialValue: _todoData.description,
                minLines: 4,
                maxLines: 7,
                decoration: const InputDecoration(
                  hintText: 'Taper la description de la tâche',
                ),
                validator: (value) {
                  if (value != null && value.trim().length > 150) {
                    return 'Maximum 150 caractères';
                  }
                  return null;
                },
                onSaved: (value) {
                  _todoData.description = value?.trim() ?? '';
                },
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ButtonWithSpinner(
                text: widget.isLoading
                    ? widget.loadingButtonLabel
                    : widget.buttonLabel,
                isLoading: widget.isLoading,
                onPressed: widget.isLoading ? null : _handleSubmitForm,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
