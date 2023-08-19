
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
      secondaryPhone: json["secondaryPhone"],
      email: json["email"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "phone": this.phone,
      "secondaryPhone": this.secondaryPhone,
      "email": this.email,
    };
  }
//
}
