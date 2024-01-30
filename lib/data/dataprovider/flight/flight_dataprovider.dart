import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_project/data/dataprovider/flight/flight_dataprovider_base.dart';

class FlightDataProvider extends FlightDataProviderBase {
  static const String collectionName = "flight";

  @override
  Future<List<Map<String, dynamic>>> getAllFlights(
      String fromPlace, String toPlace, DateTime departureDate) {
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance
        .collection(collectionName)
        .where('from_place', isEqualTo: fromPlace)
        .where('to_place', isEqualTo: toPlace)
        .where('departure_time',
            isGreaterThanOrEqualTo: Timestamp.fromDate(departureDate));
    final result = query.get().then((value) => value.docs.map((value) {
          var jsonData = value.data() as Map<String, dynamic>;
          jsonData["id"] = value.id;
          // print(jsonData);
          return jsonData;
        }).toList());
    return result;
  }

  @override
  Future<Map<String, dynamic>> getFlightById(String id) async {
    Map<String, dynamic> result = await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(id)
        .get()
        .then((value) {
      var jsonData = value.data() as Map<String, dynamic>;
      jsonData["id"] = value.id;
      return jsonData;
    });
    return result;
  }
}
