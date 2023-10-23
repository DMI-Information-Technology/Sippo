class ImageResourceModel {
  ImageResourceModel({
    this.id,
    this.url,
    this.name,
    this.mimeType,
    this.size,
  });

  factory ImageResourceModel.fromJson(Map<String, dynamic>? json) {
    return ImageResourceModel(
      id: json?["id"],
      url: json?["url"],
      name: json?["name"],
      size: json?["size"],
      mimeType: json?["mimeType"],
    );
  }

  final int? id;
  final String? url;
  final String? name;
  final String? mimeType;
  final String? size;

  ImageResourceModel copyWith({
    int? id,
    String? url,
    String? name,
    String? mimeType,
    String? size,
  }) =>
      ImageResourceModel(
        id: id ?? this.id,
        url: url ?? this.url,
        name: name ?? this.name,
        mimeType: mimeType ?? this.mimeType,
        size: size ?? this.size,
      );

  @override
  String toString() {
    return 'ImageResourceModel{url: $url, name: $name, mimeType: $mimeType, size: $size}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageResourceModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          url == other.url &&
          name == other.name &&
          mimeType == other.mimeType &&
          size == other.size;

  @override
  int get hashCode =>
      id.hashCode ^
      url.hashCode ^
      name.hashCode ^
      mimeType.hashCode ^
      size.hashCode;
}
