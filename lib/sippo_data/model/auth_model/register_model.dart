// enum AuthType { user, company }

class RegisterModel<T> {
  String? token;
  T? model;

  RegisterModel({this.token, T? this.model});

  factory RegisterModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> json) entityModel,
  ) {
    return RegisterModel<T>(
      token: json["token"],
      model: entityModel(json),
    );
  }
}
