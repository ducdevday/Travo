part of hotel_detail;

abstract class HotelDetailEvent extends Equatable {
  const HotelDetailEvent();
}

class HotelDetailLoad extends HotelDetailEvent {
  final HotelModel hotel;

  const HotelDetailLoad({
    required this.hotel,
  });

  @override
  List<Object> get props => [hotel];
}

class HotelDetailLikePressed extends HotelDetailEvent {
  final String hotelId;

  const HotelDetailLikePressed({
    required this.hotelId,
  });

  @override
  List<Object> get props => [hotelId];
}

class HotelDetailMoreServicePressed extends HotelDetailEvent {
  final String hotelId;

  const HotelDetailMoreServicePressed({
    required this.hotelId,
  });

  @override
  List<Object> get props => [hotelId];
}