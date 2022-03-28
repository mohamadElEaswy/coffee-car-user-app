import 'package:flutter/material.dart';

class GlobalSnackBar {
  static snackBar({required Color color, required String text, required BuildContext context}) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(text),
        backgroundColor: color,
      ));
}