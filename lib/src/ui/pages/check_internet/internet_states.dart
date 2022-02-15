import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/remote/internet_connection_status/network_status_service.dart';
import 'network_aware_widget.dart';
//check the internet connection
class InternetCheck extends StatelessWidget {
  const InternetCheck({Key? key, required this.online}) : super(key: key);
  static const String route = 'check';
  final Widget online;
  @override
  Widget build(BuildContext context) {
    return StreamProvider<NetworkStatus>(
        initialData: NetworkStatus.offline,
        create: (context) =>
            NetworkStatusService().networkStatusController.stream,
        child:NetworkAwareWidget(
          offlineChild: const InternetError(),
          onlineChild: online,
        ));
  }
}
//check if the user have a phone number
// class UserStatus extends StatelessWidget {
//   static const String route = '/check';
//   const UserStatus({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final auth = Provider.of<AuthBase>(context, listen: false);
//     return StreamBuilder<User?>(
//       stream: auth.authUserState(),
//       builder: (context, snapshot) {
//         final User? user = snapshot.data;
//         if (snapshot.connectionState == ConnectionState.active) {
//           if (user != null) {
//             return const Home(title: 'Coffee car');
//           } else if (user == null &&
//               snapshot.connectionState == ConnectionState.active) {
//             return const SignInWithEmailAndPhone();
//           } else {
//             return const InternetError();
//           }
//         } else {
//           return const InternetError();
//         }
//       },
//     );
    // if (auth.currentUser!.phoneNumber!.isNotEmpty) {
    //   return const Home(title: 'title');
    // } else {
    //   return const SignInWithEmailAndPhone();
    // }
//   }
// }

class InternetError extends StatelessWidget {
  const InternetError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child:
              Text('No internet connection, please connect to the internet')),
    );
  }
}

// class LandingPage extends StatelessWidget {
//   const LandingPage({Key? key}) : super(key: key);
//   static const String route = '/landing_page';
//   @override
//   Widget build(BuildContext context) {
//     final auth = Provider.of<AuthBase>(context, listen: false);
//     return StreamBuilder<User?>(
//       stream: auth.authUserState(),
//       builder: (context, snapshot) {
//         final User? user = snapshot.data;
//         if (snapshot.connectionState == ConnectionState.active) {
//           if (user == null) {
//             return SignInWithEmailAndPhone();
//           } else {
//             return const Home(title: '',);
//           }
//         } else {
//           return const InternetError();
//         }
//       },
//     );
//   }
// }