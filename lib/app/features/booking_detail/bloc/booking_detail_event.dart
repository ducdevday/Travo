part of booking_detail;

abstract class BookingDetailEvent extends Equatable {
  const BookingDetailEvent();
}

class BookingDetailLoadById extends BookingDetailEvent {
  final String bookingId;

  const BookingDetailLoadById({
    required this.bookingId,
  });

  @override
  List<Object> get props => [bookingId];
}
