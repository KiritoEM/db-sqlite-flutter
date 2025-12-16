// ignore_for_file: void_checks, unnecessary_nullable_for_final_variable_declarations

import 'package:counter_mvc/model/schemas/api_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  String username;
  String firstname;
  bool isAuthentificated;

  User({
    required this.username,
    required this.firstname,
    required this.isAuthentificated,
  });
}

class UserModel {
  //add username into shared preferences
  Future<ApiResponse<void>> saveUsername(String username) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);

      return ApiResponse(message: 'Bienvenue sur Tacheko $username');
    } catch (err) {
      print(
        'Une erreur s\'est produite lors de l\'enregistrement du nom de l\'utilisateur: ${err}',
      );
      return ApiResponse(
        hasError: true,
        message:
            'Une erreur s\'est produite lors de l\'enregistrement du nom de l\'utilisateur',
      );
    }
  }

  Future<ApiResponse<String?>> getUsername() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? username = prefs.getString('username');

      print("username: ${username}");

      return ApiResponse(
        data: username,
        message: 'Nom \'utilisateur recupere avec success',
      );
    } catch (err) {
      print(
        'Une erreur s\'est produite lors de la recuperation du nom de l\'utilisateur: ${err}',
      );
      return ApiResponse(
        hasError: true,
        message:
            'Une erreur s\'est produite lors de la recuperation du nom de l\'utilisateur',
      );
    }
  }

  Future<ApiResponse<String?>> removeUsername() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('username');

      return ApiResponse(message: 'Utilisateur deconnecte avec success');
    } catch (err) {
      print(
        'Une erreur s\'est produite lors de la suppression du nom de l\'utilisateur: ${err}',
      );
      return ApiResponse(
        hasError: true,
        message:
            'Une erreur s\'est produite lors de la suppression du nom de l\'utilisateur',
      );
    }
  }
}
