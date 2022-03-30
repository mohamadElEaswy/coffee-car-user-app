import 'package:flutter/material.dart';
import 'package:mk/src/ui/theme/theme.dart';

class TotalSection extends StatelessWidget {
  const TotalSection(this.totalPrice, {Key? key}) : super(key: key);

  final double totalPrice;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Total:', style: AppTheme.boldTextStyle),
        Text('$totalPrice', style: AppTheme.boldTextStyle),
      ],
    );
  }
}
