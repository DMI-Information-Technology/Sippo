import 'package:get/get.dart';
import 'package:sippo/core/validate_error.dart';

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
    void Function(T? data, StatusType statusType)? onSuccess,
    void Function(ValidateError<E?>? validateError, StatusType statusType)?
        onValidateError,
    void Function(String? message, StatusType statusType)? onError,
    void Function(dynamic argument)? onDone,
  }) async {
    try {
      switch (this.type) {
        case StatusType.SUCCESS:
          print("the response is success: with status type = $type");
          print("the response is success: with response data = $data");
          onSuccess?.call(data, StatusType.SUCCESS);
          break;
        case StatusType.VALIDATE_ERROR:
          print("the response is field: with status type = $type");
          print("the response is field: with response error = $validateError");
          onValidateError?.call(validateError, StatusType.ERROR);
          break;
        case StatusType.ERROR:
          print("the response is field: with status type = $type");
          print("the response is field: with response error = $errorMessage");
          onError?.call(errorMessage, StatusType.ERROR);
          break;
        default:
          print(
              "the response is field: with status type = ${StatusType.INVALID_RESPONSE}");
          print("the response is field: with response error = null");
          throw InvalidResponseException(
            message: 'something_wrong_request_message'.tr,
          );
      }
    } on InvalidResponseException catch (e) {
      print(e.message);
      onError?.call(e.message, StatusType.INVALID_RESPONSE);
    } finally {
      if (onDone != null) onDone(null);
    }
  }

  Future<T?> checkStatusResponseAndGetData({
    required void Function(
      ValidateError<E?>? validateError,
      StatusType statusType,
    )? onValidateError,
    required void Function(String? message, StatusType statusType)? onError,
    void Function(T? data, StatusType statusType)? onSuccess,
    void Function(dynamic argument)? onDone,
  }) async {
    try {
      switch (this.type) {
        case StatusType.SUCCESS:
          print("the response is success: with status type = $type");
          print("the response is success: with response data = $data");
          if (onSuccess != null) onSuccess(data, StatusType.SUCCESS);
          break;
        case StatusType.VALIDATE_ERROR:
          print("the response is field: with status type = $type");
          print("the response is field: with response error = $validateError");
          if (onValidateError != null)
            onValidateError(validateError, StatusType.ERROR);
          break;
        case StatusType.ERROR:
          print("the response is field: with status type = $type");
          print("the response is field: with response error = $validateError");
          if (onError != null) onError(errorMessage, StatusType.ERROR);
          break;
        default:
          print("the response is field: with status type = $type");
          print("the response is field: with response error = $errorMessage");
          throw InvalidResponseException();
      }
    } on InvalidResponseException catch (e) {
      print(e.message);
      if (onError != null) onError(e.message, StatusType.INVALID_RESPONSE);
    } finally {
      if (onDone != null) onDone(null);
      return data;
    }
  }
}
