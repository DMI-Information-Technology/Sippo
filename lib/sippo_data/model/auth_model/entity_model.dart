import '../../../utils/app_use.dart';

abstract class EntityModel {
  int? id;
  final String? name;
  final String? phone;
  final String? secondaryPhone;
  final String? email;

  String? get locationCity;

  AppUsingType get userType;

  EntityModel({
    this.id,
    this.name,
    this.phone,
    this.secondaryPhone,
    this.email,
  });

  bool get isProfileBlank =>
      (name == null || (name != null && name!.trim().isEmpty)) ||
      (phone == null || (phone != null && phone!.trim().isEmpty));

  Map<String, dynamic> toJson();

//

//
}
