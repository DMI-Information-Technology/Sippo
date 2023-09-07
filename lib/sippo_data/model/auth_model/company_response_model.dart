import 'package:jobspot/utils/app_use.dart';

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

  @override
  // TODO: implement locationCity
  String? get locationCity => this.city;



  @override
  // TODO: implement userType
  AppUsingType get userType => AppUsingType.company;
  @override
  Map<String, dynamic> toJson() {
    return {
      "id": super.id,
      "name": super.name,
      "phone": super.phone,
      "secondaryPhone": super.secondaryPhone,
      "email": super.email,
      "city": this.city,
      "locations": this.locations,
    };
  }
//
}
