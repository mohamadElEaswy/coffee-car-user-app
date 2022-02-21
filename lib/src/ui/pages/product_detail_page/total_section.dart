import 'package:flutter/material.dart';

class TotalSection extends StatelessWidget {
  const TotalSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text('Total:'),
        Text('10.00 L.E'),
      ],
    );
  }
}
