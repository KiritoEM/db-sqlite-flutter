import 'package:flutter/material.dart';

class CustomBottomsheet {

  static Future displaybottomsheet(BuildContext context) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) => Container(
        height: 300,
        width: double.infinity,
        child: Column(
          children: [
            Text('hello'),
            Text('hello'),
            Text('hello'),
            Text('hello'),
            Text('hello'),
            Text('hello'),
          ],
        ),
      ),
    );
  }
}
