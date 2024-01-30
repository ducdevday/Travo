import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_project/data/dataprovider/place/place_dataprovider_base.dart';

class PlaceDataProvider extends PlaceDataProviderBase {
  static const String collectionName= "place";

  @override
  Future<List<Map<String, dynamic>>> getAllPlaces() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(collectionName).get();
    final result = querySnapshot.docs.map((doc) {
      var jsonData = doc.data() as Map<String, dynamic>;
      jsonData["id"] = doc.id;
      return jsonData;
    }).toList();

    return result;
  }

  @override
  Future<List<Map<String, dynamic>>> searchPlaces(String text) {
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance
        .collection(collectionName)
        .where('name', isEqualTo: text);
    final result = query
        .get()
        .then((value) => value.docs.map((value) {
      var jsonData = value.data() as Map<String, dynamic>;
      jsonData["id"] = value.id;
      return jsonData;
    }).toList());
    return result;
  }
}
