import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_project/app/common/enums/hotel_sort_type.dart';

abstract class HotelDataProviderBase{
  Future<(List<Map<String, dynamic>>,DocumentSnapshot?)> getAllHotels(int page, int size, DocumentSnapshot? oldLastDocument, HotelSortType? sortType);
  Future<Map<String, dynamic>> getHotelById(String id);
  Future<List<Map<String, dynamic>>> searchHotel(String text);
  Future<List<Map<String, dynamic>>> filterHotel(num budgetFrom, num budgetTo, num maxRating);
}