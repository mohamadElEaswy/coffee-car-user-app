import 'package:flutter/material.dart';
import 'package:mk/src/ui/theme/theme.dart';

class TotalSection extends StatelessWidget {
  const TotalSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text('Total:', style: AppTheme.boldTextStyle),
        Text('10.00 L.E', style: AppTheme.boldTextStyle),
      ],
    );
  }
}
