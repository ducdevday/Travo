import 'package:cloud_firestore/cloud_firestore.dart';

import 'booking_flight_dataprovider_base.dart';

class BookingFlightDataProvider extends BookingFlightDataProviderBase {
  static const String collectionName = "booking_flight";

  @override
  Future<String> createBookingFlight(
      Map<String, dynamic> bookingFlightData) async {
    final booking = await FirebaseFirestore.instance
        .collection(collectionName)
        .add(bookingFlightData);
    return booking.id;
  }

  @override
  Future<List<Map<String, dynamic>>> getAllBookingFlights(String userEmail) {
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance
        .collection(collectionName)
        .where('email', isEqualTo: userEmail);
    final result = query.get().then((value) => value.docs.map((doc) {
          var jsonData = doc.data();
          jsonData["id"] = doc.id;
          return jsonData;
        }).toList());
    return result;
  }

  @override
  Future<Map<String, dynamic>> getBookingFlightById(
      String bookingFlightId) async {
    late Map<String, dynamic> result;
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(bookingFlightId)
        .get()
        .then((doc) {
      var jsonData = doc.data() as Map<String, dynamic>;
      jsonData["id"] = doc.id;
      result = jsonData;
    });
    return result;
  }
}
