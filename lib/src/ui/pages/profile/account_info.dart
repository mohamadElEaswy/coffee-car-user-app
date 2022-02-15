import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/remote/firebase/auth.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({Key? key}) : super(key: key);
  static const String route = 'account_info';
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(130.0),
          child: _buildUserInfo(auth.currentUser!),
        ),
      ),
      body: _buildUserDetails(auth.currentUser!),
    );
  }

  Widget _buildUserInfo(User user) {
    return Column(
      children: [
        // Avatar(
        //   radius: 50.0,
        //   photoUrl: user.photoURL,
        // ),
        const SizedBox(height: 8.0),
        if (user.displayName != null)
          Text(
            user.displayName!,
            style: const TextStyle(color: Colors.black, fontSize: 16.0),
          ),
        const SizedBox(height: 8.0),
      ],
    );
  }

  Widget _buildUserDetails(User user) {print(user.phoneNumber!);print('user.phoneNumber!');
    TextEditingController nameController =
        TextEditingController(text: user.displayName!);
    TextEditingController phoneController =
        TextEditingController(text: user.phoneNumber!);
    // nameController.text = user.displayName!;
    FocusNode focusNode = FocusNode();
    FocusNode phoneFocusNode = FocusNode();
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [

          Text(user.phoneNumber!, style: const TextStyle(color: Colors.black)),
          // Text('user.phoneNumber!',style: const TextStyle(color: Colors.black)),
          // GlobalTextFormField(
          //   controller: nameController,
          //   lable: 'user name',
          //   errorText:
          //       user.displayName!.isEmpty | nameController.text.isEmpty ? 'User name is required' : null,
          //   enabled: true,
          //   focusNode: focusNode,
          //   onEditingComplete: () {
          //     if (nameController.text.isNotEmpty) {
          //       user.updateDisplayName(nameController.text);
          //     }else{}
          //   },
          //   onChanged: (String name) {},
          //   obscureText: false,
          //   textInputAction: TextInputAction.done,
          //   textInputType: TextInputType.text,
          // ),
          // GlobalTextFormField(
          //   controller: phoneController,
          //   lable: 'user name',
          //   errorText:
          //       user.phoneNumber!.isEmpty | phoneController.text.isEmpty ? 'User name is required' : null,
          //   enabled: true,
          //   focusNode: phoneFocusNode,
          //   onEditingComplete: () {
          //     if (phoneController.text.isNotEmpty) {
          //       user.updatePhoneNumber();
          //     }else{}
          //   },
          //   onChanged: (String name) {},
          //   obscureText: false,
          //   textInputAction: TextInputAction.done,
          //   textInputType: TextInputType.text,
          // ),
        ],
      ),
    );
  }
}
