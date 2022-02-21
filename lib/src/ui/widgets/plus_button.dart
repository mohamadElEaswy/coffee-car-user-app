import 'package:flutter/material.dart';
import 'package:mk/src/ui/colors/static_colors.dart';

class PlusButton extends StatelessWidget {
  const PlusButton({Key? key, required this.onTap, required this.text}) : super(key: key);

  // final IconData icon;
  final String text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 31,height: 23,
      decoration: BoxDecoration(
        color: GlobalStaticColors.buttonBrown,

        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(child: Text(text, style:const  TextStyle(color: Colors.white, fontSize: 22),)),
      ),
    );
  }
}
