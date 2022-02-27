import 'package:flutter/material.dart';

import '../../core/assets/assets.dart';
import '../colors/static_colors.dart';

class GlobalTextButton extends StatelessWidget {
  const GlobalTextButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      required this.imagePath})
      : super(key: key);

  final VoidCallback? onPressed;
  final String text;
  final String imagePath;
  // final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(GlobalStaticColors.greyColor!),
            elevation: MaterialStateProperty.all(.8),
            foregroundColor:
                MaterialStateProperty.all<Color>(GlobalStaticColors.greyColor!),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 25,
                  height: 25,
                  child: Image(image: AssetImage(imagePath))),
              const SizedBox(width: 16),
              Text(
                text,
                style: const TextStyle(color: Colors.black),
              ),
            ],
          )),
    );
  }
}
