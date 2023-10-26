import 'package:email_validator/email_validator.dart';

class Validators {
  const Validators._();

  static phoneNumberValidator(String number, String countryCode) {
    int totalLength = number.length + countryCode.length;

    if (totalLength > 15 || totalLength < 9) {
      return "Enter a valid number";
    } else if (number.isEmpty) {
      return "This field cannot be empty";
    }
  }

  static passwordValidator(String password) {
    // String pattern =
    //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

    RegExp regExp = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W).{8,}$");

    if (password.isEmpty) {
      return "This field cannot be empty";
    } else if (!regExp.hasMatch(password)) {
      return "Password should be like Example@123";
    }
  }

  static passwordLengthValidator(String value) {
    if (value.isEmpty) {
      return "This field can't be empty";
    } else if (value.length < 7) {
      return "Password should be minimum 7 characters";
    }
  }

  static passwordConfirmValidator(String password, String confirmPassword) {
    if (password != confirmPassword) {
      return "Confirm Password doesn't match";
    }
  }

  static emailValidator(String email) {
    if (!EmailValidator.validate(email)) {
      return "Enter a valid email";
    }
  }

  static emptyValidator(String value) {
    if (value.isEmpty) {
      return "This field can't be empty";
    }
  }
}
