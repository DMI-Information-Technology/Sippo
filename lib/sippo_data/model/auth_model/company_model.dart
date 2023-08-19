
class CompanyModel {
  final String? name;
  final String? phone;
  final String? password;
  final String? city;
  final double? longitude;
  final double? latitude;
  final List<int>? specializations;
  final String? passwordConfirmation;

  CompanyModel({
    this.name,
    this.phone,
    this.password,
    this.city,
    this.longitude,
    this.latitude,
    this.specializations,
    this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "phone": phone,
      "password": password,
      "city": city,
      "longitude": longitude,
      "latitude": latitude,
      "specializations": specializations,
      "password_confirmation": passwordConfirmation,
    };
  }

  Map<String, dynamic> toLoginJson() {
    return {
      "phone": phone,
      "password": password,
    };
  }

  @override
  String toString() {
    return 'CompanyModel{name: $name, phone: $phone, password: $password, city: $city, longitude: $longitude, latitude: $latitude, specializations: $specializations, passwordConfirmation: $passwordConfirmation}';
  }
}
