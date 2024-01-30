import 'package:my_project/data/dataprovider/place/place_dataprovider.dart';
import 'package:my_project/data/model/place_model.dart';
import 'package:my_project/data/repositories/place/place_repository_base.dart';

class PlaceRepository extends PlaceRepositoryBase{
  final PlaceDataProvider placeDataProvider;

  PlaceRepository({required this.placeDataProvider});
  @override
  Future<List<PlaceModel>> getAllPlaces() async{
    final data = await placeDataProvider.getAllPlaces();
    var places = data.map((e) => PlaceModel.fromJson(e)).toList();
    places.sort((a, b) => b.rating.compareTo(a.rating));
    return places;
  }

  @override
  Future<List<PlaceModel>> getPopularPlaces() async{
    final data = await placeDataProvider.getAllPlaces();
    var places = data.map((e) => PlaceModel.fromJson(e)).toList();
    places.sort((a, b) => b.rating.compareTo(a.rating));
    places = places.sublist(0, places.length > 10 ? 10 : places.length);
    return places;
  }

  @override
  Future<List<PlaceModel>> searchPlaces(String text) async{
    final data = await placeDataProvider.searchPlaces(text);
    final List<PlaceModel> places =
    data.map((e) => PlaceModel.fromJson(e)).toList();
    return places;
  }
}