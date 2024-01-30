import 'package:my_project/app/common/enums/payment_type.dart';
import 'package:my_project/data/model/card_model.dart';
import 'package:my_project/data/model/guest_model.dart';
import 'package:my_project/data/model/seat_model.dart';

class BookingFlightModel {
  final String? id;
  final String email;
  final String flight;
  final GuestModel guest;
  final String? promoCode;
  final SeatModel seat;
  final TypePayment typePayment;
  final CardModel? card;
  final DateTime? createdAt;

  const BookingFlightModel({
    this.id,
    required this.email,
    required this.flight,
    required this.guest,
    this.promoCode,
    required this.seat,
    required this.typePayment,
    this.card,
    this.createdAt,
  });

  factory BookingFlightModel.fromJson(Map<String, dynamic> json) {
    return BookingFlightModel(
      id: json["id"] as String?,
      email: json["email"],
      flight: json["flight"],
      guest: GuestModel.fromJson(json["guest"]),
      promoCode: json["promoCode"] as String?,
      seat: SeatModel.fromJson(json["seat"]),
      typePayment: TypePayment.fromJson(json["typePayment"]),
      card: json["card"] == null ? null : CardModel.fromJson(json["card"]),
      createdAt:
          json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": this.email,
      "flight": this.flight,
      "guest": this.guest.toJson(),
      "promoCode": this.promoCode,
      "seat": this.seat.toJson(),
      "typePayment": this.typePayment.toJson(),
      "card": this.card?.toJson(),
      "createdAt": this.createdAt?.toIso8601String(),
    };
  }
}
