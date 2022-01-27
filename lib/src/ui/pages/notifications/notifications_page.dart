import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);
  static const String route = '/profile';

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
        child: Center(
          child: Text('Notifications Page'),
        ),
      );
  }
}
