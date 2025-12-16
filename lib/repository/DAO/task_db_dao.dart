import 'package:counter_mvc/model/domain-object/task.dart';
import 'package:counter_mvc/repository/configs/database_helper.dart';

class TaskDAO {
  Future<List<Task>> getAll() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map> data = await db.query('tasks');
    return data.map((m) => Task.fromMap(m)).toList();
  }

  Future add({required String title, required String description}) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert('tasks', {'title': title, 'description': description});
  }

  Future<int> toggleDone(int id) async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.query(
      'tasks',
      columns: ['done'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isEmpty) {
      throw Exception('Tâche non trouvée');
    }

    final currentDone = result.first['done'] as int;
    final newDone = currentDone == 1 ? 0 : 1;

    return await db.update(
      'tasks',
      {'done': newDone},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
