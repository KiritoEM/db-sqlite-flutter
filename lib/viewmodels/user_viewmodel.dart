// ignore_for_file: use_build_context_synchronously

import 'package:counter_mvc/model/schemas/vm_result.dart';
import 'package:counter_mvc/model/user_model.dart';
import 'package:flutter/material.dart';

class UserViewmodel extends ChangeNotifier {
  final UserModel _userModel = UserModel();
  String? _username;
  String _error = '';

  // Getters
  String? get username => _username;
  String get error => _error;
  bool get isAuthenticated => _username != null && _username!.isNotEmpty;

  Future<VmResponse> saveUserName(String username) async {
    final saveUserNameResponse = await _userModel.saveUsername(username);

    if (saveUserNameResponse.hasError == true) {
      notifyListeners();
      return VmResponse(message: saveUserNameResponse.message);
    }

    _username = username;
    notifyListeners();

    return VmResponse(message: saveUserNameResponse.message, isSuccess: true);
  }

  Future<String?> deleteUsername() async {
    final saveUserNameResponse = await _userModel.removeUsername();

    if (saveUserNameResponse.hasError == true) {
      notifyListeners();
      return saveUserNameResponse.message;
    }

    _username = username;
    notifyListeners();

    return null;
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
