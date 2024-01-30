part of checkout_flight;

abstract class CheckoutFlightEvent extends Equatable {
  const CheckoutFlightEvent();
}

class CheckoutFlightGoToBookingAndReviewStep extends CheckoutFlightEvent {
  final GuestModel? guest;
  final PromoModel? promo;
  final SeatModel? seat;

  const CheckoutFlightGoToBookingAndReviewStep({
    this.guest,
    this.promo,
    this.seat,
  });

  @override
  List<Object?> get props => [guest, promo, seat];
}

class CheckoutFlightAddGuest extends CheckoutFlightEvent {
  final GuestModel guest;

  const CheckoutFlightAddGuest({
    required this.guest,
  });

  @override
  List<Object> get props => [guest];
}

class CheckoutFlightAddPromo extends CheckoutFlightEvent {
  final PromoModel promo;

  const CheckoutFlightAddPromo({
    required this.promo,
  });

  @override
  List<Object> get props => [promo];
}

class CheckoutFlightRemovePromo extends CheckoutFlightEvent {
  @override
  List<Object> get props => [];
}

class CheckoutFlightAddSeat extends CheckoutFlightEvent {
  final SeatModel seat;

  const CheckoutFlightAddSeat({
    required this.seat,
  });

  @override
  List<Object> get props => [seat];
}

class CheckoutFlightGoToPaymentStep extends CheckoutFlightEvent {
  final TypePayment? typePayment;
  final CardModel? card;

  const CheckoutFlightGoToPaymentStep({
    this.typePayment,
    this.card,
  });

  @override
  List<Object?> get props => [typePayment, card];
}

class CheckoutFlightChooseTypePayment extends CheckoutFlightEvent {
  final TypePayment type;

  const CheckoutFlightChooseTypePayment({
    required this.type,
  });

  @override
  List<Object> get props => [type];
}

class CheckoutFlightAddCard extends CheckoutFlightEvent {
  final CardModel card;

  const CheckoutFlightAddCard({
    required this.card,
  });

  @override
  List<Object> get props => [card];
}

class CheckoutFlightGoToConfirmStep extends CheckoutFlightEvent {
  @override
  List<Object> get props => [];
}

class CheckoutFlightPayNow extends CheckoutFlightEvent {
  final String email;
  final String flight;
  final GuestModel guest;
  final String? promoCode;
  final SeatModel seat;
  final TypePayment typePayment;
  final CardModel? card;
  final DateTime? createdAt;

  const CheckoutFlightPayNow({
    required this.email,
    required this.flight,
    required this.guest,
    this.promoCode,
    required this.seat,
    required this.typePayment,
    this.card,
    this.createdAt,
  });

  @override
  List<Object?> get props =>
      [email, flight, guest, promoCode, seat, typePayment, card, createdAt,];
}
