class ChangePasswordModel {
  final String? currentPassword;
  final String? newPassword;
  final String? confirmPassword;

  const ChangePasswordModel({
    this.currentPassword,
    this.newPassword,
    this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      "current_password": this.currentPassword,
      "password": this.newPassword,
      "password_confirmation": this.confirmPassword,
    };
  }

  @override
  String toString() {
    return 'ChangePasswordModel{currentPassword: $currentPassword, newPassword: $newPassword, confirmPassword: $confirmPassword}';
  }
}

class ValidatePropChangePasswordModel {
  final List<String>? currentPassword;
  final List<String>? newPassword;
  final List<String>? confirmPassword;

  const ValidatePropChangePasswordModel({
    this.currentPassword,
    this.newPassword,
    this.confirmPassword,
  });

  factory ValidatePropChangePasswordModel.fromJson(Map<String, dynamic> json) {
    return ValidatePropChangePasswordModel(
      currentPassword: json["current_password"] != null
          ? List.of(json["current_password"]).map((i) => i.toString()).toList()
          : null,
      newPassword: json["password"] != null
          ? List.of(json["password"]).map((i) => i.toString()).toList()
          : null,
      confirmPassword: json["password_confirmation"] != null
          ? List.of(json["password_confirmation"])
          .map((i) => i.toString())
          .toList()
          : null,
    );
  }

  @override
  String toString() {
    return 'ValidatePropChangePasswordModel{currentPassword: $currentPassword, newPassword: $newPassword, confirmPassword: $confirmPassword}';
  }
//
}
