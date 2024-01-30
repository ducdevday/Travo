part of home;

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeGetPlaces extends HomeEvent {}

class HomeSeeAllPressed extends HomeEvent {}

class HomeLikePlacePressed extends HomeEvent {
  final String placeId;

  const HomeLikePlacePressed({
    required this.placeId,
  });
}

class HomeSearchBarPressed extends HomeEvent {
}

class HomeSearchPlaceByName extends HomeEvent {
  final String name;

  const HomeSearchPlaceByName({
    required this.name,
  });

  @override
  List<Object> get props => [name];
}

class HomeSearchClear extends HomeEvent {
}

class HomeSearchLikePlacePressed extends HomeEvent {
  final String placeId;

  const HomeSearchLikePlacePressed({
    required this.placeId,
  });

  @override
  List<Object> get props => [placeId];
}