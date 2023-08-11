class AppreciationInfoCardModel {
  final String? awardName;
  final String? categoryAchieve;
  final String? year;

  AppreciationInfoCardModel({this.awardName, this.categoryAchieve, this.year});

  AppreciationInfoCardModel copyWith({
    String? awardName,
    String? categoryAchieve,
    String? date,
  }) {
    return AppreciationInfoCardModel(
      awardName: awardName ?? this.awardName,
      categoryAchieve: categoryAchieve ?? this.categoryAchieve,
      year: date ?? this.year,
    );
  }

  @override
  String toString() {
    return 'AppreciationInfoCardModel{awardName: $awardName, cateogryAchieve: $categoryAchieve, date: $year}';
  }

  factory AppreciationInfoCardModel.fromJson(Map<String, dynamic>? json) {
    return AppreciationInfoCardModel(
      awardName: json != null ? json["awardName"] : "",
      categoryAchieve: json != null ? json["categoryAchieve"] : "",
      year: json != null ? json["year"] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "awardName": this.awardName,
      "categoryAchieve": this.categoryAchieve,
      "year": this.year,
    };
  }
//
}
