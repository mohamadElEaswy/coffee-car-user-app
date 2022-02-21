import 'package:flutter/material.dart';
import 'package:mk/src/ui/pages/sign_in_with_email/text_form_field.dart';
import 'package:mk/src/ui/widgets/global_button.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  static const String route ='/forget_password_page';
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    FocusNode _focusNode = FocusNode();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const Text('Forget password?'),
            const SizedBox(height: 20),
            const Text('you will receive an email'),
            const SizedBox(height: 40),
            GlobalTextFormField(
              controller: _controller,
              lable: 'Email',
              errorText: 'email is required',
              enabled: true,
              focusNode: _focusNode,
              onEditingComplete: () {},
              onChanged: (String email) {},
              obscureText: false,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 40),
            GlobalButton(onPressed: () {}, text: 'Reset password'),
          ],
        ),
      ),
    );
  }
}
