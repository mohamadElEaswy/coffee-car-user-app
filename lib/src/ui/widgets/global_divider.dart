import 'package:flutter/material.dart';

import '../colors/static_colors.dart';

class MyGlobalDivider extends StatelessWidget {
  const MyGlobalDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(color: GlobalStaticColors.dividerColor, height: 4);
  }
}
