part of hotels;

abstract class HotelsEvent extends Equatable {
  const HotelsEvent();

  @override
  List<Object> get props => [];
}

class HotelsLoadAll extends HotelsEvent {
  final int page;
  final int size;
  final num? budgetFrom;
  final num? budgetTo;
  final num? maxRating;
  final HotelSortType? sortType;
  final List<PropertyType> propertyTypes;
  const HotelsLoadAll({
    required this.page,
    required this.size,
    this.budgetFrom,
    this.budgetTo,
    this.maxRating,
    this.sortType,
    this.propertyTypes = const[]
  });

  @override
  List<Object> get props => [page, size];
}

class HotelsLoadMore extends HotelsEvent {
  final int page;
  final int size;

  const HotelsLoadMore({
    required this.page,
    required this.size,
  });

  @override
  List<Object> get props => [page, size];
}

class HotelsLikePressed extends HotelsEvent {
  final String hotelId;

  const HotelsLikePressed({
    required this.hotelId,
  });

  @override
  List<Object> get props => [hotelId];
}
