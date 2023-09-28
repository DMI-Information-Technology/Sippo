class CvModel {
  CvModel({
    this.url,
    this.name,
    this.mimeType,
    this.size,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CvModel &&
              runtimeType == other.runtimeType &&
              url == other.url &&
              name == other.name &&
              mimeType == other.mimeType &&
              size == other.size;

  @override
  int get hashCode =>
      url.hashCode ^ name.hashCode ^ mimeType.hashCode ^ size.hashCode;
  final String? url;
  final String? name;
  final String? mimeType;
  final String? size;

  factory CvModel.fromJson(Map<String, dynamic> json) {
    return CvModel(
      url: json["url"],
      name: json["name"],
      mimeType: json["mimeType"],
      size: json["size"],
    );
  }

  CvModel copyWith({
    String? url,
    String? name,
    String? mimeType,
    String? size,
  }) =>
      CvModel(
        url: url ?? this.url,
        name: name ?? this.name,
        mimeType: mimeType ?? this.mimeType,
        size: size ?? this.size,
      );

  @override
  String toString() {
    return 'Cv{url: $url, name: $name, mimeType: $mimeType, size: $size}';
  }
}