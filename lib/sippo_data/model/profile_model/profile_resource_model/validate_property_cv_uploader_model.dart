class ValidatePropCvUploaderModel {
  ValidatePropCvUploaderModel({
    this.cv,
  });

  factory ValidatePropCvUploaderModel.fromJson(dynamic json) {
    return ValidatePropCvUploaderModel(
      cv: json['cv'] != null ? json['cv'].cast<String>() : [],
    );
  }

  final List<String>? cv;

  ValidatePropCvUploaderModel copyWith({
    List<String>? cv,
  }) =>
      ValidatePropCvUploaderModel(
        cv: cv ?? this.cv,
      );

  Map<String, dynamic> toJson() => {
        'cv': cv,
      };
}
