import 'package:my_project/data/dataprovider/booking/booking_dataprovider.dart';
import 'package:my_project/data/dataprovider/booking_flight/booking_flight_dataprovider.dart';
import 'package:my_project/data/dataprovider/flight/flight_dataprovider.dart';
import 'package:my_project/data/dataprovider/hotel/hotel_dataprovider.dart';
import 'package:my_project/data/dataprovider/promo/promo_dataprovider.dart';
import 'package:my_project/data/dataprovider/room/room_dataprovider.dart';
import 'package:my_project/data/model/booking_detail_model.dart';
import 'package:my_project/data/model/booking_flight_detail_model.dart';
import 'package:my_project/data/model/booking_flight_model.dart';
import 'package:my_project/data/model/booking_model.dart';
import 'package:my_project/data/model/flight_model.dart';
import 'package:my_project/data/model/hotel_model.dart';
import 'package:my_project/data/model/promo_model.dart';
import 'package:my_project/data/model/room_model.dart';
import 'package:my_project/data/repositories/booking/booking_repository_base.dart';
import 'package:my_project/data/repositories/booking_flight/booking_flight_repository_base.dart';

class BookingFlightRepository extends BookingFlightRepositoryBase {
  final BookingFlightDataProvider bookingFlightDataProvider;
  final FlightDataProvider flightDataProvider;
  final PromoDataProvider promoDataProvider;

  BookingFlightRepository(
      {required this.bookingFlightDataProvider,
      required this.flightDataProvider,
      required this.promoDataProvider});

  @override
  Future<List<BookingFlightDetailModel>> getAllBookingFlights(
      String userEmail) async {
    final data =
        await bookingFlightDataProvider.getAllBookingFlights(userEmail);
    final bookingFlights =
        data.map((e) => BookingFlightModel.fromJson(e)).toList();
    final List<BookingFlightDetailModel> bookingFlightDetails = [];
    for (var bookingFlight in bookingFlights) {
      final flightJson =
          await flightDataProvider.getFlightById(bookingFlight.flight);
      final flight = FlightModel.fromJson(flightJson);
      final Map<String, dynamic> promoJson;
      PromoModel? promo;
      if (bookingFlight.promoCode != null) {
        promoJson =
            await promoDataProvider.getPromoById(bookingFlight.promoCode!);
        promo = PromoModel.fromJson(promoJson);
      }
      final bookingFlightDetail = BookingFlightDetailModel(
          id: bookingFlight.id,
          flight: flight,
          guest: bookingFlight.guest,
          seat: bookingFlight.seat,
          typePayment: bookingFlight.typePayment,
          promo: promo,
          card: bookingFlight.card,
          createdAt: bookingFlight.createdAt);
      bookingFlightDetails.add(bookingFlightDetail);
    }
    return bookingFlightDetails;
  }

  @override
  Future<BookingFlightDetailModel> getBookingFlightById(
      String bookingFlightId) async {
    final bookingFlightJson =
        await bookingFlightDataProvider.getBookingFlightById(bookingFlightId);
    final bookingFlight = BookingFlightModel.fromJson(bookingFlightJson);
    final flightJson =
        await flightDataProvider.getFlightById(bookingFlight.flight);
    final flight = FlightModel.fromJson(flightJson);
    final Map<String, dynamic> promoJson;
    PromoModel? promo;
    if (bookingFlight.promoCode != null) {
      promoJson =
          await promoDataProvider.getPromoById(bookingFlight.promoCode!);
      promo = PromoModel.fromJson(promoJson);
    }

    final bookingFlightDetail = BookingFlightDetailModel(
        id: bookingFlightId,
        flight: flight,
        guest: bookingFlight.guest,
        seat: bookingFlight.seat,
        typePayment: bookingFlight.typePayment,
        promo: promo,
        card: bookingFlight.card,
        createdAt: bookingFlight.createdAt);

    return bookingFlightDetail;
  }

  @override
  Future<String> createBookingFlight(BookingFlightModel bookingFlight) async {
    final bookingFlightId = await bookingFlightDataProvider
        .createBookingFlight(bookingFlight.toJson());
    return bookingFlightId;
  }
}
