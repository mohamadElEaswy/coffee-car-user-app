import 'package:flutter/material.dart';
import '../../../core/bloc/cubit/cubit.dart';
import '../../../core/model/product_model/product_model.dart';
import '../../widgets/plus_button.dart';
import 'dismiss_background.dart';

class CartCard extends StatefulWidget {
  const CartCard(this.index, this.bloc, {Key? key}) : super(key: key);

  final int index;
  final AppCubit bloc;
  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    final List<Product> productList = widget.bloc.cartList;
    final Product product = productList[widget.index];

    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        widget.bloc
            .deleteCartItem(deletedItemId: product.id)
            .then((value) => productList.removeAt(widget.index));

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${product.name} deleted successfully')));
      },
      background: const DismissibleBackground(),
      secondaryBackground: const SecondDismissibleBackground(),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              const SizedBox(
                height: 100,
                width: 80,
                child: Placeholder(),
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name),
                  const SizedBox(height: 4),
                  const Text('350 m'),
                  const SizedBox(height: 25),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20)),
                    // width: 50,
                    child: Row(
                      children: [
                        PlusButton(
                          text: '-',
                          onTap: () {},
                        ),
                        const SizedBox(width: 16),
                        // TextButton(onPressed: actionButtonPress, child: const Text('-')),
                        const Text('1'),
                        const SizedBox(width: 16),
                        PlusButton(
                          text: '+',
                          onTap: () {},
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
