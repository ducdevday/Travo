import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_project/app/common/enums/hotel_sort_type.dart';
import 'package:my_project/data/model/hotel_model.dart';

abstract class HotelRepositoryBase{
  Future<(List<HotelModel>, DocumentSnapshot?)> getAllHotels(int page, int size, DocumentSnapshot? oldLastDocument, HotelSortType sortType);
  Future<HotelModel> getHotelById(String id);
  Future<List<HotelModel>> searchHotel(String text);
  Future<List<HotelModel>> filterHotel(num budgetFrom, num budgetTo, num maxRating);

}