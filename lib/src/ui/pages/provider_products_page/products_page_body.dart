import 'package:flutter/material.dart';
import 'grid_item.dart';

class AllProductsPage extends StatelessWidget {
  const AllProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return GridView.builder(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
          ),
          physics: const BouncingScrollPhysics(),
          itemCount: 50,
          itemBuilder: (context, index) {
            return ProductGridItem(index);
          },
        );
      },
    );
  }
}


