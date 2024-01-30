part of favourite;

enum FavouriteType {
  Place,
  Hotel;

  String toJson() => name;

  static FavouriteType fromJson(String json) => values.byName(json);
}

abstract class FavouriteState extends Equatable {
  const FavouriteState();
}

class FavouriteInitial extends FavouriteState {
  @override
  List<Object> get props => [];
}

class FavouriteLoadInProcess extends FavouriteState {
  @override
  List<Object> get props => [];
}

class FavouriteLoadSuccess extends FavouriteState {
  final List<PlaceModel> places;
  final List<HotelModel> hotels;
  final FavouriteType type;
  final bool isLoadingHotelMore;
  final bool cannotLoadHotelMore;
  final DocumentSnapshot? lastHotelDocument;


  const FavouriteLoadSuccess({
    this.places = const [],
    this.hotels = const [],
    this.type = FavouriteType.Place,
    this.isLoadingHotelMore = false,
    this.cannotLoadHotelMore = false,
    this.lastHotelDocument
  });

  @override
  List<Object?> get props =>
      [
        places,
        hotels,
        type,
        isLoadingHotelMore,
        cannotLoadHotelMore,
        lastHotelDocument,
      ];

  FavouriteLoadSuccess copyWith({
    List<PlaceModel>? places,
    List<HotelModel>? hotels,
    FavouriteType? type,
    bool? isLoadingHotelMore,
    bool? cannotLoadHotelMore,
    DocumentSnapshot? lastHotelDocument,
  }) {
    return FavouriteLoadSuccess(
      places: places ?? this.places,
      hotels: hotels ?? this.hotels,
      type: type ?? this.type,
      isLoadingHotelMore: isLoadingHotelMore ?? this.isLoadingHotelMore,
      cannotLoadHotelMore: cannotLoadHotelMore ?? this.cannotLoadHotelMore,
      lastHotelDocument: lastHotelDocument ?? this.lastHotelDocument,
    );
  }
}

class FavouriteLoadFailure extends FavouriteState {
  @override
  List<Object> get props => [];
}
