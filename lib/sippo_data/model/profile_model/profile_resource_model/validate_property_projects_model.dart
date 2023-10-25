class ValidatePropertyProjectsModel {
  ValidatePropertyProjectsModel({
    this.name,
    this.date,
    this.description,
  });

  ValidatePropertyProjectsModel.fromJson(dynamic json) {
    name = json['name'] != null ? json['name'].cast<String>() : null;
    date = json['date'] != null ? json['date'].cast<String>() : null;
    description =
        json['description'] != null ? json['description'].cast<String>() : null;
  }

  List<String>? name;
  List<String>? date;
  List<String>? description;

  ValidatePropertyProjectsModel copyWith({
    List<String>? name,
    List<String>? date,
    List<String>? description,
  }) =>
      ValidatePropertyProjectsModel(
        name: name ?? this.name,
        date: date ?? this.date,
        description: description ?? this.description,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['date'] = date;
    map['description'] = description;
    return map;
  }
}
