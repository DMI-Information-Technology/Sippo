class UserModel {
  String? name;
  String? password;
  String? phone;
  String? passwordConfirmation;
  String? fcmToken;
  int? locationId;

  UserModel({
    this.name,
    this.password,
    this.phone,
    this.passwordConfirmation,
    this.fcmToken,
    this.locationId,
  });

  @override
  String toString() {
    return 'UserModel{' +
        ' name: $name,' +
        ' password: $password,' +
        ' phone: $phone,' +
        ' password_confirmation: $passwordConfirmation,' +
        ' fcm_token: $fcmToken,' +
        '}';
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'password': this.password,
      'phone': this.phone,
      'password_confirmation': this.passwordConfirmation,
      'fcm_token': fcmToken,
      'longitude': 0,
      'latitude': 0,
      'location_id': locationId,
    };
  }

  Map<String, dynamic> toLoginJson() {
    return {
      'password': this.password,
      'phone': this.phone,
      'fcm_token': this.fcmToken,
    }..removeWhere(
        (key, value) => value == null || (value as String).trim().isEmpty,
      );
  }
}
