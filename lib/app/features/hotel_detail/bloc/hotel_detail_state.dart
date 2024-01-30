part of hotel_detail;

abstract class HotelDetailState extends Equatable {
  const HotelDetailState();

  @override
  List<Object> get props => [];
}

class HotelDetailInitial extends HotelDetailState {}

class HotelDetailLoadInProcess extends HotelDetailState {}

class HotelDetailLoadSuccess extends HotelDetailState {
  final HotelModel hotel;
  final List<String> services;
  final bool isChangeLiked;
  const HotelDetailLoadSuccess({
    required this.hotel,
    required this.services,
    this.isChangeLiked = false
  });

  @override
  List<Object> get props => [hotel, services, isChangeLiked];

  HotelDetailLoadSuccess copyWith({
    HotelModel? hotel,
    List<String>? services,
    bool? isChangeLiked,
  }) {
    return HotelDetailLoadSuccess(
      hotel: hotel ?? this.hotel,
      services: services ?? this.services,
      isChangeLiked: isChangeLiked ?? this.isChangeLiked,
    );
  }
}

class HotelDetailLoadFailure extends HotelDetailState {

}
