class StatusMessageModel {
  StatusMessageModel({
    this.status,
    this.message,
  });

  StatusMessageModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
  }

  String? status;
  String? message;

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
}
