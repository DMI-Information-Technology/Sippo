import 'package:sippo/sippo_data/model/profile_model/company_profile_resource_model/cord_location.dart';

import '../../locations_model/location_address_model.dart';

class WorkLocationModel {
  const WorkLocationModel({
    this.id,
    this.userId,
    this.locationAddress,
    this.cordLocation,
    this.isHQ,
  });

  factory WorkLocationModel.fromJson(Map<String, dynamic>? json) {
    return WorkLocationModel(
      id: json?["id"],
      userId: json?['user_id'],
      locationAddress: json?['location'] != null
          ? LocationAddress.fromJson(json?['location'])
          : null,
      cordLocation: CoordLocation.fromJson({
        'longitude': json?['longitude'],
        'latitude': json?['latitude'],
      }),
      isHQ: json?["is_hq"],
    );
  }

  bool isEqualToContentOf(WorkLocationModel? value) {
    return value?.cordLocation == this.cordLocation &&
        value?.locationAddress == this.locationAddress &&
        value?.isHQ == this.isHQ;
  }

  final int? id;
  final int? userId;
  final CoordLocation? cordLocation;
  final LocationAddress? locationAddress;
  final bool? isHQ;

  Map<String, dynamic> toJson() => {
        "is_hq": isHQ,
        'latitude': cordLocation?.latitude,
        'longitude': cordLocation?.longitude,
        'location_id': locationAddress?.id
      };

  @override
  String toString() {
    return 'WorkLocationModel{id: $id, companyId: $userId, locationAddress: $locationAddress, location: $cordLocation, isHQ: $isHQ}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkLocationModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          locationAddress == other.locationAddress &&
          cordLocation == other.cordLocation &&
          isHQ == other.isHQ;

  @override
  int get hashCode =>
      id.hashCode ^
      userId.hashCode ^
      locationAddress.hashCode ^
      cordLocation.hashCode ^
      isHQ.hashCode;

  WorkLocationModel copyWith({
    int? id,
    int? userId,
    CoordLocation? cordLocation,
    LocationAddress? locationAddress,
    bool? isHQ,
  }) {
    return WorkLocationModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      cordLocation: cordLocation ?? this.cordLocation,
      locationAddress: locationAddress ?? this.locationAddress,
      isHQ: isHQ ?? this.isHQ,
    );
  }
}
