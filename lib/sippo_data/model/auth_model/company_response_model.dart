import 'cord_location.dart';
import 'entity_model.dart';

class CompanyResponseModel extends EntityModel {
  String? city;
  List<CordLocation>? locations;

  CompanyResponseModel({
    super.id,
    super.name,
    super.phone,
    super.secondaryPhone,
    super.email,
    this.city,
    this.locations,
  });

  factory CompanyResponseModel.fromJson(Map<String, dynamic> json) {
    return CompanyResponseModel(
      id: json["id"],
      name: json["name"],
      phone: json["phone"],
      secondaryPhone: json["secondaryPhone"],
      email: json["email"],
      city: json["city"],
      locations: List.of(json["locations"])
          .map(
            (cord) => CordLocation.fromJson(cord),
          )
          .toList(),
    );
  }
//
}
