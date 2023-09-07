class ValidatePropLanguageModel {
  ValidatePropLanguageModel({
    this.name,
    this.isNative,
    this.level,
  });

  List<String>? name;
  List<String>? isNative;
  List<String>? level;

  ValidatePropLanguageModel copyWith({
    List<String>? name,
    List<String>? isNative,
    List<String>? level,
  }) =>
      ValidatePropLanguageModel(
        name: name ?? this.name,
        isNative: isNative ?? this.isNative,
        level: level ?? this.level,
      );

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'is_native': this.isNative,
      'level': this.level,
    };
  }

  factory ValidatePropLanguageModel.fromJson(Map<String, dynamic> map) {
    return ValidatePropLanguageModel(
      name: map['name'] != null ? map['name'].cast<String>() : [],
      isNative: map['is_native'] != null ? map['is_native'].cast<String>() : [],
      level: map['level'] != null ? map['level'].cast<String>() : [],
    );
  }

  @override
  String toString() {
    return 'ValidatePropLanguageModel{ name: $name, isNative: $isNative, level: $level}';
  }
}
