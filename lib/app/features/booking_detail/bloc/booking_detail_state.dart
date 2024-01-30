part of booking_detail;

abstract class BookingDetailState extends Equatable {
  const BookingDetailState();
}

class BookingDetailInitial extends BookingDetailState {
  @override
  List<Object> get props => [];
}

class BookingDetailLoadInProcess extends BookingDetailState {
  @override
  List<Object> get props => [];
}

class BookingDetailLoadSuccess extends BookingDetailState {
  final BookingDetailModel bookingDetail;

  const BookingDetailLoadSuccess({
    required this.bookingDetail,
  });

  @override
  List<Object> get props => [bookingDetail];
}

class BookingDetailLoadFailure extends BookingDetailState {
  @override
  List<Object> get props => [];
}
