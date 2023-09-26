class ImageResourceModel {
  ImageResourceModel({
    this.url,
    this.name,
    this.mimeType,
    this.size,
  });

  ImageResourceModel.fromJson(dynamic json) {
    url = json['url'];
    name = json['name'];
    mimeType = json['mime_type'];
    size = json['size'];
  }

  String? url;
  String? name;
  String? mimeType;
  String? size;

  ImageResourceModel copyWith({
    String? url,
    String? name,
    String? mimeType,
    String? size,
  }) =>
      ImageResourceModel(
        url: url ?? this.url,
        name: name ?? this.name,
        mimeType: mimeType ?? this.mimeType,
        size: size ?? this.size,
      );

  @override
  String toString() {
    return 'ImageResourceModel{url: $url, name: $name, mimeType: $mimeType, size: $size}';
  }
}
