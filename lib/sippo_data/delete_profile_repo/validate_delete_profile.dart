class ValidatePropDeleteProfile {
  final List<String>? password;

  const ValidatePropDeleteProfile({
    this.password,
  });

  factory ValidatePropDeleteProfile.fromJson(Map<String, dynamic>? map) {
    return ValidatePropDeleteProfile(
      password: List.of(map?['password']).map((e) => e.toString()).toList(),
    );
  }
}
