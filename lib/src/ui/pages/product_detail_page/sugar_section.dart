import 'package:flutter/material.dart';

import '../../colors/static_colors.dart';
import '../../widgets/global_divider.dart';

class SugarSection extends StatelessWidget {
  const SugarSection({Key? key}) : super(key: key);

  void onTap() {}
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sugar', style: Theme.of(context).textTheme.subtitle1),
        const SizedBox(height: 10),
        const MyGlobalDivider(),
        const SizedBox(height: 20),
        Container(padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey[200]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SugarSelect(onTap: onTap),
              SugarSelect(onTap: onTap),
              SugarSelect(onTap: onTap),
              SugarSelect(onTap: onTap),
            ],
          ),
        ),
      ],
    );
  }
}

class SugarSelect extends StatelessWidget {
  const SugarSelect({Key? key, required this.onTap}) : super(key: key);

  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: GlobalStaticColors.deepBlue,
          borderRadius: BorderRadius.circular(4),
        ),
        height: 34,
        width: 70,
        child: const Placeholder(),
      ),
    );
  }
}
