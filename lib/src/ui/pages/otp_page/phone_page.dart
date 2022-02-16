import 'package:flutter/material.dart';
import 'package:mk/src/core/navigation/navigation_methods.dart';
import 'package:mk/src/ui/pages/otp_page/otp_page.dart';
import 'package:mk/src/ui/pages/sign_in_with_email/text_form_field.dart';
import '../../../services/remote/firebase/auth.dart';
import '../sign_in_with_email/email_sign_in_bloc.dart';
import '../sign_in_with_email/global_button.dart';

class PhonePage extends StatelessWidget {
  const PhonePage({Key? key, required this.bloc}) : super(key: key);
  final SignInBloc bloc;

  static const String route = '/phone_page';

  void verifyPress(BuildContext context, AuthBase auth) {
    RouteMethods.navigateAndChange(context: context, routeName: OTPPage.route);
    bloc.submit(context);
  }

  @override
  Widget build(BuildContext context) {
    // final auth = Provider.of<AuthBase>(context, listen: false);
    final TextEditingController phoneController = TextEditingController();
    final FocusNode phoneFocusNode = FocusNode();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
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
              onChanged: (String phoneNumber) {},
              obscureText: false,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.phone,
              hintText: '010000000000000',
            ),
            const SizedBox(height: 16),
            DefaultButton(
              text: 'verify your number',
              color: Colors.indigo,
              onPressed: () => verifyPress,
            ),
            // SizedBox(
            //   width: double.infinity,
            //   child: TextButton(
            //     child: const Text('verify your number'),
            //     onPressed: () => verifyPress,
            //   ),
            // ),
        TextButton(
              child: const Text('change your phone number!'),
              onPressed: (){},
            ),

          ],
        ),
      ),
    );
  }
}
