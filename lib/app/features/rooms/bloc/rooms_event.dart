part of rooms;

abstract class RoomsEvent extends Equatable {
  const RoomsEvent();
}

class RoomsLoadAll extends RoomsEvent {
  final String hotelId;

  const RoomsLoadAll({
    required this.hotelId,
  });

  @override
  List<Object> get props => [hotelId];
}