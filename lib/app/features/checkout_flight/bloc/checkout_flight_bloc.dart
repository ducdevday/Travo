part of checkout_flight;

class CheckoutFlightBloc
    extends Bloc<CheckoutFlightEvent, CheckoutFlightState> {
  final BookingFlightRepository bookingFlightRepository;

  CheckoutFlightBloc({required this.bookingFlightRepository})
      : super(CheckoutFlightInitial()) {
    on<CheckoutFlightGoToBookingAndReviewStep>(
        _onCheckoutFlightAndGoToBookingAndReviewStep);
    on<CheckoutFlightAddGuest>(_onCheckoutFlightAddGuest);
    on<CheckoutFlightAddPromo>(_onCheckoutFlightAddPromo);
    on<CheckoutFlightRemovePromo>(_onCheckoutFlightRemovePromo);
    on<CheckoutFlightAddSeat>(_onCheckoutFlightAddSeat);
    on<CheckoutFlightGoToPaymentStep>(_onCheckoutFlightGoToPaymentStep);
    on<CheckoutFlightChooseTypePayment>(_onCheckoutFlightChooseTypePayment);
    on<CheckoutFlightAddCard>(_onCheckoutFlightAddCard);
    on<CheckoutFlightGoToConfirmStep>(_onCheckoutFlightGoToConfirmStep);
    on<CheckoutFlightPayNow>(_onCheckoutFlightPayNow);
  }

  FutureOr<void> _onCheckoutFlightAndGoToBookingAndReviewStep(
      CheckoutFlightGoToBookingAndReviewStep event,
      Emitter<CheckoutFlightState> emit) {
    emit(CheckoutFlightBookingAndReviewStep(
        guest: event.guest, promo: event.promo, seat: event.seat));
  }

  FutureOr<void> _onCheckoutFlightAddGuest(
      CheckoutFlightAddGuest event, Emitter<CheckoutFlightState> emit) {
    if (state is CheckoutFlightBookingAndReviewStep) {
      final currentState = state as CheckoutFlightBookingAndReviewStep;
      emit(currentState.copyWith(guest: event.guest));
    }
  }

  FutureOr<void> _onCheckoutFlightAddPromo(
      CheckoutFlightAddPromo event, Emitter<CheckoutFlightState> emit) {
    if (state is CheckoutFlightBookingAndReviewStep) {
      final currentState = state as CheckoutFlightBookingAndReviewStep;
      emit(currentState.copyWith(promo: () => event.promo));
    }
  }

  FutureOr<void> _onCheckoutFlightRemovePromo(
      CheckoutFlightRemovePromo event, Emitter<CheckoutFlightState> emit) {
    if (state is CheckoutFlightBookingAndReviewStep) {
      final currentState = state as CheckoutFlightBookingAndReviewStep;
      emit(currentState.copyWith(promo: () => null));
    }
  }

  FutureOr<void> _onCheckoutFlightAddSeat(
      CheckoutFlightAddSeat event, Emitter<CheckoutFlightState> emit) {
    if (state is CheckoutFlightBookingAndReviewStep) {
      final currentState = state as CheckoutFlightBookingAndReviewStep;
      emit(currentState.copyWith(seat: event.seat));
    }
  }

  FutureOr<void> _onCheckoutFlightGoToPaymentStep(
      CheckoutFlightGoToPaymentStep event, Emitter<CheckoutFlightState> emit) {
    emit(CheckoutFlightPaymentStep(
        typePayment: event.typePayment, card: event.card));
  }

  FutureOr<void> _onCheckoutFlightChooseTypePayment(
      CheckoutFlightChooseTypePayment event,
      Emitter<CheckoutFlightState> emit) {
    if (state is CheckoutFlightPaymentStep) {
      final currentState = state as CheckoutFlightPaymentStep;
      emit(currentState.copyWith(typePayment: event.type));
    }
  }

  FutureOr<void> _onCheckoutFlightAddCard(
      CheckoutFlightAddCard event, Emitter<CheckoutFlightState> emit) {
    if (state is CheckoutFlightPaymentStep) {
      final currentState = state as CheckoutFlightPaymentStep;
      emit(currentState.copyWith(card: event.card));
    }
  }

  FutureOr<void> _onCheckoutFlightGoToConfirmStep(
      CheckoutFlightGoToConfirmStep event, Emitter<CheckoutFlightState> emit) {
    emit(CheckoutFlightConfirmStep());
  }

  FutureOr<void> _onCheckoutFlightPayNow(
      CheckoutFlightPayNow event, Emitter<CheckoutFlightState> emit) async {
    emit(CheckoutFlightPaymentInProcess());
    try {
      final bookingFlight = BookingFlightModel(
          email: event.email,
          flight: event.flight,
          guest: event.guest,
          seat: event.seat,
          typePayment: event.typePayment,
          promoCode: event.promoCode,
          card: event.card,
          createdAt: DateTime.now());

      final bookingFlightId =
          await bookingFlightRepository.createBookingFlight(bookingFlight);
      await Future.delayed(Duration(seconds: 1));
      emit(CheckoutFlightPaymentSuccess(bookingFlightId: bookingFlightId));
    } catch (e) {
      print(e);
      emit(CheckoutFlightPaymentFailure());
    }
  }
}
