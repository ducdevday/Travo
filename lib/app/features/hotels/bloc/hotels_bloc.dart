part of hotels;

class HotelsBloc extends Bloc<HotelsEvent, HotelsState> {
  final HotelRepository hotelRepository;

  HotelsBloc({required this.hotelRepository}) : super(HotelsInitial()) {
    on<HotelsLoadAll>(_onHotelLoadAll);
    on<HotelsLoadMore>(_onHotelsLoadMore);
    on<HotelsLikePressed>(_onHotelsLikePressed);
  }

  FutureOr<void> _onHotelLoadAll(
      HotelsLoadAll event, Emitter<HotelsState> emit) async {
    emit(HotelsLoadInProcess());
    try {
      final (hotels, lastDocument) = await hotelRepository.getAllHotels(
          event.page, event.size, null, event.sortType);
      var updatedLikedHotels = getUpdatedLikedHotels(hotels: hotels);
      if (event.budgetFrom != null &&
          event.budgetTo != null &&
          event.maxRating != null) {
        updatedLikedHotels = getFilterHotels(
          hotels: updatedLikedHotels,
          budgetFrom: event.budgetFrom!,
          budgetTo: event.budgetTo!,
          maxRating: event.maxRating!,
          propertyTypes: event.propertyTypes,
        );
      }
      await Future.delayed(Duration(seconds: 1));
      emit(HotelsLoadSuccess(
          hotels: updatedLikedHotels,
          lastDocument: lastDocument,
          budgetFrom: event.budgetFrom,
          budgetTo: event.budgetTo,
          maxRating: event.maxRating,
          sortType: event.sortType,
          propertyTypes: event.propertyTypes));
    } catch (e) {
      print(e);
      emit(HotelsLoadFailure());
    }
  }

  FutureOr<void> _onHotelsLoadMore(
      HotelsLoadMore event, Emitter<HotelsState> emit) async {
    if (state is HotelsLoadSuccess) {
      final currentState = state as HotelsLoadSuccess;
      emit(currentState.copyWith(isLoadingMore: true));
      try {
        final (hotels, lastDocument) = await hotelRepository.getAllHotels(
            event.page,
            event.size,
            currentState.lastDocument,
            currentState.sortType);
        var updatedLikedHotels = getUpdatedLikedHotels(hotels: hotels);
        if (currentState.budgetFrom != null &&
            currentState.budgetTo != null &&
            currentState.maxRating != null) {
          updatedLikedHotels = getFilterHotels(
            hotels: updatedLikedHotels,
            budgetFrom: currentState.budgetFrom!,
            budgetTo: currentState.budgetTo!,
            maxRating: currentState.maxRating!,
            propertyTypes: currentState.propertyTypes,
          );
        }
        await Future.delayed(Duration(seconds: 1));
        emit(currentState.copyWith(
            hotels: List<HotelModel>.from(currentState.hotels)
              ..addAll(updatedLikedHotels),
            isLoadingMore: false,
            lastDocument: lastDocument));
        if (hotels.length < event.size) {
          emit(currentState.copyWith(cannotLoadMore: true));
        }
      } catch (e) {
        print(e);
        emit(HotelsLoadFailure());
      }
    }
  }

  FutureOr<void> _onHotelsLikePressed(
      HotelsLikePressed event, Emitter<HotelsState> emit) {
    if (state is HotelsLoadSuccess) {
      final currentState = state as HotelsLoadSuccess;
      final likedHotels = SharedService.getLikedHotels();
      if (likedHotels.contains(event.hotelId)) {
        likedHotels.remove(event.hotelId);
      } else {
        likedHotels.add(event.hotelId);
      }
      SharedService.setLikedHotels(likedHotels);
      final updatedLikedHotels =
          getUpdatedLikedHotels(hotels: currentState.hotels);

      emit(currentState.copyWith(hotels: updatedLikedHotels));
    }
  }

  List<HotelModel> getUpdatedLikedHotels({required List<HotelModel> hotels}) {
    final likedHotels = SharedService.getLikedHotels();

    return hotels.map((hotel) {
      return hotel.copyWith(isLiked: likedHotels.contains(hotel.id));
    }).toList();
  }

  List<HotelModel> getFilterHotels(
      {required List<HotelModel> hotels,
      required num budgetFrom,
      required num budgetTo,
      required num maxRating,
      required List<PropertyType> propertyTypes}) {
    return hotels
        .where((hotel) =>
            hotel.price! >= budgetFrom &&
            hotel.price! <= budgetTo &&
            hotel.rating! >= maxRating)
        .where((hotel) {
      bool isContain = false;
      for (var p in propertyTypes) {
        if(p == PropertyType.others){
          for (var o in PropertyOrderType.values){
            if (hotel.name!.contains(PropertyOrderType.getName(o))){
              isContain = true;
            }
          }
        }
        else if (hotel.name!.contains(PropertyType.getName(p))) {
          isContain = true;
        }
      }
      return isContain;
    }).toList();
  }
}
