import 'package:flutter/material.dart';

import '../../colors/static_colors.dart';
import 'cart_card.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  // static const String route = '/cart';
  @override
  Widget build(BuildContext context) {
    final items = List<String>.generate(20, (i) => 'Item ${i + 1}');
    return Container(color: GlobalStaticColors.greyBackground,
      child: ListView.builder(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return CartCard(items, index);
        },
      ),
    );
  }
}
