class CordLocation {
  String? longitude;
  String? latitude;

  CordLocation({
    this.longitude,
    this.latitude,
  });

  bool isRequiredCord() {
    return double.parse(longitude ?? "0") >= -180 &&
        double.parse(longitude ?? "0") <= 180 &&
        double.parse(latitude ?? "0") >= -90 &&
        double.parse(latitude ?? "0") <= 90;
  }

  @override
  String toString() {
    return 'CordLocation{' +
        ' longitude: $longitude,' +
        ' latitude: $latitude,' +
        '}';
  }

  CordLocation copyWith({
    String? longitude,
    String? latitude,
  }) {
    return CordLocation(
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

  factory CordLocation.fromJson(Map<String, dynamic> map) {
    return CordLocation(
      longitude: map['longitude'] as String,
      latitude: map['latitude'] as String,
    );
  }
}
