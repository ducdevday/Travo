import 'package:my_project/data/model/seat_place_model.dart';

class FlightModel {
  final String? id;
  final AirlineType? airline;
  final DateTime? departureTime;
  final DateTime? arriveTime;
  final String? fromPlace;
  final String? toPlace;
  final String? no;
  final num? price;

  // final List<Map<String, List<bool>>>? seat;
  final List<SeatPlaceModel>? seat;

  const FlightModel(
      {this.id,
      this.airline,
      this.departureTime,
      this.arriveTime,
      this.fromPlace,
      this.toPlace,
      this.no,
      this.price,
      this.seat});

  factory FlightModel.fromJson(Map<String, dynamic> json) {
    return FlightModel(
      id: json["id"] as String?,
      airline: json["airline"] == null
          ? null
          : AirlineType.fromJson(json["airline"]),
      departureTime: json["departure_time"] == null
          ? null
          : DateTime.fromMicrosecondsSinceEpoch(
              json["departure_time"].microsecondsSinceEpoch),
      arriveTime: json["arrive_time"] == null
          ? null
          : DateTime.fromMicrosecondsSinceEpoch(
              json["arrive_time"].microsecondsSinceEpoch),
      fromPlace: json["from_place"] as String?,
      toPlace: json["to_place"] as String?,
      no: json["no"] as String?,
      price: json["price"] as num?,
      // seat: List<Map<String, List<bool>>>.from(json['seat'].map((seat) {
      //   return Map<String, List<bool>>.from(seat.map((key, value) {
      //     return MapEntry(key, List<bool>.from(value));
      //   }));
      // })),
      seat: List<SeatPlaceModel>.from(json['seat'].map((seat) {
        return SeatPlaceModel.fromJson(seat);
      })),
    );
  }
}

enum AirlineType {
  LionAir,
  AirAsia,
  BatikAir,
  Garuna,
  Citilink;

  String toJson() => name;

  static AirlineType fromJson(String json) => values.byName(json);
}
