import 'package:flutter/material.dart';

import '../../../core/bloc/cubit/cubit.dart';
import '../../../core/model/product_model/product_model.dart';
import '../cart/dismiss_background.dart';

class FavouritesCard extends StatefulWidget {
  const FavouritesCard(this.index, this.bloc, {Key? key}) : super(key: key);

  final int index;
  final AppCubit bloc;
  @override
  State<FavouritesCard> createState() => _FavouritesCardState();
}

class _FavouritesCardState extends State<FavouritesCard> {
  @override
  Widget build(BuildContext context) {
    final List<Product> productList = widget.bloc.allFavouritesList;
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
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}