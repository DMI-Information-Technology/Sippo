import 'package:google_maps_flutter/google_maps_flutter.dart';

class CoordLocation {
  final String? longitude;
  final String? latitude;

  double? get dLatitude {
    try {
      return double.parse(latitude ?? '0');
    } catch (e, s) {
      print(s);
      return null;
    }
  }

  double? get dLongitude {
    try {
      return double.parse(longitude ?? "0");
    } catch (e, s) {
      print(s);
      return null;
    }
  }

  CoordLocation({
    this.longitude,
    this.latitude,
  });

  factory CoordLocation.fromDouble({double? latitude, double? longitude}) {
    return CoordLocation(
      latitude: latitude?.toString(),
      longitude: longitude?.toString(),
    );
  }

  LatLng? get toLatLng {
    if (!validateCords()) return null;
    return LatLng(dLatitude!, dLongitude!);
  }

  bool validateCords() {
    double? latitude = dLatitude, longitude = dLongitude;
    if (latitude == null || longitude == null) {
      print("Null latitude and longitude");
      return false;
    }
    // Check if the latitude and longitude are numbers.
    if (!latitude.isFinite || !longitude.isFinite) {
      print("Invalid latitude and longitude");
      return false;
    }

    // Check if the latitude is between -90 and 90 degrees.
    if (latitude < -90 || latitude > 90) {
      print("Invalid latitude and longitude");
      return false;
    }

    // Check if the longitude is between -180 and 180 degrees.
    if (longitude < -180 || longitude > 180) {
      print("Invalid latitude and longitude");
      return false;
    }

    // The latitude and longitude are valid.
    return true;
  }

  @override
  String toString() {
    return 'CordLocation{' +
        ' longitude: $longitude,' +
        ' latitude: $latitude,' +
        '}';
  }

  CoordLocation copyWith({
    String? longitude,
    String? latitude,
  }) {
    return CoordLocation(
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'longitude': this.longitude,
      'latitude': this.latitude,
    };
  }

  factory CoordLocation.fromJson(Map<String, dynamic> map) {
    return CoordLocation(
      longitude: map['longitude'].toString(),
      latitude: map['latitude'].toString(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoordLocation &&
          runtimeType == other.runtimeType &&
          longitude == other.longitude &&
          latitude == other.latitude;

  @override
  int get hashCode => longitude.hashCode ^ latitude.hashCode;
}
