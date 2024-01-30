import 'package:my_project/data/dataprovider/room/room_dataprovider.dart';
import 'package:my_project/data/model/room_model.dart';
import 'package:my_project/data/repositories/room/room_repository_base.dart';

class RoomRepository extends RoomRepositoryBase {
  final RoomDataProvider roomDataProvider;

  RoomRepository({
    required this.roomDataProvider,
  });

  @override
  Future<List<RoomModel>> getRoomsByHotelId(String hotelId) async {
    final data = await roomDataProvider.getRoomsByHotelId(hotelId);
    var rooms = data.map((e) => RoomModel.fromJson(e)).toList();
    return rooms;
  }
}
