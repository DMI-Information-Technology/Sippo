class ValidatePropUserCompanyApplication {
  final List<String>? cv;
  final List<String>? description;

  ValidatePropUserCompanyApplication({
    this.description,
    this.cv,
  });

  @override
  String toString() {
    return 'UserJobApplication{cv: $cv, description: $description}';
  }

  factory ValidatePropUserCompanyApplication.fromJson(Map<String, dynamic> json) {
    return ValidatePropUserCompanyApplication(
      cv: List.of(json["cv"]).map((i) => json["cv"].toString()).toList(),
      description: List.of(json["description"])
          .map((i) => json["description"].toString())
          .toList(),
    );
  }
//
}
