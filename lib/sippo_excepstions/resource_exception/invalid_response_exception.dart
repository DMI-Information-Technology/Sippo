class InvalidResponseException implements Exception {
  final String message;

  InvalidResponseException({
    this.message = "invalid response",
  });

  @override
  String toString() => "[InvalidResponseException]: $message";
}
