class UserModel {
  String? name;
  String? password;
  String? phone;
  String? passwordConfirmation;

  UserModel({
    this.name,
    this.password,
    this.phone,
    this.passwordConfirmation,
  });

  @override
  String toString() {
    return 'UserModel{' +
        ' name: $name,' +
        ' password: $password,' +
        ' phone: $phone,' +
        ' password_confirmation: $passwordConfirmation,' +
        '}';
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'password': this.password,
      'phone': this.phone,
      'password_confirmation': this.passwordConfirmation,
    };
  }

  Map<String, dynamic> toLoginJson() {
    return {
      'password': this.password,
      'phone': this.phone,
    };
  }
}
