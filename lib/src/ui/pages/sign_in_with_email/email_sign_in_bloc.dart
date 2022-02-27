import 'dart:async';
import 'package:mk/src/core/navigation/navigation_methods.dart';
import 'package:mk/src/services/remote/firebase/auth.dart';
import 'package:mk/src/ui/pages/otp_page/otp_page.dart';

import '../home/home_page.dart';
import 'sign_in_model.dart';

class SignInBloc {
  // SignInBloc( {
  // required this.auth
  // ,required this.isLoading,
  // });
  final StreamController<SignInModel> _modelController =
      StreamController<SignInModel>();
  // final ValueNotifier<bool> isLoading;
  Stream<SignInModel> get modelStream => _modelController.stream;
  SignInModel _model = SignInModel();
  AuthBase auth = Auth();

  void dispose() {
    _modelController.close();
  }

  //submit button in singing in form
  Future<void> submit(context) async {
    updateWith(isLoading: true, submitted: true);
    try {
      if (_model.formType == SignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
        RouteMethods.navigateTo(context: context, routeName: Home.route);
      } else {
        await auth.createUserWithEmailAndPassword(
          email: _model.email,
          password: _model.password,
          userName: _model.name,
          phoneNumber: _model.phone,
        );
        await auth.submitPhoneNumber(phoneNumber: _model.phone);
        RouteMethods.navigateAndChange(
            context: context, routeName: OTPPage.route, args: _model.phone);
      }
    } catch (e) {
      updateWith(isLoading: false, submitted: false);
      rethrow;
    }
  }

// toggle between signing in forms
  void toggleFormType() {
    final formType = _model.formType == SignInFormType.signIn
        ? SignInFormType.register
        : SignInFormType.signIn;
    updateWith(
      email: '',
      password: '',
      formType: formType,
      submitted: false,
      isLoading: false,
    );
  }

  void updateEmail(String email) => updateWith(email: email);
  void updatePhone(String phone) => updateWith(phone: phone);
  void updatePassword(String password) => updateWith(password: password);

  void updateWith({
    String? email,
    String? password,
    String? phone,
    SignInFormType? formType,
    bool? isLoading,
    bool? submitted,
  }) {
    //update model
    _model = _model.copyWith(
      email: email,
      password: password,
      phone: phone,
      submitted: submitted,
      isLoading: isLoading,
      formType: formType,
    );
    //add updated model to model controller
    _modelController.add(_model);
  }

  // bool passwordVisible = false;
  void changePasswordVisibility() {
    _model.passwordVisibility = !_model.passwordVisibility;
    _modelController.add(_model);
  }
}
