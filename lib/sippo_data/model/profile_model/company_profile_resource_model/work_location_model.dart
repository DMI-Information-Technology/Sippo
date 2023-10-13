import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/cord_location.dart';

class WorkLocationModel {
  const WorkLocationModel({
    this.id,
    this.companyId,
    this.address,
    this.location,
    this.isHQ,
  });

  factory WorkLocationModel.fromJson(Map<String, dynamic> json) {
    return WorkLocationModel(
      id: json["id"],
      companyId: json['company_id'],
      address: json["address"],
      location: CoordLocation.fromJson({
        'longitude': json['longitude'],
        'latitude': json['latitude'],
      }),
      isHQ: json["is_hq"],
    );
  }

  final int? id;
  final int? companyId;
  final String? address;
  final CoordLocation? location;
  final bool? isHQ;

  Map<String, dynamic> toJson() => {
        "address": address,
        "is_hq": isHQ,
        'latitude': location?.latitude,
        'longitude': location?.longitude,
      };

  @override
  String toString() {
    return 'WorkLocationModel{id: $id, companyId: $companyId, address: $address, location: $location, isHQ: $isHQ}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkLocationModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          companyId == other.companyId &&
          address == other.address &&
          location == other.location &&
          isHQ == other.isHQ;

  @override
  int get hashCode =>
      id.hashCode ^
      companyId.hashCode ^
      address.hashCode ^
      location.hashCode ^
      isHQ.hashCode;
}
