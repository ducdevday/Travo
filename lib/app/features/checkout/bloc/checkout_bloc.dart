part of checkout;

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final BookingRepository bookingRepository;

  CheckoutBloc({required this.bookingRepository})
      : super(const CheckoutState()) {
    on<CheckoutGoToBookingAndReviewStep>(_onCheckoutGoToBookingAndReviewStep);
    on<CheckoutSetHotelAndRoom>(_onCheckoutSetHotelAndRoom);
    on<CheckoutAddGuest>(_onCheckoutAddGuest);
    on<CheckoutUpdateGuest>(_onCheckoutUpdateGuest);
    on<CheckoutDeleteGuest>(_onCheckoutDeleteGuest);
    on<CheckoutAddPromo>(_onCheckoutAddPromo);
    on<CheckoutRemovePromo>(_onCheckoutRemovePromo);
    on<CheckoutAddBookingTimes>(_onCheckoutAddBookingTimes);
    on<CheckoutGoToPaymentStep>(_onCheckoutGoToPaymentStep);
    on<CheckoutChooseTypePayment>(_onCheckoutChooseTypePayment);
    on<CheckoutAddCard>(_onCheckoutAddCard);
    on<CheckoutGoToConfirmStep>(_onCheckoutGoToConfirmStep);
    on<CheckoutPayNow>(_onCheckoutPayNow);
    on<CheckoutChangeStep>(_onCheckoutChangeStep);
  }

  FutureOr<void> _onCheckoutSetHotelAndRoom(
      CheckoutSetHotelAndRoom event, Emitter<CheckoutState> emit) {
    emit(CheckoutState(hotel: event.hotel, room: event.room));
  }

  FutureOr<void> _onCheckoutAddGuest(
      CheckoutAddGuest event, Emitter<CheckoutState> emit) {
    final guests = List<GuestModel>.from(state.guest)..add(event.guest);
    emit(state.copyWith(guest: guests));
  }

  FutureOr<void> _onCheckoutUpdateGuest(
      CheckoutUpdateGuest event, Emitter<CheckoutState> emit) {
    final guests = List<GuestModel>.from(state.guest);
    final index = guests.indexOf(event.oldGuest);
    guests.removeAt(index);
    guests.insert(index, event.newGuest);
    emit(state.copyWith(guest: guests));
  }

  FutureOr<void> _onCheckoutDeleteGuest(
      CheckoutDeleteGuest event, Emitter<CheckoutState> emit) {
    final guests = List<GuestModel>.from(state.guest)..remove(event.guest);
    emit(state.copyWith(guest: guests));
  }

  FutureOr<void> _onCheckoutAddPromo(
      CheckoutAddPromo event, Emitter<CheckoutState> emit) {
    final promo = event.promo;
    emit(state.copyWith(promo: () => promo));
  }

  FutureOr<void> _onCheckoutRemovePromo(
      CheckoutRemovePromo event, Emitter<CheckoutState> emit) {
    emit(state.copyWith(promo: () => null));
  }

  FutureOr<void> _onCheckoutAddBookingTimes(
      CheckoutAddBookingTimes event, Emitter<CheckoutState> emit) {
    final dates = event.dates;
    emit(state.copyWith(bookingDates: dates));
  }

  FutureOr<void> _onCheckoutGoToPaymentStep(
      CheckoutGoToPaymentStep event, Emitter<CheckoutState> emit) {
    emit(state.copyWith(step: CheckoutStep.payment));
  }

  FutureOr<void> _onCheckoutChooseTypePayment(
      CheckoutChooseTypePayment event, Emitter<CheckoutState> emit) {
    final type = event.type;
    emit(state.copyWith(typePayment: type));
  }

  FutureOr<void> _onCheckoutAddCard(
      CheckoutAddCard event, Emitter<CheckoutState> emit) {
    final card = event.card;
    emit(state.copyWith(card: card));
  }

  FutureOr<void> _onCheckoutGoToConfirmStep(
      CheckoutGoToConfirmStep event, Emitter<CheckoutState> emit) {
    emit(state.copyWith(step: CheckoutStep.confirm));
  }

  FutureOr<void> _onCheckoutGoToBookingAndReviewStep(
      CheckoutGoToBookingAndReviewStep event, Emitter<CheckoutState> emit) {
    emit(state.copyWith(step: CheckoutStep.booking_and_review));
  }

  FutureOr<void> _onCheckoutPayNow(
      CheckoutPayNow event, Emitter<CheckoutState> emit) async {
    emit(state.copyWith(status: CheckoutStatus.inProcess));
    try {
      final booking = BookingModel(
          email: event.email,
          hotel: state.hotel!,
          room: state.room!,
          guest: state.guest,
          typePayment: state.typePayment!,
          dateStart: state.bookingDates[0]!,
          dateEnd: state.bookingDates[1]!,
          card: state.typePayment == TypePayment.card ? state.card : null,
          promoCode: state.promo?.code,
          createdAt: DateTime.now());
      final bookingId = await bookingRepository.createBooking(booking);
      await Future.delayed(Duration(seconds: 1));
      emit(
          state.copyWith(status: CheckoutStatus.success, bookingId: bookingId));
    } catch (e) {
      print(e);
      emit(state.copyWith(status: CheckoutStatus.failure));
    }
    return null;
  }

  FutureOr<void> _onCheckoutChangeStep(
      CheckoutChangeStep event, Emitter<CheckoutState> emit) {
    if (CheckoutStep.values.indexOf(event.step) <
        CheckoutStep.values.indexOf(state.step)) {
      emit(state.copyWith(step: event.step));
    }
  }
}
