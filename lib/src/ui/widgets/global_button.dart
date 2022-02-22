import 'package:flutter/material.dart';


class GlobalButton extends StatelessWidget {
  const GlobalButton(
      {Key? key, required this.onPressed, required this.text, this.color})
      : super(key: key);

  final void Function()? onPressed;
  final String text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
            elevation: MaterialStateProperty.all(0)),
        child: Text(
          text,
          // style: AppTheme.dynamicTextStyle(15, Colors.white, FontWeight.bold),
        ),
      ),
    );
  }
}
