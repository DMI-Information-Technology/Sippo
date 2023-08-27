import 'package:jobspot/sippo_data/model/auth_model/property_error_model.dart';

class CompanyPropError extends EntityPropertyError {
  List<String>? longitude;
  List<String>? latitude;
  List<String>? specializations;
  List<String>? city;

  CompanyPropError({
    super.phone,
    super.name,
    super.password,
    super.passwordConfirmation,
    this.latitude,
    this.longitude,
    this.city,
    this.specializations,
  });

  factory CompanyPropError.fromJson(Map<String, dynamic>? json) {
    return CompanyPropError(
      name: List<String>.from(json?['name'] ?? []),
      phone: List<String>.from(json?['phone'] ?? []),
      password: List<String>.from(json?['password'] ?? []),
      city: List<String>.from(json?['city'] ?? []),
      longitude: List<String>.from(json?['longitude'] ?? []),
      latitude: List<String>.from(json?['latitude'] ?? []),
      specializations: List<String>.from(json?['specializations.0'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": super.name,
      "phone": super.phone,
      "password": super.password,
      "longitude": this.longitude,
      "latitude": this.latitude,
      "specializations": this.specializations,
      "city": this.city,
    };
  }

  @override
  String toString() {
    return 'CompanyPropError{name: ${super.name}, phone: ${super.phone}, password: ${super.password}, longitude: $longitude, latitude: $latitude, specializations: $specializations, city: $city}';
  }
//
}
