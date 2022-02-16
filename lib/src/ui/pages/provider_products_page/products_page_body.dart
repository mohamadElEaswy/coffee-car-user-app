import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AllProductsPage extends StatelessWidget {
  const AllProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(left: 16, right: 16),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      physics: const BouncingScrollPhysics(),
      itemCount: 50,
      itemBuilder: (context, index) {
        return ProductGridItem(index);
      },
    );
  }
}

class ProductGridItem extends StatelessWidget {
  const ProductGridItem(this.index, {Key? key}) : super(key: key);

  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding:const EdgeInsets.only(right: 20, left: 20),
                child:const SizedBox(
                    height: 80,
                    width: 80,
                    child: Placeholder(
                      color: Colors.black38,
                    )),
              ),
              InkWell(onTap: () {}, child: const Icon(FontAwesomeIcons.heart))
            ],
          ),
          const Text('Espresso'),
          Container(padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              // border: Border.all(),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,mainAxisSize: MainAxisSize.min,
              children: [
                const Text('10.00 EGP'),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    // border: Border.all(),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(),
        ],
      ),
    );
  }
}
