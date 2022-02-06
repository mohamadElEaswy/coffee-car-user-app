import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/remote/internet_connection_status/network_status_service.dart';
import '../home/home_page.dart';
import 'network_aware_widget.dart';

class InternetCheck extends StatelessWidget {
  const InternetCheck({Key? key}) : super(key: key);
  static const String route = 'check';

  @override
  Widget build(BuildContext context) {
    return StreamProvider<NetworkStatus>(
        initialData: NetworkStatus.offline,
        create: (context) =>
        NetworkStatusService().networkStatusController.stream,
        child: const NetworkAwareWidget(
          offlineChild: Scaffold(
            body: Center(child: Text('No internet connection')),
          ),
          onlineChild: Home(title: 'title'),
        ));
  }
}