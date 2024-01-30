import 'package:my_project/data/model/place_model.dart';

abstract class PlaceRepositoryBase{
  Future<List<PlaceModel>> getAllPlaces();
  Future<List<PlaceModel>> getPopularPlaces();
  Future<List<PlaceModel>> searchPlaces(String text);

}