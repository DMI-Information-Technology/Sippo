class StatusMessageModel {
  StatusMessageModel({
    this.status,
    this.message,
  });

  final String? status;
  final String? message;

  StatusMessageModel copyWith({
    String? status,
    String? message,
  }) =>
      StatusMessageModel(
        status: status ?? this.status,
        message: message ?? this.message,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    return map;
  }

  factory StatusMessageModel.fromJson(Map<String, dynamic>? json) {
    return StatusMessageModel(
      status: json?["status"],
      message: json?["message"],
    );
  }

  @override
  String toString() {
    return 'StatusMessageModel{status: $status, message: $message}';
  }
//
}
