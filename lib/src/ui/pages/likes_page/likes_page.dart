import 'package:flutter/material.dart';

class LikesPage extends StatelessWidget {
  const LikesPage({Key? key}) : super(key: key);
  static const String route = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SingleChildScrollView(
        child: Center(
          child: Text('profile Page'),
        ),
      ),
    );
  }
}
