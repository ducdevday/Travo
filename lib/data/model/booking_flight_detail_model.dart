import 'package:my_project/app/common/enums/payment_type.dart';
import 'package:my_project/data/model/card_model.dart';
import 'package:my_project/data/model/flight_model.dart';
import 'package:my_project/data/model/guest_model.dart';
import 'package:my_project/data/model/promo_model.dart';
import 'package:my_project/data/model/seat_model.dart';

class BookingFlightDetailModel {
  final String? id;
  final FlightModel flight;
  final GuestModel guest;
  final PromoModel? promo;
  final SeatModel seat;
  final TypePayment typePayment;
  final CardModel? card;
  final DateTime? createdAt;

  const BookingFlightDetailModel({
    required this.id,
    required this.flight,
    required this.guest,
    required this.promo,
    required this.seat,
    required this.typePayment,
    required this.card,
    required this.createdAt,
  });
}
