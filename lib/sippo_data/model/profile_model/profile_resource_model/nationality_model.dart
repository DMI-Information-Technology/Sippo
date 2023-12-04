class NationalityModel {
  NationalityModel({
      this.id, 
      this.name,});

  NationalityModel.fromJson(Map<String,dynamic>? json) {
    id = json?['id'];
    name = json?['name'];
  }
  int? id;
  String? name;
NationalityModel copyWith({  int? id,
  String? name,
}) => NationalityModel(  id: id ?? this.id,
  name: name ?? this.name,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

  @override
  String toString() {
    return 'NationalityModel{id: $id, name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NationalityModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}