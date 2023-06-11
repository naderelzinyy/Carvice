import 'package:flutter/material.dart';

import '../utils/main.colors.dart';

class CustomAlertButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomAlertButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: MainColors.mainColor,
        primary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
