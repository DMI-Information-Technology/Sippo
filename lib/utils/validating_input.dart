class ValidatingInput {
  static final RegExp _fullNameRegex = RegExp(r'^[a-zA-Z\s]+$');
  static final RegExp _phoneNumberRegex = RegExp(r'^(092|091)\d{7}$');
  static final RegExp _wordRegExp = RegExp(r'^[a-zA-Z\u0600-\u06FF ]+$');

  // static final RegExp passwordRegex = RegExp(
  //     r'^(?=.*[a-zA-Z])(?=.*[!@#$%^&*(),.?":{}|<>])'
  //     r'(?=.*[0-9].*[0-9].*[0-9].*[0-9].*[0-9].*[0-9])[a-zA-Z0-9!@#$%^&*(),.?":{}|<>]{8,}$');
  static final RegExp passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*(),.?":{}|<>])'
      r'(?=.*[0-9].*[0-9].*[0-9].*[0-9].*[0-9].*[0-9])[a-zA-Z0-9!@#$%^&*(),.?":{}|<>]{8,}$');

  static bool validateWords(String value) {
    return _wordRegExp.hasMatch(value);
  }

  static bool validateFullName(String value) {
    return _fullNameRegex.hasMatch(value);
  }

  static bool validatePhoneNumber(String value) {
    return _phoneNumberRegex.hasMatch(value);
  }

  static String validatePassword(String value) {
    if (!passwordRegex.hasMatch(value)) {
      if (value.length < 8) {
        return 'Password should be at least 8 characters long.';
      } else if (!RegExp(r'[a-z]').hasMatch(value)) {
        return 'Password should contain at least one lowercase letter.';
      } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
        return 'Password should contain at least one uppercase letter.';
      } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
        return 'Password should contain at least one symbol.';
      } else if (!RegExp(r'[0-9].*[0-9].*[0-9].*[0-9].*[0-9].*[0-9]')
          .hasMatch(value)) {
        return 'Password should contain at least 6 digits.';
      }
    }

    return '';
  }
}
