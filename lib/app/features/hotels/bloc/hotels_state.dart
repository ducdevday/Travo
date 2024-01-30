part of hotels;

abstract class HotelsState extends Equatable {
  const HotelsState();

  @override
  List<Object> get props => [];
}

class HotelsInitial extends HotelsState {}

class HotelsLoadInProcess extends HotelsState {}

class HotelsLoadSuccess extends HotelsState {
  final List<HotelModel> hotels;
  final num? budgetFrom;
  final num? budgetTo;
  final num? maxRating;
  final bool isLoadingMore;
  final bool cannotLoadMore;
  final DocumentSnapshot? lastDocument;
  final HotelSortType? sortType;
  final List<PropertyType> propertyTypes;

  const HotelsLoadSuccess(
      {required this.hotels,
      this.budgetFrom,
      this.budgetTo,
      this.maxRating,
      this.isLoadingMore = false,
      this.cannotLoadMore = false,
      this.lastDocument,
      this.sortType,
      this.propertyTypes = const []});

  @override
  List<Object> get props => [
        hotels,
        isLoadingMore,
        cannotLoadMore,
      ];

  HotelsLoadSuccess copyWith({
    List<HotelModel>? hotels,
    num? budgetFrom,
    num? budgetTo,
    num? maxRating,
    bool? isLoadingMore,
    bool? cannotLoadMore,
    DocumentSnapshot? lastDocument,
    HotelSortType? sortType,
    List<PropertyType>? propertyTypes
  }) {
    return HotelsLoadSuccess(
        hotels: hotels ?? this.hotels,
        budgetFrom: budgetFrom ?? this.budgetFrom,
        budgetTo: budgetTo ?? this.budgetTo,
        maxRating: maxRating ?? this.maxRating,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        cannotLoadMore: cannotLoadMore ?? this.cannotLoadMore,
        lastDocument: lastDocument ?? this.lastDocument,
        sortType: sortType ?? this.sortType,
        propertyTypes: propertyTypes ?? this.propertyTypes
    );
  }
}

class HotelsLoadFailure extends HotelsState {}
