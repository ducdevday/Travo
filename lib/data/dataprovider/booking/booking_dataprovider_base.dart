import 'package:my_project/data/model/booking_model.dart';

abstract class BookingDataProviderBase {
  Future<String> createBooking(Map<String, dynamic> bookingData);

  Future<Map<String, dynamic>> getBookingById(String bookingId);

  Future<List<Map<String, dynamic>>> getAllBookings(String userEmail);
}
