import 'package:flutter/material.dart';

const double defaultHeight = 16.0;
class GlobalSizedBox extends StatelessWidget {
  const GlobalSizedBox({Key? key, this.width = 0, this.height = defaultHeight}) : super(key: key);

  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}
