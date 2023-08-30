import '../../../utils/app_use.dart';

abstract class EntityModel {
  final int? id;
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

  Map<String, dynamic> toJson();


//

//
}