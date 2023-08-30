import 'package:jobspot/core/validate_error.dart';
import 'package:jobspot/sippo_data/model/auth_model/entity_model.dart';
import 'package:jobspot/sippo_data/model/auth_model/register_model.dart';
import 'package:jobspot/sippo_data/model/auth_model/user_register_type_response.dart';

class AuthResponse<T extends EntityModel, E> {
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
  });
}
