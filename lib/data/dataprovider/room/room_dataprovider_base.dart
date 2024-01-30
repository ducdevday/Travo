abstract class RoomDataProviderBase{
  Future<List<Map<String, dynamic>>> getRoomsByHotelId(String hotelId);
  Future<Map<String, dynamic>> getRoomsById(String roomId);

}