class PlaceDetailsModel {
  ResultModel? result;
  String? status;

  PlaceDetailsModel({this.result, this.status});

  PlaceDetailsModel.fromJson(Map<String, dynamic>? json) {
    result = json?['result'] != null
        ? new ResultModel.fromJson(json?['result'])
        : null;
    status = json?['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class ResultModel {
  final List<AddressComponentsModel>? addressComponents;
  final String? adrAddress;
  final String? formattedAddress;
  final GeometryModel? geometry;
  final String? icon;
  final String? name;
  final List<PhotosModel>? photos;
  final String? placeId;
  final String? reference;
  final String? scope;
  final List<String>? types;
  final String? url;
  final int? utcOffset;
  final String? vicinity;
  final String? website;

  ResultModel(
      {this.addressComponents,
      this.adrAddress,
      this.formattedAddress,
      this.geometry,
      this.icon,
      this.name,
      this.photos,
      this.placeId,
      this.reference,
      this.scope,
      this.types,
      this.url,
      this.utcOffset,
      this.vicinity,
      this.website});

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      addressComponents: json['address_components'] != null
          ? List.of(json['address_components'])
              .map((e) => AddressComponentsModel.fromJson(e))
              .toList()
          : null,
      adrAddress: json['adr_address'],
      formattedAddress: json['formatted_address'],
      geometry: json['geometry'] != null
          ? GeometryModel.fromJson(json['geometry'])
          : null,
      icon: json['icon'],
      name: json['name'],
      photos: json['photos'] != null
          ? List.of(json['photos']).map((e) => PhotosModel.fromJson(e)).toList()
          : null,
      placeId: json['place_id'],
      reference: json['reference'],
      scope: json['scope'],
      types: json['types'].cast<String>(),
      url: json['url'],
      utcOffset: json['utc_offset'],
      vicinity: json['vicinity'],
      website: json['website'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addressComponents != null) {
      data['address_components'] =
          this.addressComponents!.map((v) => v.toJson()).toList();
    }
    data['adr_address'] = this.adrAddress;
    data['formatted_address'] = this.formattedAddress;
    if (this.geometry != null) {
      data['geometry'] = this.geometry!.toJson();
    }
    data['icon'] = this.icon;
    data['name'] = this.name;
    if (this.photos != null) {
      data['photos'] = this.photos!.map((v) => v.toJson()).toList();
    }
    data['place_id'] = this.placeId;
    data['reference'] = this.reference;
    data['scope'] = this.scope;
    data['types'] = this.types;
    data['url'] = this.url;
    data['utc_offset'] = this.utcOffset;
    data['vicinity'] = this.vicinity;
    data['website'] = this.website;
    return data;
  }
}

class AddressComponentsModel {
  String? longName;
  String? shortName;
  List<String>? types;

  AddressComponentsModel({this.longName, this.shortName, this.types});

  AddressComponentsModel.fromJson(Map<String, dynamic> json) {
    longName = json['long_name'];
    shortName = json['short_name'];
    types = json['types'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['long_name'] = this.longName;
    data['short_name'] = this.shortName;
    data['types'] = this.types;
    return data;
  }
}

class GeometryModel {
  final LocationModel? location;
  final ViewportModel? viewport;

  const GeometryModel({this.location, this.viewport});

  factory GeometryModel.fromJson(Map<String, dynamic> json) {
    return GeometryModel(
      location: json['location'] != null
          ? new LocationModel.fromJson(json['location'])
          : null,
      viewport: json['viewport'] != null
          ? new ViewportModel.fromJson(json['viewport'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.viewport != null) {
      data['viewport'] = this.viewport!.toJson();
    }
    return data;
  }
}

class LocationModel {
  final double? lat;
  final double? lng;

  const LocationModel({this.lat, this.lng});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(lat: json['lat'], lng: json['lng']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class ViewportModel {
  final LocationModel? northeast;
  final LocationModel? southwest;

  ViewportModel({this.northeast, this.southwest});

  factory ViewportModel.fromJson(Map<String, dynamic> json) {
    return ViewportModel(
      northeast: json['northeast'] != null
          ? new LocationModel.fromJson(json['northeast'])
          : null,
      southwest: json['southwest'] != null
          ? new LocationModel.fromJson(json['southwest'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.northeast != null) {
      data['northeast'] = this.northeast!.toJson();
    }
    if (this.southwest != null) {
      data['southwest'] = this.southwest!.toJson();
    }
    return data;
  }
}

class PhotosModel {
  final int? height;
  final List<String>? htmlAttributions;
  final String? photoReference;
  final int? width;

  PhotosModel(
      {this.height, this.htmlAttributions, this.photoReference, this.width});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['html_attributions'] = this.htmlAttributions;
    data['photo_reference'] = this.photoReference;
    data['width'] = this.width;
    return data;
  }

  factory PhotosModel.fromJson(Map<String, dynamic> json) {
    return PhotosModel(
      height: json["height"],
      htmlAttributions: json['html_attributions'].cast<String>(),
      photoReference: json["photoReference"],
      width: json["width"],
    );
  }
//
}
