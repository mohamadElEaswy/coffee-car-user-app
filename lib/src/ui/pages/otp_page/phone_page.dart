import 'package:flutter/material.dart';
import 'package:mk/src/core/navigation/navigation_methods.dart';
import 'package:mk/src/ui/pages/otp_page/otp_page.dart';
import 'package:mk/src/ui/pages/sign_in_with_email/text_form_field.dart';
import 'package:provider/provider.dart';
import '../../../services/remote/firebase/auth.dart';
import '../sign_in_with_email/email_sign_in_bloc.dart';
import '../sign_in_with_email/global_button.dart';

class PhonePage extends StatefulWidget {
  const PhonePage({Key? key}) : super(key: key);
  static const String route = '/phone_page';

  @override
  State<PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  final SignInBloc bloc = SignInBloc();

  late String number;

  void verifyPress(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    auth.submitPhoneNumber(phoneNumber: number);
    RouteMethods.navigateAndChange(
        context: context, routeName: OTPPage.route, args: number);
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneController = TextEditingController();
    final FocusNode phoneFocusNode = FocusNode();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'confirm your phone number',
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(height: 16),
            GlobalTextFormField(
              controller: phoneController,
              lable: 'phone number \'010000000\'',
              errorText: 'phone number is required',
              enabled: true,
              focusNode: phoneFocusNode,
              onEditingComplete: () {},
              onChanged: (String phoneNumber) => number = phoneNumber,
              obscureText: false,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.phone,
              hintText: '010000000000000',
            ),
            const SizedBox(height: 16),
            DefaultButton(
              text: 'verify your number',
              color: Colors.indigo,
              onPressed: () => verifyPress(context),
            ),
            TextButton(
              child: const Text('change your phone number!'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
