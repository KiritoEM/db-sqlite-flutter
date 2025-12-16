import 'package:counter_mvc/constants/enums.dart';
import 'package:flutter/material.dart';

class SnackbarUtils {
  static void showInSnackBar(
    BuildContext context,
    String value, {
    SnackbarType type = SnackbarType.success,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        backgroundColor: _getSnackbarColor(type),
        duration: Duration(seconds: 3),
      ),
    );
  }

  static Color _getSnackbarColor(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return Colors.green;
      case SnackbarType.error:
        return Colors.red;
      case SnackbarType.warning:
        return Colors.yellow;
      case SnackbarType.info:
        return Colors.blue;
    }
  }
}
