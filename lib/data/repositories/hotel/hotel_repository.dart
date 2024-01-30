import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_project/app/common/enums/hotel_sort_type.dart';
import 'package:my_project/data/dataprovider/hotel/hotel_dataprovider.dart';
import 'package:my_project/data/model/hotel_model.dart';
import 'package:my_project/data/repositories/hotel/hotel_repository_base.dart';

class HotelRepository extends HotelRepositoryBase {
  final HotelDataProvider hotelDataProvider;

  HotelRepository({required this.hotelDataProvider});

  @override
  Future<(List<HotelModel>, DocumentSnapshot?)> getAllHotels(int page, int size, DocumentSnapshot? oldLastDocument, HotelSortType? sortType) async {
    final (data, lastdocument) = await hotelDataProvider.getAllHotels(page, size, oldLastDocument, sortType);
    var hotels = data.map((e) => HotelModel.fromJson(e)).toList();
    return (hotels,lastdocument);
  }

  @override
  Future<HotelModel> getHotelById(String id) async {
    final data = await hotelDataProvider.getHotelById(id);
    final hotel = HotelModel.fromJson(data);
    return hotel;
  }

  @override
  Future<List<HotelModel>> searchHotel(String text) async {
    final data = await hotelDataProvider.searchHotel(text);
    final List<HotelModel> hotels =
        data.map((e) => HotelModel.fromJson(e)).toList();
    return hotels;
  }

  @override
  Future<List<HotelModel>> filterHotel(
      num budgetFrom, num budgetTo, num maxRating) async {
    final data =
        await hotelDataProvider.filterHotel(budgetFrom, budgetTo, maxRating);
    final List<HotelModel> hotels =
        data.map((e) => HotelModel.fromJson(e)).toList();
    return hotels;
  }
}
