
import 'package:flutter/foundation.dart';

import 'validators.dart';

enum SignInFormType { signIn, register }

class SignInModel with UserInputValidation, ChangeNotifier {
  SignInModel({
    this.email = '',
    this.name = '',
    this.phone = '',
    this.password = '',
    this.passwordVisibility = false,
    this.isLoading = false,
    this.submitted = false,
    this.formType = SignInFormType.signIn,
  });
  final String email;
  final String name;
  final String phone;
  bool passwordVisibility;
  final String password;
  final bool isLoading;
  final bool submitted;
  final SignInFormType formType;
  String get primaryText {
    return formType == SignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';
  }

  String get secondaryText {
    return formType == SignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';
  }

  bool get submitEnabled {
    return
      // phoneValidator.isValid(phone) &&
        passwordValidator.isValid(password) &&
        emailValidator.isValid(email) &&
        !isLoading;
  }

  String? get passwordErrorText {
    bool passwordValid = submitted && passwordValidator.isValid(password);
    return passwordValid ? invalidEmailErrorText : null;
  }

  String? get phoneErrorText {
    bool phoneValid = submitted && phoneValidator.isValid(phone);
    return phoneValid ? invalidPhoneErrorText : null;
  }

  String? get emailErrorText {
    bool emailValid = submitted && emailValidator.isValid(email);
    return emailValid ? invalidPasswordErrorText : null;
  }

  SignInModel copyWith({
    String? email,
    String? name,
    String? phone,
    String? password,
    SignInFormType? formType,
    bool? isLoading,
    bool? submitted,
  }) {
    return SignInModel(
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
      submitted: submitted ?? this.submitted,
    );
  }
}

class SignInChangeModel with UserInputValidation, ChangeNotifier {
  SignInChangeModel(
      {this.email = '',
      this.password = '',
      this.name = '',
      this.phone = '',
      this.isLoading = false,
      this.submitted = false,
      this.formType = SignInFormType.signIn,
      // required this.auth
      });
  // final AuthBase auth;
  String email;
  String name;
  String password;
  String phone;
  bool isLoading;
  bool submitted;
  SignInFormType formType;
  String get primaryText {
    return formType == SignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';
  }

  String get secondaryText {
    return formType == SignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';
  }

  bool get submitEnabled {
    return emailValidator.isValid(email) &&
        emailValidator.isValid(password) &&
        !isLoading;
  }

  String? get passwordErrorText {
    bool passwordValid = submitted && passwordValidator.isValid(password);
    return passwordValid ? invalidEmailErrorText : null;
  }

  String? get emailErrorText {
    bool emailValid = submitted && emailValidator.isValid(email);
    return emailValid ? invalidPasswordErrorText : null;
  }

  Future<void> submit() async {
    updateWith(isLoading: true, submitted: true);
    try {
      if (formType == SignInFormType.signIn) {
        // await auth.signInWithEmailAndPassword(email, password);
      } else {
        // await auth.createUserWithEmailAndPassword(email, password);
      }
    } catch (e) {
      updateWith(isLoading: false, submitted: false);
      rethrow;
    }
  }

// toggle between signing in forms
  void toggleFormType() {
    final formType = this.formType == SignInFormType.signIn
        ? SignInFormType.register
        : SignInFormType.signIn;
    updateWith(
      email: '',
      name: '',
      password: '',
      phone: '',
      formType: formType,
      submitted: false,
      isLoading: false,
    );
  }

  void updateWith({
    String? email,
    String? name,
    String? password,
    String? phone,
    SignInFormType? formType,
    bool? isLoading,
    bool? submitted,
  }) {
    this.email = email ?? this.email;
    this.phone = phone ?? this.phone;
    this.name = name ?? this.name;
    this.password = password ?? this.password;
    this.formType = formType ?? this.formType;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    notifyListeners();
  }
}
