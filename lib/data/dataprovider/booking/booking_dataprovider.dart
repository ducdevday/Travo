import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_project/data/dataprovider/booking/booking_dataprovider_base.dart';

class BookingDataProvider extends BookingDataProviderBase {
  static const String collectionName = "booking";

  @override
  Future<String> createBooking(Map<String, dynamic> bookingData) async {
    final booking = await FirebaseFirestore.instance
        .collection(collectionName)
        .add(bookingData);
    return booking.id;
  }

  @override
  Future<Map<String, dynamic>> getBookingById(String bookingId) async {
    late Map<String, dynamic> result;
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(bookingId)
        .get()
        .then((doc) {
      var jsonData = doc.data() as Map<String, dynamic>;
      jsonData["id"] = doc.id;
      result = jsonData;
    });
    return result;
  }

  @override
  Future<List<Map<String, dynamic>>> getAllBookings(String userEmail) {
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


}
