import '../locations_model/location_address_model.dart';

class CompanyModel {
  final String? name;
  final String? phone;
  final String? password;
  final double? longitude;
  final double? latitude;
  final List<int>? specializations;
  final String? passwordConfirmation;
  final LocationAddress? locationAddress;
  final String? fcmToken;

  CompanyModel({
    this.name,
    this.phone,
    this.password,
    this.longitude,
    this.latitude,
    this.locationAddress,
    this.specializations,
    this.passwordConfirmation,
    this.fcmToken,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "phone": phone,
      "password": password,
      "longitude": longitude,
      "latitude": latitude,
      'location_id': locationAddress?.id,
      "specializations": specializations,
      "password_confirmation": passwordConfirmation,
    };
  }

  Map<String, dynamic> toLoginJson() {
    return {
      "phone": phone,
      "password": password,
      "fcm_token": fcmToken,
    }..removeWhere(
        (_, value) => value == null || (value as String).trim().isEmpty,
      );
  }

  @override
  String toString() {
    return 'CompanyModel{name: $name, phone: $phone, password: $password, fcmToken: $fcmToken, locationAddress: $locationAddress, longitude: $longitude, latitude: $latitude, specializations: $specializations, passwordConfirmation: $passwordConfirmation}';
  }
}
