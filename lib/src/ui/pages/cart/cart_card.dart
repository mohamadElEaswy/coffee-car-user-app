import 'package:flutter/material.dart';
import '../../../core/model/product_model/product_model.dart';
import '../../widgets/plus_button.dart';
import 'dismiss_background.dart';

class CartCard extends StatefulWidget {
  const CartCard(this.items, this.index, {Key? key}) : super(key: key);

  final List<Product> items;
  final int index;
  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    final item = widget.items[widget.index];
    return Dismissible(
      key: Key(item.id),
      onDismissed: (direction) {
        setState(() {
          widget.items.removeAt(widget.index);
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$item dismissed')));
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
                  const Text('Espresso'),
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




