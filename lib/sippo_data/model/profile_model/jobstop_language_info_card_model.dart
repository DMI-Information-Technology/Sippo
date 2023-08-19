class LanguageInfoCardModel {
  String? languageName;
  String? countryFlag;
  String? talkingLevel;

  String? writtenLevel;

  bool? firstLanguage;

  LanguageInfoCardModel({
    this.languageName,
    this.countryFlag,
    this.talkingLevel,
    this.writtenLevel,
    this.firstLanguage,
  });

  factory LanguageInfoCardModel.fromJson(Map<String, dynamic> json) {
    return LanguageInfoCardModel(
      languageName: json["languageName"],
      countryFlag: json["countryFlag"],
      talkingLevel: json["talkingLevel"],
      writtenLevel: json["writtenLevel"],
      firstLanguage: json["firstLanguage"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "languageName": this.languageName,
      "countryFlag": this.countryFlag,
      "talkingLevel": this.talkingLevel,
      "writtenLevel": this.writtenLevel,
      "firstLanguage": this.firstLanguage,
    };
  }

  LanguageInfoCardModel copyWith({
    String? languageName,
    String? countryFlag,
    String? talkingLevel,
    String? writtenLevel,
    bool? firstLanguage,
  }) {
    return LanguageInfoCardModel()
      ..languageName = languageName ?? this.languageName
      ..countryFlag = countryFlag ?? this.countryFlag
      ..talkingLevel = talkingLevel ?? this.talkingLevel
      ..writtenLevel = writtenLevel ?? this.writtenLevel
      ..firstLanguage = firstLanguage ?? this.firstLanguage;
  }

  @override
  String toString() {
    return 'LanguageInfoCardModel{languageName: $languageName, countryFlag: $countryFlag, talkingLevel: $talkingLevel, writtenLevel: $writtenLevel, firstLanguage: $firstLanguage}';
  }

//
}
