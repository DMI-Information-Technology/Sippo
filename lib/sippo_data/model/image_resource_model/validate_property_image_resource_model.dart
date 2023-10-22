class ValidatePropertyImageResourceModel {
  ValidatePropertyImageResourceModel({
    this.image,
  });

  @override
  String toString() {
    return 'ValidatePropertyImageResourceModel{image: $image}';
  }

  factory ValidatePropertyImageResourceModel.fromJson(
      Map<String, dynamic>? json) {
    return ValidatePropertyImageResourceModel(
      image:
          json?['image'] != null ? (json?['image'] ?? []).cast<String>() : null,
    );
  }

  final List<String>? image;
}
