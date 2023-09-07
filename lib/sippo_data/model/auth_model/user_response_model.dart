import 'package:jobspot/utils/app_use.dart';

import 'entity_model.dart';

class UserResponseModel extends EntityModel {
  UserResponseModel({
    super.id,
    super.name,
    super.phone,
    super.secondaryPhone,
    super.email,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      id: json["id"],
      name: json["name"],
      phone: json["phone"],
      secondaryPhone: json["secondary_phone"],
      email: json["email"],
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "phone": this.phone,
      "secondary_phone": this.secondaryPhone,
      "email": this.email,
    };
  }

  @override
  String toString() {
    return 'UserResponseModel{id: $id, name: $name, phone: $phone, secondaryPhone: $secondaryPhone, email: $email}';
  }
  @override
  // TODO: implement locationCity
  String? get locationCity => null;

  @override
  // TODO: implement userType
  AppUsingType get userType => AppUsingType.user;
//
}
