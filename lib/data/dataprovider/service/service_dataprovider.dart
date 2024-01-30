import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_project/data/dataprovider/service/service_dataprovider_base.dart';

class ServiceDataProvider extends ServiceDataProviderBase {
  static const String collectionName= "service";

  @override
  Future<List<Map<String, dynamic>>> getAllServices() async {
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
  Future<Map<String, dynamic>> getServiceById(String id) async {
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
