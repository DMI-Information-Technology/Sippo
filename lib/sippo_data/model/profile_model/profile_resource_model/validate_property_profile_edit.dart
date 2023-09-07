class ValidatePropProfileInfo {
  List<String>? name;
  List<String>? phone;
  List<String>? secondaryPhone;
  List<String>? email;
  List<String>? gender;
  List<String>? bio;

  factory ValidatePropProfileInfo.fromJson(Map<String, dynamic>? json) {
    return ValidatePropProfileInfo(
      name: json?['name'] != null ? List<String>.from(json?['name']) : null,
      phone: json?['phone'] != null ? List<String>.from(json?['phone']) : null,
      secondaryPhone: json?['secondary_phone'] != null
          ? List<String>.from(json?['secondary_phone'])
          : null,
      email: json?['email'] != null ? List<String>.from(json?['email']) : null,
      gender:
          json?['gender'] != null ? List<String>.from(json?['gender']) : null,
      bio: json?['bio'] != null ? List<String>.from(json?['bio']) : null,
    );
  }

  ValidatePropProfileInfo({
    this.name,
    this.phone,
    this.secondaryPhone,
    this.email,
    this.gender,
    this.bio,
  });
}
