import 'package:my_project/app/common/enums/payment_type.dart';
import 'package:my_project/data/model/card_model.dart';
import 'package:my_project/data/model/guest_model.dart';
import 'package:my_project/data/model/hotel_model.dart';
import 'package:my_project/data/model/promo_model.dart';
import 'package:my_project/data/model/room_model.dart';

class BookingDetailModel{
  final String? id;
  final HotelModel? hotel;
  final RoomModel? room;
  final List<GuestModel>? guest;
  final TypePayment? typePayment;
  final CardModel? card;
  final PromoModel? promo;
  final DateTime? dateStart;
  final DateTime? dateEnd;
  final DateTime? createdAt;

  const BookingDetailModel({
    required this.id,
    required this.hotel,
    required this.room,
    required this.guest,
    required this.typePayment,
    required this.card,
    required this.promo,
    required this.dateStart,
    required this.dateEnd,
    required this.createdAt,
  });
}