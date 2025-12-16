// ignore_for_file: use_build_context_synchronously

import 'package:counter_mvc/model/user_model.dart';
import 'package:counter_mvc/shared/snackbar.dart';
import 'package:flutter/material.dart';

class UserViewmodel extends ChangeNotifier {
  final UserModel _userModel = UserModel();
  String _error = '';
  String? _username;

  // Getters
  String? get username => _username;
  String? get error => _error;
  bool get isAuthenticated => _username != null && _username!.isNotEmpty;

  Future<void> saveUserName(String username, BuildContext context) async {
    final saveUserNameResponse = await _userModel.saveUsername(username);

    if (saveUserNameResponse.hasError == true) {
      _error = saveUserNameResponse.message!;
      SnackbarUtils.showInSnackBar(context, _error);
      notifyListeners();
      return;
    }

    _username = username;
    SnackbarUtils.showInSnackBar(context, saveUserNameResponse.message!);
    Navigator.of(context).pushNamed('/list');
    notifyListeners();
  }

  Future<void> deleteUsername(BuildContext context) async {
    final saveUserNameResponse = await _userModel.removeUsername();

    if (saveUserNameResponse.hasError == true) {
      _error = saveUserNameResponse.message!;
      SnackbarUtils.showInSnackBar(context, _error);
      notifyListeners();
      return;
    }

    _username = username;
    SnackbarUtils.showInSnackBar(context, saveUserNameResponse.message!);
    Navigator.of(context).pushNamed('/login');
    notifyListeners();
  }

  Future<void> getUsername() async {
    _username = '';

    final getUsernameResponse = await _userModel.getUsername();

    if (getUsernameResponse.hasError == true) {
      _error = getUsernameResponse.message!;
      notifyListeners();
      return;
    }

    _username = getUsernameResponse.data;
    notifyListeners();
  }
}
