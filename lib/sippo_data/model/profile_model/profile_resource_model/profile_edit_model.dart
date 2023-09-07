import 'package:jobspot/utils/app_use.dart';

import '../../auth_model/entity_model.dart';

class ProfileInfoModel extends EntityModel {
  ProfileInfoModel({
    super.name,
    super.email,
    super.phone,
    super.secondaryPhone,
    this.gender,
    this.bio,
  });

  bool get isProfileBlank =>
      (name == null || (name != null && name!.trim().isEmpty)) ||
      (phone == null || (phone != null && phone!.trim().isEmpty));

  factory ProfileInfoModel.fromJson(dynamic json) => ProfileInfoModel(
        name: json["name"],
        phone: json["phone"],
        secondaryPhone: json["secondary_phone"],
        email: json["email"],
        gender: json['gender'],
        bio: json['bio'],
      );

  String? gender;

  String? bio;

  ProfileInfoModel copyWith({
    String? name,
    String? email,
    String? secondaryPhone,
    String? phone,
    String? gender,
    String? bio,
  }) =>
      ProfileInfoModel(
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        secondaryPhone: secondaryPhone ?? this.secondaryPhone,
        gender: gender ?? this.gender,
        bio: bio ?? this.bio,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'gender': gender,
        'email': email,
        'phone': phone,
        'secondary_phone': secondaryPhone,
        'bio': bio,
      }..removeWhere((_, v) => v == null || v.trim().isEmpty);

  @override
  String? get locationCity => null;

  @override
  AppUsingType get userType => AppUsingType.user;

  @override
  String toString() {
    return 'ProfileInfoModel{name: $name, phone: $phone, secondaryPhone: $secondaryPhone, email: $email, gender: $gender, bio: $bio}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileInfoModel &&
          runtimeType == other.runtimeType &&
          super.name == other.name &&
          super.email == other.email &&
          super.phone == other.phone &&
          super.secondaryPhone == other.secondaryPhone &&
          gender == other.gender &&
          bio == other.bio;

  @override
  int get hashCode =>
      super.name.hashCode ^
      super.email.hashCode ^
      super.phone.hashCode ^
      super.secondaryPhone.hashCode ^
      gender.hashCode ^
      bio.hashCode;
}
