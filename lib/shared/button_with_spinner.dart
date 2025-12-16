import 'package:flutter/material.dart';

class ButtonWithSpinner extends StatelessWidget {
  final String text;
  final bool isLoading;
  final VoidCallback? onPressed;
  final ButtonStyle? style;

  const ButtonWithSpinner({
    super.key,
    required this.text,
    this.isLoading = false,
    this.onPressed,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: style,
      onPressed: isLoading ? null : onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          if (isLoading)
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            ),
          Text(text),
        ],
      ),
    );
  }
}
