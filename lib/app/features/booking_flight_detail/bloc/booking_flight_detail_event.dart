part of 'booking_flight_detail_bloc.dart';

abstract class BookingFlightDetailEvent extends Equatable {
  const BookingFlightDetailEvent();
}

class BookingFlightDetailLoadById extends BookingFlightDetailEvent {
  final String id;

  const BookingFlightDetailLoadById({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
