
class InvalidResponseException implements Exception {
  final String message;

  InvalidResponseException({
    this.message = "[InvalidResponseException]: invalid response",
  });

  @override
  String toString() => message;
}
