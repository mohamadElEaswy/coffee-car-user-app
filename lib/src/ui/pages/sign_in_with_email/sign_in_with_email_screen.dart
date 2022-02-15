import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mk/src/ui/pages/home/home_page.dart';
import 'package:mk/src/ui/pages/sign_in_with_email/global_button.dart';
import 'package:mk/src/ui/pages/sign_in_with_email/sign_in_model.dart';
import 'package:mk/src/ui/pages/sign_in_with_email/text_form_field.dart';
import 'package:provider/provider.dart';
import '../../../core/navigation/navigation_methods.dart';
import '../../widgets/exceptions.dart';
import 'email_sign_in_bloc.dart';

class SignInWithEmailAndPhone extends StatefulWidget {
  SignInWithEmailAndPhone({Key? key}) : super(key: key);
  static const String route = 'sign_in_and_register';
  // final AuthBase? auth;
  final SignInBloc? bloc = SignInBloc();
  // final SignInBloc bloc = SignInBloc(auth: auth);
  @override
  State<SignInWithEmailAndPhone> createState() =>
      _SignInWithEmailAndPhoneState();
}

class _SignInWithEmailAndPhoneState extends State<SignInWithEmailAndPhone> {
  // final AuthBase auth = Provider.of<AuthBase>(context, listen: false);

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
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  void _emailEditingComplete(SignInModel model) {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _phoneFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _phoneEditingComplete(SignInModel model) {
    final newFocus = model.phoneValidator.isValid(model.phone)
        ? _passwordFocusNode
        : _phoneFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  Future<void> _submit() async {
    try {
      await widget.bloc!.submit(context);
      // Navigator.of(context).pop();
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
    widget.bloc!.toggleFormType();
    _emailController.clear();
    _phoneController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren(SignInModel? model) {

    final String formTitleText = model!.formType == SignInFormType.signIn
        ? 'Log in'
        : 'Register';



    return [
      const SizedBox(height: 50),
      Text(
        formTitleText,
        style: Theme.of(context).textTheme.headline4,
      ),
      const SizedBox(height: 8),
      if (model.formType == SignInFormType.register)
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
            onChanged: widget.bloc!.updatePhone,
            iconData: Icons.email_outlined),
      const SizedBox(height: 8),
      // if (model.formType == SignInFormType.register)
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
          onChanged: widget.bloc!.updateEmail,
          iconData: Icons.email_outlined,
        ),
      const SizedBox(height: 8),
      if (model.formType == SignInFormType.register)
        GlobalTextFormField(
        textInputType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        hintText: '01000000000',
        controller: _phoneController,
        lable: 'phone number',
        errorText: model.phoneErrorText,
        enabled: model.isLoading == false,
        obscureText: false,
        focusNode: _phoneFocusNode,
        onEditingComplete: () => _phoneEditingComplete(model),
        onChanged: widget.bloc!.updatePhone,
        iconData: Icons.phone_iphone_outlined,
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
        onChanged: widget.bloc!.updatePassword,
        iconData: Icons.password,
        suffix: Icons.password_outlined,
        suffixPressed: widget.bloc!.changePasswordVisibility,
      ),
      const SizedBox(height: 8),
      if (model.formType == SignInFormType.signIn)
        TextButton(
            onPressed: () {}, child: const Text('Forget your password.')),
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
      const SizedBox(height: 8),
      TextButton(
          onPressed: ()=> !model.isLoading ? _signInWithGoogle(context) : null,
          child: const Text('Sign in with Google')),
    ];
  }
  Future<void> _signInExceptions(BuildContext context, Exception exception) {
    if (exception is FirebaseAuthException &&
        exception.code == 'ERROR_ABORTED_BY_USER') {}
    return showExceptionDialog(
      context,
      exception: exception,
      title: 'Sign in failed',
    );
  }


  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await widget.bloc!.auth.signInWithGoogle();
      if(widget.bloc!.auth.currentUser!= null){RouteMethods.navigateTo(context: context, routeName: Home.route);}
    } on Exception catch (e) {
      _signInExceptions(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<SignInBloc>(
      create: (context) => SignInBloc(),
      child: Consumer<SignInBloc>(
        builder: (context, state, __) {
          return Scaffold(
            // appBar: AppBar(title: const Text('Sign in With Email')),
            body: SingleChildScrollView(
              child: StreamBuilder<SignInModel>(
                  stream: widget.bloc!.modelStream,
                  initialData: SignInModel(),
                  builder: (context, snapshot) {
                    SignInModel? model = snapshot.data;
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
        },
      ),
    );
  }
}
