class ValidatePropertyImageResourceModel {
  ValidatePropertyImageResourceModel({
    this.image,
  });

  @override
  String toString() {
    return 'ValidatePropertyImageResourceModel{image: $image}';
  }

  factory ValidatePropertyImageResourceModel.fromJson(dynamic json) {
    return ValidatePropertyImageResourceModel(
        image: json['image'] != null ? json['image'].cast<String>() : []);
  }

  final List<String>? image;


}
