import 'package:flutter/services.dart';

class TaskJsonDao {
  final String jsonPath = 'assets/jsons/task.json';

  //load JSON data
  Future<String> loadJSONData() async {
    final String response = await rootBundle.loadString(jsonPath);
    // ignore: dead_code, unnecessary_null_comparison
    if (response == null) {
      throw Exception('Failed to load JSON data');
    }
    return response;
  }
}
