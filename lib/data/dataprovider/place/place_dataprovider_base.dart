abstract class PlaceDataProviderBase{
  Future<List<Map<String, dynamic>>> getAllPlaces();
  Future<List<Map<String, dynamic>>> searchPlaces(String text);
}