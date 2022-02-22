import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/navigation/navigation_methods.dart';
import '../product_detail_page/product_detail_page.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem(this.index, {Key? key}) : super(key: key);

  final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => RouteMethods.navigateTo(
          context: context, routeName: ProductDetailPage.route),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 10.0,
              spreadRadius: 1.0,
              offset: const Offset(10.0, 10.0),
            ),
          ],
        ),
        margin: const EdgeInsets.all(10),
        child: Stack(
          // fit: StackFit.passthrough,
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: -16,
              child: Container(
                decoration: const BoxDecoration(
                    // color: Colors.red,

                    ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 16, left: 16),
                      child: const SizedBox(
                          height: 80,
                          width: 70,
                          child: Placeholder(
                            color: Colors.black38,
                          )),
                    ),
                    InkWell(
                        onTap: () {}, child: const Icon(FontAwesomeIcons.heart))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Espresso', style: TextStyle(color: Colors.black)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // border: Border.all(),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
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
            )
          ],
        ),
      ),
    );
  }
}
