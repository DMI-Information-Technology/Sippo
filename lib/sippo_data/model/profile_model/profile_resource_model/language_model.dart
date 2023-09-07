class LanguageModel {
  LanguageModel({
    this.id,
    this.name,
    this.isNative = false,
    this.level,
  });

  LanguageModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    this.isNative = json['is_native'] ?? false;
    level = json['level'];
  }

  int? id;
  String? name;
  bool isNative = false;
  String? level;

  String? get countryFlag => null;

  LanguageModel copyWith({
    int? id,
    String? name,
    bool? isNative,
    String? level,
  }) =>
      LanguageModel(
        id: id ?? this.id,
        name: name ?? this.name,
        isNative: isNative ?? this.isNative,
        level: level ?? this.level,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['is_native'] = isNative;
    map['level'] = level;
    return map;
  }

  Map<String, dynamic> toCustomJson() {
    final map = <String, dynamic>{};
    map['language_id'] = id;
    map['name'] = name;
    map['is_native'] = isNative;
    map['level'] = level?.toLowerCase();
    return map;
  }

  @override
  String toString() {
    return 'LanguageModel{id: $id, name: $name, isNative: $isNative, level: $level}';
  }
}
