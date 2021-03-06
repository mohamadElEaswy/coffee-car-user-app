import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk/src/core/model/product_model/product_model.dart';

import '../../../core/bloc/cubit/cubit.dart';
import '../../../core/bloc/states/states.dart';
import '../../colors/static_colors.dart';
import '../../widgets/dash_line.dart';
import '../../widgets/global_button.dart';
import '../../widgets/global_snack_bar.dart';
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
    final items = List<Product>.generate(
      10,
      (i) => Product(
        price: '$i',
        description: 'product description $i',
        category: 'hot drinks',
        name: 'product name $i',
        availability: true,
        id: '$i',
        time: DateTime.now(),
      ),
    );
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is DeleteCartItemSuccessState ||
            state is DeleteCartItemSuccessState) {
          AppCubit.get(context).getTotalPrice();
          GlobalSnackBar.snackBar(
              color: Colors.green,
              text: 'deleted successfully',
              context: context);
        }
      },
      builder: (context, state) {
        AppCubit bloc = AppCubit.get(context);
        if (bloc.cartList.isNotEmpty) {
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
                    itemCount: bloc.cartList.length,
                    itemBuilder: (context, index) {
                      return CartCard(index, bloc);
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
                  TotalSection(bloc.totalPrice),
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
        } else {
          return const Center(
              child: Text('cart is empty, add products to cart first'));
        }
      },
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
