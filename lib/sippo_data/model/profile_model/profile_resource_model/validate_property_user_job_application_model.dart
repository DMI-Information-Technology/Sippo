class ValidatePropUserJobApplication {
  final List<String>? cv;
  final List<String>? description;

  ValidatePropUserJobApplication({
    this.description,
    this.cv,
  });

  @override
  String toString() {
    return 'UserJobApplication{cv: $cv, description: $description}';
  }

  factory ValidatePropUserJobApplication.fromJson(Map<String, dynamic> json) {
    return ValidatePropUserJobApplication(
      cv: List.of(json["cv"]).map((i) => json["cv"].toString()).toList(),
      description: List.of(json["description"])
          .map((i) => json["description"].toString())
          .toList(),
    );
  }
//
}
