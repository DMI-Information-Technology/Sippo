
class FailedFetchingSpecializationException implements Exception {
  final String message;

  FailedFetchingSpecializationException([
    String message = "failed on fetching specialization data from the server.",
  ]) : this.message = message;

  @override
  String toString() {
    return message;
  }
}