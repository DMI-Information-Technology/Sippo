import 'package:jobspot/core/validate_error.dart';

import '../sippo_excepstions/resource_exception/invalid_response_exception.dart';

enum StatusType { SUCCESS, VALIDATE_ERROR, ERROR, INVALID_RESPONSE }

class Resource<T, E> {
  final T? data;
  final String? errorMessage;
  final ValidateError<E?>? validateError;
  final StatusType type;

  const Resource.success({
    required this.data,
    required this.type,
  })  : this.errorMessage = null,
        this.validateError = null;

  const Resource.validateError({
    this.validateError,
    required this.type,
  })  : this.data = null,
        this.errorMessage = null;

  const Resource.error({
    this.errorMessage,
    required this.type,
  })  : this.data = null,
        this.validateError = null;

  Future<void> checkStatusResponse({
    required void Function(T? data, StatusType statusType) onSuccess,
    required void Function(
            ValidateError<E?>? validateError, StatusType statusType)
        onValidateError,
    required void Function(String? message, StatusType statusType) onError,
  }) async {
    try {
      switch (this.type) {
        case StatusType.SUCCESS:
          print("the response is success: with status type = $type");
          print("the response is success: with response data = $data");
          onSuccess(data, StatusType.SUCCESS);
          break;
        case StatusType.VALIDATE_ERROR:
          print("the response is field: with status type = $type");
          print("the response is field: with response error = $validateError");
          onValidateError(validateError, StatusType.ERROR);
          break;
        case StatusType.ERROR:
          print("the response is field: with status type = $type");
          print("the response is field: with response error = $errorMessage");
          onError(errorMessage, StatusType.ERROR);
          break;
        default:
          print(
              "the response is field: with status type = ${StatusType.INVALID_RESPONSE}");
          print("the response is field: with response error = null");
          throw InvalidResponseException(message: "something is wrong with the response, please try again");
      }
    } on InvalidResponseException catch (e) {
      print(e.message);
      onError(e.message, StatusType.INVALID_RESPONSE);
    }
  }

  Future<T?> checkStatusResponseAndGetData({
    required void Function(
      ValidateError<E?>? validateError,
      StatusType statusType,
    )? onValidateError,
    required void Function(String? message, StatusType statusType)? onError,
    void Function(T? data, StatusType statusType)? onSuccess,
  }) async {
    try {
      switch (this.type) {
        case StatusType.SUCCESS:
          print("the response is success: with status type = $type");
          print("the response is success: with response data = $data");
          if (onSuccess != null) onSuccess(data, StatusType.SUCCESS);
          return data;
        case StatusType.VALIDATE_ERROR:
          print("the response is field: with status type = $type");
          print("the response is field: with response error = $validateError");
          if (onValidateError != null)
            onValidateError(validateError, StatusType.ERROR);
          return null;
        case StatusType.ERROR:
          print("the response is field: with status type = $type");
          print("the response is field: with response error = $validateError");
          if (onError != null) onError(errorMessage, StatusType.ERROR);
          return null;
        default:
          print("the response is field: with status type = null");
          print("the response is field: with response error = null");
          throw InvalidResponseException();
      }
    } on InvalidResponseException catch (e) {
      print(e.message);
      if (onError != null) onError(e.message, StatusType.INVALID_RESPONSE);
      return null;
    }
  }
}
