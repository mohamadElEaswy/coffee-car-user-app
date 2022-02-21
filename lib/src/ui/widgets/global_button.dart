import 'package:flutter/material.dart';

class GlobalButton extends StatelessWidget {
  const GlobalButton({Key? key, required this.onPressed, required this.text})
      : super(key: key);

  final void Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
            onPressed: onPressed,
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 22),
            )));
  }
}
