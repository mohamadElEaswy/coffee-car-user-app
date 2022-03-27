import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk/src/core/assets/assets.dart';
import 'package:mk/src/core/bloc/cubit/cubit.dart';
import 'package:mk/src/core/bloc/states/states.dart';
import 'package:mk/src/core/model/user_details_model/user_details_model.dart';

import '../../widgets/loading_widget.dart';
import 'avatar.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({Key? key}) : super(key: key);
  static const String route = 'account_info';

  @override
  Widget build(BuildContext context) {
    // final AuthBase auth = Provider.of<AuthBase>(context, listen: false);
    // String? profileUrl = auth.currentUser!.photoURL;
    // final Database database = Provider.of<FirestoreDatabase>(context);
    // User user = User.;
    // return Consumer<Database>(builder: (context, database, child) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit bloc = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Account'),
            // bottom: PreferredSize(
            //   preferredSize: const Size.fromHeight(130.0),
            //   child: _buildUserInfo(database),
            // ),
          ),
          body: FutureBuilder(
            future: bloc.getUserData(),
            builder:
                (BuildContext context, AsyncSnapshot<UserDetails> snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? const GlobalLoading()
                  : _buildUserDetails(snapshot.data!);
            },
          ),
        );
      },
    );
    // }
    // );
  }

  // Widget _buildUserInfo(UserDetails userDetails) {
  //   return Column(
  //     children: [
  //
  //     ],
  //   );
  // }

  Widget _buildUserDetails(UserDetails userDetails) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Avatar(
            radius: 50.0,
            photoUrl: AppAssets.carIcon,
          ),
          const SizedBox(height: 8.0),
          Text(
            userDetails.userName,
            style: const TextStyle(color: Colors.black, fontSize: 16.0),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Email: ' + userDetails.email,
            style: const TextStyle(color: Colors.black, fontSize: 16.0),
          ),
          const SizedBox(height: 8),
          Text(
            'Phone: ' + userDetails.phoneNumber!,
            style: const TextStyle(color: Colors.black, fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
