part of booking_date;

enum BookingDateStatus {
  initial,
  ready,
  success
}

class BookingDateState extends Equatable {
  final BookingDateStatus status;
  final List<DateTime?> bookingTimes;

  const BookingDateState({
    this.status = BookingDateStatus.initial,
    this.bookingTimes = const[],
  });

  @override
  List<Object> get props => [status, bookingTimes];

  BookingDateState copyWith({
    BookingDateStatus? status,
    List<DateTime?>? bookingTimes,
  }) {
    return BookingDateState(
      status: status ?? this.status,
      bookingTimes: bookingTimes ?? this.bookingTimes,
    );
  }
}