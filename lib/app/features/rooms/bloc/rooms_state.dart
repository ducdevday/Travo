part of rooms;

abstract class RoomsState extends Equatable {
  const RoomsState();

  @override
  List<Object> get props => [];
}

class RoomsInitial extends RoomsState {
}

class RoomsLoadInProcess extends RoomsState {
}

class RoomsLoadSuccess extends RoomsState {
  final List<RoomModel> rooms;

  const RoomsLoadSuccess({
    required this.rooms,
  });

  @override
  List<Object> get props => [rooms];
}

class RoomsLoadFailure extends RoomsState {
}