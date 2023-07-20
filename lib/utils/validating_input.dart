class ValidatingInput {
  static final RegExp fullNameRegex = RegExp(r'^[a-zA-Z\s]+$');
  static final RegExp phoneNumberRegex = RegExp(r'^\+?[0-9]{7,10}$');
  static final RegExp passwordRegex = RegExp(
      r'^(?=.*[a-zA-Z])(?=.*[!@#$%^&*(),.?":{}|<>])'
      r'(?=.*[0-9].*[0-9].*[0-9].*[0-9].*[0-9].*[0-9])[a-zA-Z0-9!@#$%^&*(),.?":{}|<>]{8,}$');

  static bool validateFullName(String value) {
    return fullNameRegex.hasMatch(value);
  }

  static bool validatePhoneNumber(String value) {
    return phoneNumberRegex.hasMatch(value);
  }

  static String validatePassword(String value) {
    if (!passwordRegex.hasMatch(value)) {
      if (value.length < 8) {
        return 'Password should be at least 8 characters long.';
      } else if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
        return 'Password should contain at least one letter.';
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
