import 'package:jobspot/sippo_data/model/notification/job_application_model.dart';

class ApplicationStatusModel {
  final JobApplicationStatusType? status;

  ApplicationStatusModel({this.status});

  Map<String, String>? toJson() => switch (status) {
        JobApplicationStatusType.Accepted => ACCEPTED,
        JobApplicationStatusType.Rejected => REJECTED,
        JobApplicationStatusType.Pending => null,
        null => null,
      };

  static const Map<String, String> REJECTED = const {'status': 'Rejected'};
  static const Map<String, String> ACCEPTED = const {'status': 'Accepted'};
}

class ValidatePropApplicationStatusModel {
  final List<String>? status;

  const ValidatePropApplicationStatusModel({
    this.status,
  });

  factory ValidatePropApplicationStatusModel.fromJson(
      Map<String, dynamic> json) {
    return ValidatePropApplicationStatusModel(
      status: json["status"] is List && json["status"] != null
          ? List.of(json["status"]).map((e) => e.toString()).toList()
          : [],
    );
  }

  @override
  String toString() {
    return 'ValidatePropApplicationStatusModel{status: $status}';
  }
//
}
