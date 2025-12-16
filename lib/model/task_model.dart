import 'package:counter_mvc/model/schemas/api_response.dart';
import 'package:counter_mvc/model/domain-object/task.dart';
import 'package:counter_mvc/repository/DAO/task_db_dao.dart';

class TaskModel {
  final TaskDAO _taskDAO = TaskDAO();

  Future<ApiResponse<List<Task>>> getAllTasks({String? titleFilter}) async {
    try {
      await Future.delayed(const Duration(seconds: 2)); // add timeout 2 seconds

      final allTasks = await _taskDAO.getAll();

      if (allTasks.isEmpty) {
        return ApiResponse(data: [], message: 'Aucune tâche chargée');
      }

      return ApiResponse(
        data: titleFilter != null
            ? allTasks
                  .where(
                    (task) => task.title.toLowerCase().contains(
                      titleFilter.toLowerCase(),
                    ),
                  )
                  .toList()
            : allTasks,
        message: 'Toutes les tâches ont été chargées avec succès',
      );
    } catch (err) {
      print("Erreur lors du chargement du JSON: $err");

      return ApiResponse(
        hasError: true,
        message: 'Impossible de charger les tâches.',
      );
    }
  }

  Future<ApiResponse<List<Task>>> createTask({
    required String title,
    required String description,
  }) async {
    try {
      await _taskDAO.add(title: title, description: description);

      return ApiResponse(message: 'Tâche créée avec succès');
    } catch (err) {
      print("Erreur lors de la création de la tâche: $err");

      return ApiResponse(
        hasError: true,
        message: 'Impossible de créér la tâche, veuillez réessayer',
      );
    }
  }

  Future<ApiResponse<List<Task>>> makeTaskDone(int taskId) async {
    try {
      await _taskDAO.toggleDone(taskId);

      return ApiResponse(message: 'Tâche modifiée avec succès');
    } catch (err) {
      print("Erreur lors de la modification de la tâche: $err");

      return ApiResponse(
        hasError: true,
        message: 'Impossible de modifier la tâche, veuillez réessayer',
      );
    }
  }

  Future<ApiResponse<List<Task>>> deleteTask(int taskId) async {
    try {
      await _taskDAO.delete(taskId);

      return ApiResponse(message: 'Tâche supprimée avec succès');
    } catch (err) {
      print("Erreur lors de la suppression de la tâche: $err");

      return ApiResponse(
        hasError: true,
        message: 'Impossible de supprimer la tâche, veuillez réessayer',
      );
    }
  }
}
