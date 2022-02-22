import 'package:flutter/material.dart';

import '../../widgets/plus_button.dart';

class TitleSection extends StatelessWidget {
  const TitleSection({Key? key}) : super(key: key);

  void onTap(){print('1');}
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Espresso', style: Theme.of(context).textTheme.headline5),
            const SizedBox(height: 10),
            Text('100 L.E', style: Theme.of(context).textTheme.subtitle1),
          ],
        ),
        const Spacer(),
        Container (
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20)
          ),
          // width: 50,
          child: Row(
            children: [
              PlusButton(
                text: '-',
                onTap: onTap,
              ),const SizedBox(width: 16),
              // TextButton(onPressed: actionButtonPress, child: const Text('-')),
              const Text('1'),
              const SizedBox(width: 16),
              PlusButton(
                text: '+',
                onTap: onTap,
              ),
            ],
          ),
        )
      ],
    );
  }
}
