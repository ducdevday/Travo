import 'package:my_project/app/common/enums/payment_type.dart';
import 'package:my_project/data/model/card_model.dart';
import 'package:my_project/data/model/guest_model.dart';

class BookingModel {
  final String? id;
  final String email;
  final String hotel;
  final String room;
  final List<GuestModel> guest;
  final TypePayment typePayment;
  final CardModel? card;
  final String? promoCode;
  final DateTime dateStart;
  final DateTime dateEnd;
  final DateTime? createdAt;

  const BookingModel(
      {this.id,
      required this.email,
      required this.hotel,
      required this.room,
      required this.guest,
      required this.typePayment,
      this.card,
      this.promoCode,
      required this.dateStart,
      required this.dateEnd,
      this.createdAt});

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json["id"] as String?,
      email: json["email"] as String,
      hotel: json["hotel"] as String,
      room: json["room"] as String,
      guest: List.of(json["guest"]).map((i) => GuestModel.fromJson(i)).toList(),
      typePayment: TypePayment.fromJson(json["typePayment"]),
      card: json["card"] != null ? CardModel.fromJson(json["card"]) : null,
      promoCode: json["promoCode"] as String?,
      dateStart: DateTime.parse(json["dateStart"]),
      dateEnd: DateTime.parse(json["dateEnd"]),
      createdAt:
          json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": this.email,
      "hotel": this.hotel,
      "room": this.room,
      "guest": this.guest.map((g) => g.toJson()).toList(),
      "typePayment": this.typePayment.toJson(),
      "card": this.card?.toJson(),
      "promoCode": this.promoCode,
      "dateStart": this.dateStart.toIso8601String(),
      "dateEnd": this.dateEnd.toIso8601String(),
      "createdAt": this.createdAt?.toIso8601String(),
    };
  }
}
