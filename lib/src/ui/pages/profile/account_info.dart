import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/remote/firebase/auth.dart';
import '../../../services/remote/firebase/database.dart';
import '../../widgets/loading_widget.dart';
import 'avatar.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({Key? key}) : super(key: key);
  static const String route = 'account_info';
  @override
  Widget build(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context, listen: false);
    String? profileUrl = auth.currentUser!.photoURL;
    // final Database database = Provider.of<FirestoreDatabase>(context);
    // User user = User.;
    return Consumer<Database>(builder: (context, database, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Account'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(130.0),
            child: _buildUserInfo(database, profileUrl),
          ),
        ),
        body: !database.isLoading
            ? _buildUserDetails(database)
            : const GlobalLoading(),
      );
    });
  }

  Widget _buildUserInfo(Database database, String? profileUrl) {
    return Column(
      children: [
        Avatar(
          radius: 50.0,
          photoUrl: profileUrl,
        ),
        const SizedBox(height: 8.0),
        Text(
          database.userDetailsModel.userName,
          style: const TextStyle(color: Colors.black, fontSize: 16.0),
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }

  Widget _buildUserDetails(Database database) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email: ' + database.userDetailsModel.email,
            style: const TextStyle(color: Colors.black, fontSize: 16.0),
          ),
          const SizedBox(height: 8),
          Text(
            'Phone: ' + database.userDetailsModel.phoneNumber!,
            style: const TextStyle(color: Colors.black, fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
