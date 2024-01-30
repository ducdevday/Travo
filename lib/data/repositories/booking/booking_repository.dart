import 'package:my_project/data/dataprovider/booking/booking_dataprovider.dart';
import 'package:my_project/data/dataprovider/hotel/hotel_dataprovider.dart';
import 'package:my_project/data/dataprovider/promo/promo_dataprovider.dart';
import 'package:my_project/data/dataprovider/room/room_dataprovider.dart';
import 'package:my_project/data/model/booking_detail_model.dart';
import 'package:my_project/data/model/booking_model.dart';
import 'package:my_project/data/model/hotel_model.dart';
import 'package:my_project/data/model/promo_model.dart';
import 'package:my_project/data/model/room_model.dart';
import 'package:my_project/data/repositories/booking/booking_repository_base.dart';

class BookingRepository extends BookingRepositoryBase {
  final BookingDataProvider bookingDataProvider;
  final HotelDataProvider hotelDataProvider;
  final RoomDataProvider roomDataProvider;
  final PromoDataProvider promoDataProvider;

  BookingRepository(
      {required this.bookingDataProvider,
      required this.hotelDataProvider,
      required this.roomDataProvider,
      required this.promoDataProvider});

  @override
  Future<String> createBooking(BookingModel booking) async {
    final bookingId = await bookingDataProvider.createBooking(booking.toJson());
    return bookingId;
  }

  @override
  Future<BookingDetailModel> getBookingDetail(String bookingId) async {
    final bookingJson = await bookingDataProvider.getBookingById(bookingId);
    final booking = BookingModel.fromJson(bookingJson);
    final hotelJson = await hotelDataProvider.getHotelById(booking.hotel);
    final hotel = HotelModel.fromJson(hotelJson);
    final roomJson = await roomDataProvider.getRoomsById(booking.room);
    final room = RoomModel.fromJson(roomJson);
    final Map<String, dynamic> promoJson;
    PromoModel? promo;
    if (booking.promoCode != null) {
      promoJson = await promoDataProvider.getPromoById(booking.promoCode!);
      promo = PromoModel.fromJson(promoJson);
    }
    final bookingDetail = BookingDetailModel(
        id: bookingId,
        hotel: hotel,
        room: room,
        guest: booking.guest,
        typePayment: booking.typePayment,
        card: booking.card,
        promo: promo,
        dateStart: booking.dateStart,
        dateEnd: booking.dateEnd,
        createdAt: booking.createdAt);

    return bookingDetail;
  }

  @override
  Future<List<BookingDetailModel>> getAllBookings(String userEmail) async {
    final data = await bookingDataProvider.getAllBookings(userEmail);
    final bookings = data.map((e) => BookingModel.fromJson(e)).toList();
    final List<BookingDetailModel> bookingDetails = [];
    for (var booking in bookings) {
      final hotelJson = await hotelDataProvider.getHotelById(booking.hotel);
      final hotel = HotelModel.fromJson(hotelJson);
      final roomJson = await roomDataProvider.getRoomsById(booking.room);
      final room = RoomModel.fromJson(roomJson);
      final Map<String, dynamic> promoJson;
      PromoModel? promo;
      if (booking.promoCode != null) {
        promoJson = await promoDataProvider.getPromoById(booking.promoCode!);
        promo = PromoModel.fromJson(promoJson);
      }
      final bookingDetail = BookingDetailModel(
          id: booking.id,
          hotel: hotel,
          room: room,
          guest: booking.guest,
          typePayment: booking.typePayment,
          card: booking.card,
          promo: promo,
          dateStart: booking.dateStart,
          dateEnd: booking.dateEnd,
          createdAt: booking.createdAt);
      bookingDetails.add(bookingDetail);
    }
    return bookingDetails;
  }
}
