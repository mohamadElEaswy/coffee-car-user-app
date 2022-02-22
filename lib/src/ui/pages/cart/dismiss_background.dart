import 'package:flutter/material.dart';

class DismissibleBackground extends StatelessWidget {
  const DismissibleBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.red,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red,
            ),
            width: 100,
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          Container(color: Colors.grey[200], width: 10),
          Container(
            width: 200,
            decoration: const BoxDecoration(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class SecondDismissibleBackground extends StatelessWidget {
  const SecondDismissibleBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.red,
      ),
      child: Row(
        children: [
          Container(
            width: 200,
            decoration: const BoxDecoration(color: Colors.white),
          ),
          Container(color: Colors.grey[200], width: 10),
          Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red,
              ),
              width: 100,
              child: const Icon(Icons.delete, color: Colors.white)),
        ],
      ),
    );
  }
}
