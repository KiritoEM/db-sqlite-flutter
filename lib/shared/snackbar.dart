import 'package:flutter/material.dart';

class SnackbarUtils {
  static void showInSnackBar(BuildContext context, String value) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ),
    );
  }
}
