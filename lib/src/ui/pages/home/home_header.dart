import 'package:flutter/material.dart';

import '../../colors/static_colors.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key, required this.width}) : super(key: key);
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.all(8),
      // decoration: BoxDecoration(
      // borderRadius: BorderRadius.circular(8),
      // color: Colors.white,
      // ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: InkWell(
              onTap: () {},
              // overlayColor: MaterialStateProperty.all(Colors.white),
              child: const Icon(
                Icons.segment,
                color: GlobalStaticColors.deebBlue,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: 42,
            width: width - 124,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: InkWell(
              onTap: () {},
              // overlayColor: MaterialStateProperty.all(Colors.white),
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(
                      Icons.search,
                      color: GlobalStaticColors.deebBlue,
                    ),
                  ),
                  Text('Search by name'),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: 42,
            width: 42,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: InkWell(
              onTap: () {},
              // overlayColor: MaterialStateProperty.all(Colors.white),
              child: const Icon(
                Icons.filter_list,
                color: GlobalStaticColors.deebBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
