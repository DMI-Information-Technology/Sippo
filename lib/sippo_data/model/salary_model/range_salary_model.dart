class RangeSalaryModel {
  final double? from;
  final double? to;

  const RangeSalaryModel({
    this.from,
    this.to,
  });

  factory RangeSalaryModel.fromDynamic(from, to) {
    return RangeSalaryModel(
      from: from != null && from is String ? double.parse(from) : from,
      to: to != null && to is String ? double.parse(to) : to,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "from": this.from,
      "to": this.to,
    };
  }

  RangeSalaryModel copyWith({
    double? from,
    double? to,
  }) {
    return RangeSalaryModel(
      from: from ?? this.from,
      to: to ?? this.to,
    );
  } //
}
