class UserProjectsModel {
  const UserProjectsModel({
    this.id,
    this.name,
    this.date,
    this.description,
  });

  factory UserProjectsModel.fromJson(Map<String, dynamic> json) {
    return UserProjectsModel(
      id: json["id"],
      name: json["name"],
      date: json["date"],
      description: json["description"],
    );
  }

  final int? id;
  final String? name;
  final String? date;
  final String? description;

  UserProjectsModel copyWith({
    int? id,
    String? name,
    String? date,
    String? description,
  }) =>
      UserProjectsModel(
        id: id ?? this.id,
        name: name ?? this.name,
        date: date ?? this.date,
        description: description ?? this.description,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'date': date,
        'description': description,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProjectsModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          date == other.date &&
          description == other.description;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ date.hashCode ^ description.hashCode;

}
