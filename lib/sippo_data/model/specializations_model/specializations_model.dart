class SpecializationModel {
  final int? id;
  final String? name;

  SpecializationModel({this.id, this.name});

  factory SpecializationModel.fromJson(Map<String, dynamic>? json) {
    return SpecializationModel(
      id: json?['id'],
      name: json?['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpecializationModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() {
    return 'SpecializationModel{id: $id, name: $name}';
  }
}
