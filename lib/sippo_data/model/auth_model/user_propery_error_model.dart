import 'package:jobspot/sippo_data/model/auth_model/property_error_model.dart';

class UserPropError extends EntityPropertyError {
  UserPropError({
    super.phone,
    super.name,
    super.password,
    super.passwordConfirmation,
  });

  factory UserPropError.fromJson(Map<String, dynamic>? json) {
    return UserPropError(
      phone: json?['phone'] != null ? List<String>.from(json?['phone']) : null,
      name: json?['name'] != null ? List<String>.from(json?['name']) : null,
      password: json?['password'] != null
          ? List<String>.from(json?['password'])
          : null,
      passwordConfirmation: json?['password_confirmation'] != null
          ? List<String>.from(json?['password_confirmation'])
          : null,
    );
  }
}
