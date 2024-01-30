import 'package:my_project/data/model/booking_flight_detail_model.dart';
import 'package:my_project/data/model/booking_flight_model.dart';

abstract class BookingFlightRepositoryBase {
  Future<String> createBookingFlight(BookingFlightModel bookingFlight);

  Future<BookingFlightDetailModel> getBookingFlightById(String bookingFlightId);

  Future<List<BookingFlightDetailModel>> getAllBookingFlights(String userEmail);
}