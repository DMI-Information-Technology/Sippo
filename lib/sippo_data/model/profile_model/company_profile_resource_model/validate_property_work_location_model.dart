class ValidatePropertyWorkLocationModel {
  ValidatePropertyWorkLocationModel({
    this.address,
    this.longitude,
    this.latitude,
    this.isHQ,
  });

  final List<String>? address;
  final List<String>? longitude;
  final List<String>? latitude;
  final List<String>? isHQ;


  factory ValidatePropertyWorkLocationModel.fromJson(
      Map<String, dynamic> json) {
    return ValidatePropertyWorkLocationModel(
      address: List.of(json["address"])
          .map((i) => json["address"].toString())
          .toList(),
      longitude: List.of(json["longitude"])
          .map((i) => json["longitude"].toString())
          .toList(),
      latitude: List.of(json["latitude"])
          .map((i) => json["latitude"].toString())
          .toList(),
      isHQ: List.of(json["isHQ"]).map((i) => json["isHQ"].toString()).toList(),
    );
  }
//
}
