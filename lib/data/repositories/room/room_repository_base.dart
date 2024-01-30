import 'package:my_project/data/model/room_model.dart';

abstract class RoomRepositoryBase {
  Future<List<RoomModel>> getRoomsByHotelId(String hotelId);
}