class LanguageModel {
  const LanguageModel({
    this.id,
    this.name,
    this.isNative = false,
    this.level,
  });

  factory LanguageModel.fromJson(Map<String, dynamic>? json) {
    return LanguageModel(
      id: json?["id"],
      name: json?["name"],
      isNative: json?["isNative"],
      level: json?["level"],
    );
  }

  final int? id;
  final String? name;
  final bool isNative;
  final String? level;

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
