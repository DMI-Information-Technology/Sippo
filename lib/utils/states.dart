class States {
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  final bool isWarning;
  final String? message;

  States({
    this.isLoading = false,
    this.isSuccess = false,
    this.isError = false,
    this.isWarning = false,
    this.message,
  });

  States copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    bool? isWarning,
    String? message,
    String? error,
  }) {
    return States(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      isWarning: isWarning ?? this.isWarning,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return 'States{isLoading: $isLoading, isSuccess: $isSuccess, isError: $isError, isWarning: $isWarning, message: $message}';
  }
}
