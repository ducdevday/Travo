part of hotel_detail;

class HotelDetailBloc extends Bloc<HotelDetailEvent, HotelDetailState> {
  final RoomRepository roomRepository;

  HotelDetailBloc({required this.roomRepository})
      : super(HotelDetailInitial()) {
    on<HotelDetailLoad>(_onHotelDetailLoad);
    on<HotelDetailLikePressed>(_onHotelDetailLikePress);
    on<HotelDetailMoreServicePressed>(_onHotelDetailMoreServicePressed);
  }

  FutureOr<void> _onHotelDetailLoad(
      HotelDetailLoad event, Emitter<HotelDetailState> emit) async {
    emit(HotelDetailLoadInProcess());
    try {
      final rooms = await roomRepository.getRoomsByHotelId(event.hotel.id!);
      emit(HotelDetailLoadSuccess(
          hotel: event.hotel, services: rooms[0].services));
    } catch (e) {
      print(e);
      emit(HotelDetailLoadFailure());
    }
  }

  FutureOr<void> _onHotelDetailLikePress(
      HotelDetailLikePressed event, Emitter<HotelDetailState> emit) {
    if (state is HotelDetailLoadSuccess) {
      final currentState = state as HotelDetailLoadSuccess;
      final likedHotels = SharedService.getLikedHotels();
      if (likedHotels.contains(event.hotelId)) {
        likedHotels.remove(event.hotelId);
        emit(currentState.copyWith(
            hotel: currentState.hotel.copyWith(isLiked: false),
            isChangeLiked: true));
      } else {
        likedHotels.add(event.hotelId);
        emit(currentState.copyWith(
            hotel: currentState.hotel.copyWith(isLiked: true),
            isChangeLiked: true));
      }
      SharedService.setLikedHotels(likedHotels);
    }
  }

  FutureOr<void> _onHotelDetailMoreServicePressed(
      HotelDetailMoreServicePressed event,
      Emitter<HotelDetailState> emit) async {
    if (state is HotelDetailLoadSuccess) {
      final currentState = state as HotelDetailLoadSuccess;
      final rooms = await roomRepository.getRoomsByHotelId(event.hotelId);
      final Set<String> services = Set<String>();
      for (var room in rooms) {
        services.addAll(room.services);
      }
      emit(currentState.copyWith(services: services.toList()));
    }
  }
}
