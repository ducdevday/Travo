import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_project/data/dataprovider/promo/promo_dataprovider_base.dart';

class PromoDataProvider extends PromoDataProviderBase{
  static const String collectionName= "promo";

  @override
  Future<Map<String, dynamic>> getPromoById(String id) async{
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