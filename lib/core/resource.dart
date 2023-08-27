import 'package:jobspot/core/validate_error.dart';

enum StatusType { SUCCESS, VALIDATE_ERROR, ERROR }

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

  Future<void> checkStatusResponse(
      {
    required void Function(T? data, StatusType statusType) onSuccess,
    required void Function(ValidateError<E?>? validateError, StatusType statusType)
        onValidateError,
    required void Function(String? message, StatusType statusType) onError,
  }) async {
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
        print("the response is field: with response error = $validateError");
        onError(errorMessage, StatusType.ERROR);
        break;
    }
  }
}
