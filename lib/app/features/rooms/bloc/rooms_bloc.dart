part of rooms;

class RoomsBloc extends Bloc<RoomsEvent, RoomsState> {
  final RoomRepository roomRepository;

  RoomsBloc({required this.roomRepository})
      : super(RoomsInitial()) {
    on<RoomsLoadAll>(_onRoomsLoadAll);
  }

  FutureOr<void> _onRoomsLoadAll(
      RoomsLoadAll event, Emitter<RoomsState> emit) async {
    emit(RoomsLoadInProcess());
    try {
      final rooms = await roomRepository.getRoomsByHotelId(event.hotelId);
      emit(RoomsLoadSuccess(rooms: rooms));
    } catch (e) {
      print(e);
      emit(RoomsLoadFailure());
    }
  }
}
