import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mk/src/ui/pages/sign_in_with_email/global_button.dart';
import 'package:mk/src/ui/pages/sign_in_with_email/sign_in_model.dart';
import 'package:mk/src/ui/pages/sign_in_with_email/text_form_field.dart';
import '../../widgets/exceptions.dart';
import 'email_sign_in_bloc.dart';

class SignInWithEmail extends StatefulWidget {
  const SignInWithEmail({Key? key}) : super(key: key);
  static const String route = 'sign_in_and_register';

  @override
  State<SignInWithEmail> createState() => _SignInWithEmailState();
}

class _SignInWithEmailState extends State<SignInWithEmail> {
  final EmailSignInBloc bloc = EmailSignInBloc();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  void _emailEditingComplete(EmailSignInModel model) {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  Future<void> _submit() async {
    try {
      await bloc.submit();
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      // showAlertDialog(context, title: 'sign in failed', content: e.message!, defaultActionString: 'OK');

      showExceptionDialog(
        context,
        title: 'sign in failed',
        exception: e,
      );
    }
  }

  void _toggleFormType() {
    bloc.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren(EmailSignInModel? model) {
    final String primaryText = model!.formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';
    final String secondaryText = model.formType == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';
    bool submitEnabled = model.emailValidator.isValid(model.email) &&
        model.emailValidator.isValid(model.password) &&
        !model.isLoading;

    return [
      Text(
        'Login',
        style: Theme.of(context).textTheme.headline4,
      ),
      const SizedBox(height: 8),
      if (model.formType == EmailSignInFormType.register)
        GlobalTextFormField(
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            hintText: 'Mohamed',
            controller: _nameController,
            lable: 'user name',
            errorText: model.emailErrorText,
            enabled: model.isLoading == false,
            obscureText: false,
            focusNode: _nameFocusNode,
            onEditingComplete: () => _emailEditingComplete(model),
            onChanged: bloc.updateEmail,
            iconData: Icons.email_outlined),
      const SizedBox(height: 8),
      GlobalTextFormField(
        textInputType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        hintText: 'test@test.com',
        controller: _emailController,
        lable: 'Email',
        errorText: model.emailErrorText,
        enabled: model.isLoading == false,
        obscureText: false,
        focusNode: _emailFocusNode,
        onEditingComplete: () => _emailEditingComplete(model),
        onChanged: bloc.updateEmail,
        iconData: Icons.email_outlined,
      ),
      const SizedBox(height: 8),
      GlobalTextFormField(
        textInputType: TextInputType.number,
        textInputAction: TextInputAction.done,
        controller: _passwordController,
        lable: 'Password',
        errorText: model.passwordErrorText,
        enabled: model.isLoading == false,
        obscureText: model.passwordVisibility,
        focusNode: _passwordFocusNode,
        onEditingComplete: model.submitEnabled ? _submit : null,
        onChanged: bloc.updatePassword,
        iconData: Icons.password,
        suffix: Icons.password_outlined,
        suffixPressed: bloc.changePasswordVisibility,
      ),
      const SizedBox(height: 8),
      DefaultButton(
        text: model.primaryText,
        color: Colors.indigo,
        onPressed: model.submitEnabled ? _submit : null,
      ),
      // ElevatedButton(onPressed: () {}, child: const Text('Sign in')),
      const SizedBox(height: 8),
      TextButton(
          onPressed: !model.isLoading ? _toggleFormType : null,
          child: Text(model.secondaryText)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign in With Email')),
      body: SingleChildScrollView(
        child: StreamBuilder<EmailSignInModel>(
            stream: bloc.modelStream,
            initialData: EmailSignInModel(),
            builder: (context, snapshot) {
              EmailSignInModel? model = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: _buildChildren(model!),
                ),
              );
            }),
      ),
    );
  }
}
