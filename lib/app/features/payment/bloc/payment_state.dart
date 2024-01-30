part of payment;

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoadInProcess extends PaymentState {}

class PaymentLoadSuccess extends PaymentState {
  final List<BookingDetailModel> bookings;
  final List<BookingFlightDetailModel> bookingFlights;
  final CheckoutType checkoutType;

  const PaymentLoadSuccess({
    required this.bookings,
    required this.bookingFlights,
    this.checkoutType = CheckoutType.hotel
  });

  @override
  List<Object> get props => [bookings, bookingFlights, checkoutType];

  PaymentLoadSuccess copyWith({
    List<BookingDetailModel>? bookings,
    List<BookingFlightDetailModel>? bookingFlights,
    CheckoutType? checkoutType,
  }) {
    return PaymentLoadSuccess(
      bookings: bookings ?? this.bookings,
      bookingFlights: bookingFlights ?? this.bookingFlights,
      checkoutType: checkoutType ?? this.checkoutType,
    );
  }
}

class PaymentLoadFailure extends PaymentState {}
