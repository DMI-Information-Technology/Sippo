class ValidatingInput {
  static final RegExp _fullNameRegex = RegExp(r'^[a-zA-Z\s]+$');
  static final RegExp _phoneNumberRegex = RegExp(r'^(092|091)\d{7}$');
  static final RegExp _wordRegExp = RegExp(r'^[a-zA-Z\u0600-\u06FF ]+$');
  static final _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$");

  // static final RegExp _noPhoneRegex = RegExp(r'^(\+2189|09)([12]|[0-9]{7})$');
  // static final RegExp _emailRegex =
  //     RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$');

  // static final RegExp passwordRegex = RegExp(
  //     r'^(?=.*[a-zA-Z])(?=.*[!@#$%^&*(),.?":{}|<>])'
  //     r'(?=.*[0-9].*[0-9].*[0-9].*[0-9].*[0-9].*[0-9])[a-zA-Z0-9!@#$%^&*(),.?":{}|<>]{8,}$');
  // static final RegExp passwordRegex = RegExp(
  //     r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[a-zA-Z0-9!@#$%^&*(),.?":{}|<>]{8,}$');
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

  static String? validateEmptyField(String? value, {String? message}) {
    return value != null && value.trim().isNotEmpty
        ? null
        : message ?? 'this field is required.';
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

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter an email address.';
    } else if (!_emailRegExp.hasMatch(email.trim())) {
      return 'Please enter a valid email address.';
    } else {
      return null;
    }
  }

  static String? validateDescription(String? value) {
    final validateEmptyString = validateEmptyField(value) ?? '';
    if (validateEmptyString.isNotEmpty) return validateEmptyString;
    String cleanedDescription = removeSymbolsAnSpace(value ?? '');
    print("cleanedDescription: $cleanedDescription");
    bool containsPhoneNumber = containsValidPhoneNumber(cleanedDescription);
    return containsPhoneNumber
        ? 'Please do not enter phone number or email in the description.'
        : null;
  }

  static String removeSymbolsAnSpace(String text) {
    RegExp regex = RegExp(r'[._#$%@\-,$-/\s]');
    return text.replaceAll(regex, '');
  }

  static bool containsValidPhoneNumber(String text) {
    RegExp phoneRegex = RegExp(
      r'(?:(?:09[12]-?\d{7})|(?:\+?218-0?[91][12]\d{7})|(?:\d{7}))',
    );
    return phoneRegex.hasMatch(text);
  }
}
