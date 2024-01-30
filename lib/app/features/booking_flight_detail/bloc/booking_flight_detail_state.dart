part of 'booking_flight_detail_bloc.dart';

abstract class BookingFlightDetailState extends Equatable {
  const BookingFlightDetailState();
}

class BookingFlightDetailInitial extends BookingFlightDetailState {
  @override
  List<Object> get props => [];
}

class BookingFlightDetailLoadInProcess extends BookingFlightDetailState {
  @override
  List<Object> get props => [];
}

class BookingFlightDetailLoadSuccess extends BookingFlightDetailState {
  final BookingFlightDetailModel bookingFlightDetail;

  const BookingFlightDetailLoadSuccess({
    required this.bookingFlightDetail,
  });

  @override
  List<Object> get props => [bookingFlightDetail];
}

class BookingFlightDetailLoadFailure extends BookingFlightDetailState {
  @override
  List<Object> get props => [];
}
