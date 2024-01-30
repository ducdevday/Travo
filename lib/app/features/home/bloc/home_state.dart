part of home;

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadInProcess extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadSuccess extends HomeState {
  final List<PlaceModel> places;

  const HomeLoadSuccess({
    required this.places,
  });

  @override
  List<Object> get props => [places];
}

class HomeSearchInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeSearchInProcess extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeSearchSuccess extends HomeState {
  final List<PlaceModel>? places;

  const HomeSearchSuccess({
    required this.places,
  });

  @override
  List<Object?> get props => [places];
}

class HomeSearchFailure extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadFailure extends HomeState {
  @override
  List<Object> get props => [];
}
