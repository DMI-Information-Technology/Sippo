import 'package:get/get.dart';

class ValidatingInput {
  static final _fullNameRegex = RegExp(r'^[a-zA-Z\s]+$');
  static final _phoneNumberRegex = RegExp(r'^(092|091)\d{7}$');
  static final _wordRegExp = RegExp(r'^[a-zA-Z\u0600-\u06FF ]+$');
  static final _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$",
  );

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
    r'(?=.*[0-9].*[0-9].*[0-9].*[0-9].*[0-9].*[0-9])[a-zA-Z0-9!@#$%^&*(),.?":{}|<>]{8,}$',
  );

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
        : message ?? "is_req".tr;
  }

  static String? validatePassword(String? value) {
    final password = value?.trim();
    if (password == null || password.trim().isEmpty) {
      return "password_is_req".tr;
    }
    if (!passwordRegex.hasMatch(password)) {
      if (password.length < 8) {
        return 'password_with_8_char_long'.tr;
      } else if (!RegExp(r'[a-z]').hasMatch(password)) {
        return 'password_with_lowercase'.tr;
      } else if (!RegExp(r'[A-Z]').hasMatch(password)) {
        return 'password_with_uppercase'.tr;
        // } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
        //   return 'Password should contain at least one symbol.';
      } else if (!RegExp(r'[0-9]').hasMatch(password)) {
        return 'password_with_digit_number'.tr;
      }
    }

    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'enter_email_address'.tr;
    } else if (!_emailRegExp.hasMatch(email.trim())) {
      return 'enter_valid_email_address'.tr;
    } else {
      return null;
    }
  }

  static String? validateDescription(String? value) {
    final validateEmptyString = validateEmptyField(value) ?? '';
    if (validateEmptyString.isNotEmpty) return validateEmptyString;
    bool containEmail =
        RegExp(r'[\w\.]+[@][\w\.]+').hasMatch(value??"");
    print(containEmail);
    String cleanedDescription = removeSymbolsAnSpace(value ?? '');
    bool containsPhoneNumber = containsValidPhoneNumber(cleanedDescription);
    return containsPhoneNumber || containEmail
        ? 'do_not_enter_phone_number_in_description'.tr
        : null;
  }

  static String removeSymbolsAnSpace(String text) =>
      text.replaceAll(RegExp(r'[._#$%@\-,$-/\s]'), '');

  static bool containsValidPhoneNumber(String text) {
    RegExp phoneRegex = RegExp(
      r'09[12]-?\d{7}|\+?218-0?[91][12]\d{7}|\d{7}',
    );
    return phoneRegex.hasMatch(text);
  }
}
