import 'package:flutter/material.dart';
import 'package:mk/src/ui/widgets/global_divider.dart';

import '../../colors/static_colors.dart';

class SizeSection extends StatelessWidget {
  const SizeSection({Key? key}) : super(key: key);

  void onTap(){}
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Size'),
        const SizedBox(height: 10),
        const MyGlobalDivider(),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizeSelect(onTap: onTap,text: '250'),
            SizeSelect(onTap: onTap,text: '350'),
            SizeSelect(onTap: onTap,text: '450'),
          ],
        )
      ],
    );
  }
}

class SizeSelect extends StatelessWidget {
  const SizeSelect({Key? key, required this.onTap, required this.text}) : super(key: key);

  final void Function()? onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          const SizedBox(
            height: 70,
            width: 50,
            child: Placeholder(),
          ),
          const SizedBox(height: 10),
          Text(text),
        ],
      ),
    );
  }
}
