import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/plus_button.dart';

class CartCard extends StatefulWidget {
  const CartCard(this.items, this.index, {Key? key}) : super(key: key);

  final List items;
  final int index;
  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    final item = widget.items[widget.index];
    return Dismissible(
      key: Key(item),
      onDismissed: (direction) {
        setState(() {
          widget.items.removeAt(widget.index);
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$item dismissed')));
      },
      background: Container(
        width: 100,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Card(
        child: Container(padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              const SizedBox(
                height: 100,
                width: 80,
                child: Placeholder(),
              ),
              const SizedBox(width: 16,),
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  const Text('Espresso'),
                  const SizedBox(height: 4),
                  const Text('350 m'),
                  const SizedBox(height: 25),
                  Container (
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20)
                    ),
                    // width: 50,
                    child: Row(
                      children: [
                        PlusButton(
                          text: '-',
                          onTap: (){},
                        ),const SizedBox(width: 16),
                        // TextButton(onPressed: actionButtonPress, child: const Text('-')),
                        const Text('1'),
                        const SizedBox(width: 16),
                        PlusButton(
                          text: '+',
                          onTap: (){},
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
/*
ListTile(
          leading: const SizedBox(
            height: 100,
            width: 80,
            child: Placeholder(),
          ),
          title: Row(
            children: [
              Text(widget.items[widget.index]),
              const Spacer(),
              Text(widget.items[widget.index]),
            ],
          ),
          subtitle: const Text('350 m'),
        ),
*/