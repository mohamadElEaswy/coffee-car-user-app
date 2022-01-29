import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {Key? key,
      required this.text,
      this.onPressed,
      this.color = Colors.indigo,
      this.textColor = Colors.white})
      : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0.0),
          backgroundColor: MaterialStateProperty.all<Color>(color),
        ),
      ),
    );
  }
}
