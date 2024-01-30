class SeatModel{
  final String? name;
  final SeatType? type;

  const SeatModel({
    this.name,
    this.type,
  });

  factory SeatModel.fromJson(Map<String, dynamic> json) {
    return SeatModel(
      name: json["name"],
      type: SeatType.fromJson(json["type"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "type": this.type?.toJson(),
    };
  }
}

enum SeatType{
  Economy,
  Bussiness;

  String toJson() => name;

  static SeatType fromJson(String json) => values.byName(json);
}