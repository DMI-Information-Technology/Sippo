class States {
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  final String? message;
  final String? error;

  States({
    this.isLoading = false,
    this.isSuccess = false,
    this.isError = false,
    this.message,
    this.error,
  });

  States copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    String? message,
    String? error,
  }) {
    return States(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }
}
