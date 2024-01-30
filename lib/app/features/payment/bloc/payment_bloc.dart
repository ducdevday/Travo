part of payment;

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final BookingRepository bookingRepository;
  final BookingFlightRepository bookingFlightRepository;

  PaymentBloc({
    required this.bookingRepository,
    required this.bookingFlightRepository,
  }) : super(PaymentInitial()) {
    on<PaymentLoadBooking>(_onPaymentLoadBooking);
    on<PaymentChangeType>(_onPaymentChangeType);
  }

  FutureOr<void> _onPaymentLoadBooking(
      PaymentLoadBooking event, Emitter<PaymentState> emit) async {
    emit(PaymentLoadInProcess());
    try {
      List<dynamic> res = await Future.wait([
        bookingRepository.getAllBookings(event.email),
        bookingFlightRepository.getAllBookingFlights(event.email)
      ]);
      final bookings = res[0];
      final bookingFlights = res[1];

      emit(PaymentLoadSuccess(
          bookings: bookings,
          bookingFlights: bookingFlights));
    } catch (e) {
      print(e);
      emit(PaymentLoadFailure());
    }
  }

  FutureOr<void> _onPaymentChangeType(
      PaymentChangeType event, Emitter<PaymentState> emit) {
    if (state is PaymentLoadSuccess) {
      final currentState = state as PaymentLoadSuccess;
      emit(currentState.copyWith(checkoutType: event.type));
    }
  }
}
