abstract class BookingFlightDataProviderBase {
  Future<String> createBookingFlight(Map<String, dynamic> bookingFlightData);

  Future<Map<String, dynamic>> getBookingFlightById(String bookingFlightId);

  Future<List<Map<String, dynamic>>> getAllBookingFlights(String userEmail);
}
