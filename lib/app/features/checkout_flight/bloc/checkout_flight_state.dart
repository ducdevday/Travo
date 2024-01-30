part of checkout_flight;

abstract class CheckoutFlightState extends Equatable {
  const CheckoutFlightState();
}

class CheckoutFlightInitial extends CheckoutFlightState {
  @override
  List<Object> get props => [];
}

class CheckoutFlightBookingAndReviewStep extends CheckoutFlightState {
  final GuestModel? guest;
  final PromoModel? promo;
  final SeatModel? seat;

  const CheckoutFlightBookingAndReviewStep({this.guest, this.promo, this.seat});

  @override
  List<Object?> get props => [guest, promo, seat];

  CheckoutFlightBookingAndReviewStep copyWith({
    GuestModel? guest,
    ValueGetter<PromoModel?>? promo,
    TypePayment? typePayment,
    CardModel? card,
    SeatModel? seat,
  }) {
    return CheckoutFlightBookingAndReviewStep(
      guest: guest ?? this.guest,
      promo: promo != null ? promo() : this.promo,
      seat: seat ?? this.seat,
    );
  }
}

class CheckoutFlightPaymentStep extends CheckoutFlightState {
  final TypePayment? typePayment;
  final CardModel? card;

  const CheckoutFlightPaymentStep({
    this.typePayment,
    this.card,
  });


  @override
  List<Object?> get props => [typePayment, card];

  CheckoutFlightPaymentStep copyWith({
    TypePayment? typePayment,
    CardModel? card,
  }) {
    return CheckoutFlightPaymentStep(
      typePayment: typePayment ?? this.typePayment,
      card: card ?? this.card,
    );
  }
}

class CheckoutFlightConfirmStep extends CheckoutFlightState {
  @override
  List<Object> get props => [];
}

class CheckoutFlightPaymentInProcess extends CheckoutFlightState {
  @override
  List<Object> get props => [];
}

class CheckoutFlightPaymentSuccess extends CheckoutFlightState {
  final String bookingFlightId;

  const CheckoutFlightPaymentSuccess({
    required this.bookingFlightId,
  });

  @override
  List<Object> get props => [bookingFlightId];
}

class CheckoutFlightPaymentFailure extends CheckoutFlightState {
  @override
  List<Object> get props => [];
}