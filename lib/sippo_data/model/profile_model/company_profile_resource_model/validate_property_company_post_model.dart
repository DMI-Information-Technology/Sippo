class ValidatePropCompanyPostModel {
  List<String>? title;
  List<String>? body;
  List<String>? image;

  ValidatePropCompanyPostModel({
    this.title,
    this.body,
    this.image,
  });

  factory ValidatePropCompanyPostModel.fromJson(Map<String, dynamic> json) {
    return ValidatePropCompanyPostModel(
      title: List<String>.from(json["title"] ?? []),
      body: List<String>.from(json["body"] ?? []),
      image: List<String>.from(json["image"] ?? []),
    );
  }
//

//
}
