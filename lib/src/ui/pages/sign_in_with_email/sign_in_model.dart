
import 'package:flutter/foundation.dart';

import 'validators.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInModel with EmailAndPasswordValidation, ChangeNotifier {
  EmailSignInModel({
    this.email = '',
    this.password = '',
    this.passwordVisibility = false,
    this.isLoading = false,
    this.submitted = false,
    this.formType = EmailSignInFormType.signIn,
  });
  final String email;
  bool passwordVisibility;
  final String password;
  final bool isLoading;
  final bool submitted;
  final EmailSignInFormType formType;
  String get primaryText {
    return formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';
  }

  String get secondaryText {
    return formType == EmailSignInFormType.signIn
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

  EmailSignInModel copyWith({
    String? email,
    String? password,
    EmailSignInFormType? formType,
    bool? isLoading,
    bool? submitted,
  }) {
    return EmailSignInModel(
      email: email ?? this.email,
      password: password ?? this.password,
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
      submitted: submitted ?? this.submitted,
    );
  }
}

class EmailSignInChangeModel with EmailAndPasswordValidation, ChangeNotifier {
  EmailSignInChangeModel(
      {this.email = '',
      this.password = '',
      this.isLoading = false,
      this.submitted = false,
      this.formType = EmailSignInFormType.signIn,
      // required this.auth
      });
  // final AuthBase auth;
  String email;
  String password;
  bool isLoading;
  bool submitted;
  EmailSignInFormType formType;
  String get primaryText {
    return formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';
  }

  String get secondaryText {
    return formType == EmailSignInFormType.signIn
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
      if (formType == EmailSignInFormType.signIn) {
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
    final formType = this.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;
    updateWith(
      email: '',
      password: '',
      formType: formType,
      submitted: false,
      isLoading: false,
    );
  }

  void updateWith({
    String? email,
    String? password,
    EmailSignInFormType? formType,
    bool? isLoading,
    bool? submitted,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.formType = formType ?? this.formType;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    notifyListeners();
  }
}
