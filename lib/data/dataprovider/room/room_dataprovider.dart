import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_project/data/dataprovider/room/room_dataprovider_base.dart';

class RoomDataProvider extends RoomDataProviderBase {
  static const String collectionName = "room";

  @override
  Future<List<Map<String, dynamic>>> getRoomsByHotelId(String hotelId) async {
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance
        .collection(collectionName)
        .where('hotel', isEqualTo: hotelId);
    final result = query.get().then((value) => value.docs.map((doc) {
          var jsonData = doc.data() as Map<String, dynamic>;
          jsonData["id"] = doc.id;
          return jsonData;
        }).toList());
    return result;
  }

  @override
  Future<Map<String, dynamic>> getRoomsById(String roomId) async {
    Map<String, dynamic> result = await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(roomId)
        .get()
        .then((value) {
      var jsonData = value.data() as Map<String, dynamic>;
      jsonData["id"] = value.id;
      return jsonData;
    });
    return result;
  }
}
