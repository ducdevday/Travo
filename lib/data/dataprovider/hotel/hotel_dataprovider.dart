import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_project/app/common/enums/hotel_sort_type.dart';
import 'package:my_project/data/dataprovider/hotel/hotel_dataprovider_base.dart';

class HotelDataProvider extends HotelDataProviderBase {
  static const String collectionName = "hotel";

  @override
  Future<(List<Map<String, dynamic>>, DocumentSnapshot?)> getAllHotels(
      int page,
      int size,
      DocumentSnapshot? oldLastDocument,
      HotelSortType? sortType) async {
    QuerySnapshot querySnapshot;
    String sortName = "";
    bool isDesc = false;
    if (sortType != null) {
      switch (sortType) {
        case HotelSortType.highestPrice:
          sortName = "price";
          isDesc = true;
          break;
        case HotelSortType.lowestPrice:
          sortName = "price";
        case HotelSortType.highestRating:
          sortName = "rating";
          isDesc = true;
          break;
      }
    }
    if (oldLastDocument == null) {
      if (sortType == null) {
        querySnapshot = await FirebaseFirestore.instance
            .collection(collectionName)
            .limit(size)
            .get();
      } else {
      querySnapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .orderBy(sortName, descending: isDesc)
          .limit(size)
          .get();
      }
    } else {
      if (sortType == null) {
        querySnapshot = await FirebaseFirestore.instance
            .collection(collectionName)
            .startAfterDocument(oldLastDocument)
            .limit(size)
            .get();
      } else {
        querySnapshot = await FirebaseFirestore.instance
            .collection(collectionName)
            .orderBy(sortName, descending: isDesc)
            .startAfterDocument(oldLastDocument)
            .limit(size)
            .get();
      }
    }
    DocumentSnapshot newLastDocument =
        querySnapshot.docs[querySnapshot.docs.length - 1];
    final result = querySnapshot.docs.map((doc) {
      var jsonData = doc.data() as Map<String, dynamic>;
      jsonData["id"] = doc.id;
      return jsonData;
    }).toList();
    return (result, newLastDocument);
  }

  @override
  Future<Map<String, dynamic>> getHotelById(String id) async {
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

  @override
  Future<List<Map<String, dynamic>>> searchHotel(String text) async {
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance
        .collection(collectionName)
        .where('name', isEqualTo: text);
    final result = query.get().then((value) => value.docs.map((value) {
          var jsonData = value.data() as Map<String, dynamic>;
          jsonData["id"] = value.id;
          return jsonData;
        }).toList());
    return result;
  }

  @override
  Future<List<Map<String, dynamic>>> filterHotel(
      num budgetFrom, num budgetTo, num maxRating) async {
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance
        .collection(collectionName)
        .where("price", isGreaterThanOrEqualTo: budgetFrom)
        .where("price", isLessThanOrEqualTo: budgetTo)
        .where("rating", isLessThanOrEqualTo: maxRating);
    final result = query
        .get()
        .then((value) => value.docs.map((doc) => doc.data()).toList());
    return result;
  }
}
