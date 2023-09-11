class ValidatePropCompanyProfileDetailsModel {
  List<String>? name;
  List<String>? phone;
  List<String>? secondaryPhone;
  List<String>? email;
  List<String>? city;
  List<String>? locations;
  List<String>? website;
  List<String>? bio;
  List<String>? employeesCount;
  List<String>? establishmentDate;
  List<String>? specializations;

  factory ValidatePropCompanyProfileDetailsModel.fromJson(
      Map<String, dynamic>? json) {
    return ValidatePropCompanyProfileDetailsModel(
      name: json?['name'] != null ? List<String>.from(json?['name']) : null,
      phone: json?['phone'] != null ? List<String>.from(json?['phone']) : null,
      secondaryPhone: json?['secondary_phone'] != null
          ? List<String>.from(json?['secondary_phone'])
          : null,
      email: json?['email'] != null ? List<String>.from(json?['email']) : null,
      city: json?['city'] != null ? List<String>.from(json?['city']) : null,
      locations: json?['locations'] != null
          ? List<String>.from(
              json?['locations'],
            )
          : null,
      employeesCount: json?['employees_count'] != null
          ? List<String>.from(json?['employees_count'])
          : null,
      establishmentDate: json?['establishment_date'] != null
          ? List<String>.from(json?['establishment_date'])
          : null,
      specializations: json?['specializations'] != null
          ? List<String>.from(json?['specializations'])
          : null,
    );
  }

  ValidatePropCompanyProfileDetailsModel({
    this.name,
    this.phone,
    this.secondaryPhone,
    this.email,
    this.city,
    this.locations,
    this.bio,
    this.employeesCount,
    this.establishmentDate,
    this.specializations,
  });
}
