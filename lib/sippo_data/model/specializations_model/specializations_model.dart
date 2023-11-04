import 'package:jobspot/sippo_data/model/image_resource_model/image_resource_model.dart';

class SpecializationModel {
  final int? id;
  final String? name;
  final ImageResourceModel? image;

  const SpecializationModel({this.id, this.name, this.image});

  factory SpecializationModel.fromJson(Map<String, dynamic>? json) {
    return SpecializationModel(
      id: json?['id'],
      name: json?['name'],
      image: json?['image'] != null
          ? ImageResourceModel.fromJson(json?['image'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "image": this.image,
    };
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpecializationModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          image == other.image;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ image.hashCode;

  @override
  String toString() {
    return 'SpecializationModel{id: $id, name: $name, image: $image}';
  }
}
