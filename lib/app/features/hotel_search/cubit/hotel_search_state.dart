part of hotel_search;

abstract class HotelSearchState extends Equatable {
  const HotelSearchState();

  @override
  List<Object> get props => [];
}

class HotelSearchInitial extends HotelSearchState {}

class HotelSearchInProcess extends HotelSearchState {}

class HotelSearchHaveResult extends HotelSearchState {
  final List<HotelModel> hotels;

  const HotelSearchHaveResult({
    required this.hotels,
  });

  @override
  List<Object> get props => [hotels];
}


class HotelSearchNoResult extends HotelSearchState {
}

class HotelSearchError extends HotelSearchState{
}