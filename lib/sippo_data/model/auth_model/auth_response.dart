import 'package:jobspot/sippo_data/model/auth_model/register_model.dart';
import 'package:jobspot/sippo_data/model/auth_model/user_register_type_response.dart';
import 'package:jobspot/sippo_data/model/auth_model/validate_error.dart';

class AuthResponse<T, E> {
  RegisterModel<T>? data;
  String? authMessageError;
  String? error;
  ValidateError<E>? validateError;
  RegisterTypeResponse type;

  AuthResponse.registerSuccess({required this.data, required this.type});

  AuthResponse.registerValidateError({this.validateError, required this.type});

  AuthResponse.registerAuthError({
    required this.authMessageError,
    required this.type,
    error,
  }) ;
}
