class ValidateError<T> {
  String? message;
  T? errors;

  ValidateError({this.message, T? errors}) {
    this.errors = errors;
  }

  factory ValidateError.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> errors) entityErrorsModel,
  ) {
    return ValidateError<T>(
      message: json['message'].toString(),
      errors: entityErrorsModel(json['errors']),
    );
  }
}
