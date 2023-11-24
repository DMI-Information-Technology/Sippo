import 'package:get/get.dart';

class FailedFetchingSpecializationException implements Exception {
  late final String message;

  FailedFetchingSpecializationException([
    String? message,
  ]) {
    this.message = message ?? "no_special_fetched".tr;
  }

  @override
  String toString() => message;
}
