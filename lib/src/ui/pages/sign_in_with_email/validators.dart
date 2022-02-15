abstract class StringValidator {
  bool isValid(String value);
}

class NotEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.isNotEmpty;
  }
}

class UserInputValidation {
  final NotEmptyStringValidator emailValidator = NotEmptyStringValidator();
  final NotEmptyStringValidator passwordValidator = NotEmptyStringValidator();
  final NotEmptyStringValidator phoneValidator = NotEmptyStringValidator();
  final String invalidEmailErrorText = 'Email can\'t be empty';
  final String invalidPasswordErrorText = 'Password can\'t be empty';
  final String invalidPhoneErrorText = 'phone can\'t be empty';
  // final String phoneIsRepeated = 'this phone is already used by an other user';
}
