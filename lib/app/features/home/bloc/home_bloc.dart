part of home;

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PlaceRepository placeRepository;

  HomeBloc({required this.placeRepository}) : super(HomeInitial()) {
    on<HomeGetPlaces>(_onHomeGetPlaces);
    on<HomeSeeAllPressed>(_onHomeSeeAllPressed);
    on<HomeLikePlacePressed>(_onHomeLikePlacePressed);
    on<HomeSearchBarPressed>(_onHomeSearchBarPressed);
    on<HomeSearchPlaceByName>(_onHomeSearchPlaceByName);
    on<HomeSearchClear>(_onHomeSearchClear);
    on<HomeSearchLikePlacePressed>(_onHomeSearchLikePlacePressed);
  }

  FutureOr<void> _onHomeGetPlaces(
      HomeGetPlaces event, Emitter<HomeState> emit) async {
    emit(HomeLoadInProcess());
    try {
      final places = await placeRepository.getPopularPlaces();
      final updatedLikedPlaces = getUpdatedLikedPlace(places: places);
      await Future.delayed(Duration(seconds: 1));
      emit(HomeLoadSuccess(places: updatedLikedPlaces));
    } catch (e) {
      print(e);
      emit(HomeLoadFailure());
    }
  }

  FutureOr<void> _onHomeSeeAllPressed(
      HomeSeeAllPressed event, Emitter<HomeState> emit) async {
    try {
      final places = await placeRepository.getAllPlaces();
      final updatedLikedPlaces = getUpdatedLikedPlace(places: places);
      emit(HomeLoadSuccess(places: updatedLikedPlaces));
    } catch (e) {
      emit(HomeLoadFailure());
    }
  }

  FutureOr<void> _onHomeLikePlacePressed(
      HomeLikePlacePressed event, Emitter<HomeState> emit) {
    if (state is HomeLoadSuccess) {
      final currentState = state as HomeLoadSuccess;
      final likedPlaces = SharedService.getLikedPlaces();
      if (likedPlaces.contains(event.placeId)) {
        likedPlaces.remove(event.placeId);
      } else {
        likedPlaces.add(event.placeId);
      }
      SharedService.setLikedPlaces(likedPlaces);
      final updatedLikedPlaces =
          getUpdatedLikedPlace(places: currentState.places);
      emit(HomeLoadSuccess(places: List.from(updatedLikedPlaces)));
    }
  }

  List<PlaceModel> getUpdatedLikedPlace({required List<PlaceModel> places}) {
    final likedPlaces = SharedService.getLikedPlaces();

    return places.map((place) {
      return place.copyWith(isLiked: likedPlaces.contains(place.id));
    }).toList();
  }

  FutureOr<void> _onHomeSearchBarPressed(
      HomeSearchBarPressed event, Emitter<HomeState> emit) {
    emit(HomeSearchInitial());
  }

  FutureOr<void> _onHomeSearchPlaceByName(
      HomeSearchPlaceByName event, Emitter<HomeState> emit) async {
    if (event.name.isEmpty) {
      emit(HomeSearchInitial());
    } else {
      emit(HomeSearchInProcess());
      try {
        final places = await placeRepository.searchPlaces(event.name);
        final updatedLikedPlaces = getUpdatedLikedPlace(places: places);
        await Future.delayed(Duration(seconds: 1));
        emit(HomeSearchSuccess(places: updatedLikedPlaces));
      } catch (e) {
        print(e);
        emit(HomeSearchFailure());
      }
    }
  }

  FutureOr<void> _onHomeSearchClear(
      HomeSearchClear event, Emitter<HomeState> emit) {
    emit(HomeSearchSuccess(places: null));
  }

  FutureOr<void> _onHomeSearchLikePlacePressed(
      HomeSearchLikePlacePressed event, Emitter<HomeState> emit) {
    if (state is HomeSearchSuccess) {
      final currentState = state as HomeSearchSuccess;
      final likedPlaces = SharedService.getLikedPlaces();
      if (likedPlaces.contains(event.placeId)) {
        likedPlaces.remove(event.placeId);
      } else {
        likedPlaces.add(event.placeId);
      }
      SharedService.setLikedPlaces(likedPlaces);
      final updatedLikedPlaces =
          getUpdatedLikedPlace(places: currentState.places!);
      emit(HomeSearchSuccess(places: List.from(updatedLikedPlaces)));
    }
  }
}
