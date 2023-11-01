import 'package:jobspot/sippo_data/model/image_resource_model/image_resource_model.dart';

class AdModel {
  final String? url;
  final ImageResourceModel? image;

  const AdModel({
    this.url,
    this.image,
  });

  factory AdModel.fromJson(Map<String, dynamic>? json) {
    return AdModel(
      url: json?["url"],
      image: json?['image'] != null
          ? ImageResourceModel.fromJson(json?["image"])
          : null,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdModel &&
          runtimeType == other.runtimeType &&
          url == other.url &&
          image == other.image;

  @override
  int get hashCode => url.hashCode ^ image.hashCode;

  @override
  String toString() {
    return 'AdModel{url: $url, image: $image}';
  }

//
}
