import 'package:flutter/material.dart';

class LabeledWidget extends StatelessWidget {
  final String label;
  final Widget child;

  const LabeledWidget({super.key, required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),

        child,
      ],
    );
  }
}
