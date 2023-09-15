import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/cord_location.dart';

class WorkLocationModel {
  const WorkLocationModel({
    this.address,
    this.location,
    this.isHQ,
  });

  factory WorkLocationModel.fromJson(Map<String, dynamic> json) {
    return WorkLocationModel(
      address: json["address"],
      location: CordLocation.fromJson({
        'longitude': json['longitude'],
        'latitude': json['latitude'],
      }),
      isHQ: json["is_hq"],
    );
  }

  final String? address;
  final CordLocation? location;
  final bool? isHQ;

  Map<String, dynamic> toJson() => {
        "address": address,
        "is_hq": isHQ,
        'latitude': location?.latitude,
        'longitude': location?.longitude,
      };

  @override
  String toString() {
    return 'WorkLocationModel{address: $address, location: $location, isHQ: $isHQ}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkLocationModel &&
          runtimeType == other.runtimeType &&
          address == other.address &&
          location == other.location &&
          isHQ == other.isHQ;

  @override
  int get hashCode => address.hashCode ^ location.hashCode ^ isHQ.hashCode;
}
