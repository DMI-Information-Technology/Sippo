class LocationAddress {
  final int? id;
  final String? name;

  const LocationAddress({
    this.id,
    this.name,
  });

  LocationAddress copyWith({
    int? id,
    String? name,
  }) {
    return LocationAddress(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'LocationAddress{id: $id, name: $name}';
  }

  factory LocationAddress.fromJson(Map<String, dynamic> json) {
    return LocationAddress(
      id: switch (json["id"]) {
        int() => json["id"],
        String() => int.parse(json["id"]),
        _ => null,
      },
      name: json["name"],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is LocationAddress &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

//
}
