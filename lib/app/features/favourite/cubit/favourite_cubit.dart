part of favourite;

class FavouriteCubit extends Cubit<FavouriteState> {
  final PlaceRepository placeRepository;
  final HotelRepository hotelRepository;

  FavouriteCubit({required this.placeRepository, required this.hotelRepository})
      : super(FavouriteInitial());

  void loadFavourites({int page = 0, int size = 5}) async {
    emit(FavouriteLoadInProcess());
    try {
      final places = await placeRepository.getAllPlaces();
      final (hotels, lastHotelDocument) =
          await hotelRepository.getAllHotels(page, size, null, null);
      final updatedLikedPlaces = getUpdatedLikedPlace(places: places);
      final updatedLikedHotels = getUpdatedLikedHotels(hotels: hotels);
      emit(FavouriteLoadSuccess(
        places: updatedLikedPlaces,
        hotels: updatedLikedHotels,
        lastHotelDocument: lastHotelDocument,
      ));
    } catch (e) {
      print(e);
      emit(FavouriteLoadFailure());
    }
  }

  void loadMoreHotelFavourites({required int page,required int size}) async {
    if (state is FavouriteLoadSuccess) {
      final currentState = state as FavouriteLoadSuccess;
      try {
        final (hotels, lastHotelDocument) = await hotelRepository.getAllHotels(
            page, size, currentState.lastHotelDocument, null);
        final updatedLikedHotels = getUpdatedLikedHotels(hotels: hotels);
        emit(currentState.copyWith(
            hotels: List<HotelModel>.from(currentState.hotels)
              ..addAll(updatedLikedHotels),
            isLoadingHotelMore: false,
            lastHotelDocument: lastHotelDocument));
        if (hotels.length < size) {
          emit(currentState.copyWith(cannotLoadHotelMore: true));
        }
      } catch (e) {
        print(e);
        emit(FavouriteLoadFailure());
      }
    }
  }

  void chooseFavouriteType(FavouriteType type) {
    if (state is FavouriteLoadSuccess) {
      final currentState = state as FavouriteLoadSuccess;
      emit(currentState.copyWith(type: type));
    }
  }

  void likePlacePressed(String placeId) {
    print("likePlacePressed");
    if (state is FavouriteLoadSuccess) {
      final currentState = state as FavouriteLoadSuccess;
      final likedPlaces = SharedService.getLikedPlaces();
      if (likedPlaces.contains(placeId)) {
        likedPlaces.remove(placeId);
      } else {
        likedPlaces.add(placeId);
      }
      SharedService.setLikedPlaces(likedPlaces);
      final updatedLikedPlaces =
          getUpdatedLikedPlace(places: currentState.places);
      emit(currentState.copyWith(places: updatedLikedPlaces));
    }
  }

  void likeHotelPressed(String hotelId) {
    print("likeHotelPressed");
    if (state is FavouriteLoadSuccess) {
      final currentState = state as FavouriteLoadSuccess;
      final likedHotels = SharedService.getLikedHotels();
      if (likedHotels.contains(hotelId)) {
        likedHotels.remove(hotelId);
      } else {
        likedHotels.add(hotelId);
      }
      SharedService.setLikedHotels(likedHotels);
      final updatedLikedHotels =
          getUpdatedLikedHotels(hotels: currentState.hotels);
      emit(currentState.copyWith(hotels: updatedLikedHotels));
    }
  }

  List<PlaceModel> getUpdatedLikedPlace({required List<PlaceModel> places}) {
    final likedPlaces = SharedService.getLikedPlaces();

    return places
        .map((place) {
          return place.copyWith(isLiked: likedPlaces.contains(place.id));
        })
        .where((place) => place.isLiked)
        .toList();
  }

  List<HotelModel> getUpdatedLikedHotels({required List<HotelModel> hotels}) {
    final likedHotels = SharedService.getLikedHotels();

    return hotels
        .map((hotel) {
          return hotel.copyWith(isLiked: likedHotels.contains(hotel.id));
        })
        .where((hotel) => hotel.isLiked!)
        .toList();
  }
}
