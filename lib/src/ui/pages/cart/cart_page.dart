import 'package:flutter/material.dart';

import '../../colors/static_colors.dart';
import '../../widgets/dash_line.dart';
import '../../widgets/global_button.dart';
import '../product_detail_page/total_section.dart';
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
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.all(20),
        color: GlobalStaticColors.greyBackground,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Starbucks Car',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return CartCard(items, index);
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Arrival time',
                  style: TextStyle(fontSize: 20),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                    bottom: 10,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  child: const Text('9:00 am'),
                )
              ],
            ),
            const SizedBox(height: 10),
            const MySeparator(color: Colors.grey),
            const SizedBox(height: 20),
            const CartBottomWidgets(),
            const SizedBox(height: 20),
            const CartBottomWidgets(),
            const SizedBox(height: 20),
            const MySeparator(color: Colors.grey),
            const SizedBox(height: 20),
            const TotalSection(),
            const SizedBox(height: 30),
            GlobalButton(
              onPressed: () {},
              text: 'Add to cart',
              color: GlobalStaticColors.deepBlue,
            ),
            const SizedBox(height: 30),
            GlobalButton(
              onPressed: () {},
              text: 'order now',
              color: GlobalStaticColors.buttonBrown,
            ),
          ],
        ),
      ),
    );
  }
}

class CartBottomWidgets extends StatelessWidget {
  const CartBottomWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          const Text(
            'Apply coupon',
            style: TextStyle(color: Colors.grey),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }
}
