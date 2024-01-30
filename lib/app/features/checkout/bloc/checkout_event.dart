part of checkout;

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();
}

class CheckoutGoToBookingAndReviewStep extends CheckoutEvent {
  @override
  List<Object> get props => [];
}

class CheckoutSetHotelAndRoom extends CheckoutEvent {
  final String room;
  final String hotel;

  const CheckoutSetHotelAndRoom({
    required this.room,
    required this.hotel,
  });

  @override
  List<Object> get props => [room, hotel];
}

class CheckoutAddGuest extends CheckoutEvent {
  final GuestModel guest;

  const CheckoutAddGuest({
    required this.guest,
  });

  @override
  List<Object> get props => [guest];
}

class CheckoutUpdateGuest extends CheckoutEvent {
  final GuestModel oldGuest;
  final GuestModel newGuest;

  const CheckoutUpdateGuest({
    required this.oldGuest,
    required this.newGuest,
  });

  @override
  List<Object> get props => [oldGuest, newGuest];
}

class CheckoutDeleteGuest extends CheckoutEvent {
  final GuestModel guest;

  const CheckoutDeleteGuest({
    required this.guest,
  });

  @override
  List<Object> get props => [guest];
}

class CheckoutAddPromo extends CheckoutEvent {
  final PromoModel promo;

  const CheckoutAddPromo({
    required this.promo,
  });

  @override
  List<Object> get props => [promo];
}

class CheckoutRemovePromo extends CheckoutEvent {
  @override
  List<Object> get props => [];
}

class CheckoutAddBookingTimes extends CheckoutEvent {
  final List<DateTime?> dates;

  const CheckoutAddBookingTimes({
    required this.dates,
  });

  @override
  List<Object> get props => [dates];
}

class CheckoutGoToPaymentStep extends CheckoutEvent {
  @override
  List<Object> get props => [];
}

class CheckoutChooseTypePayment extends CheckoutEvent {
  final TypePayment type;

  const CheckoutChooseTypePayment({
    required this.type,
  });

  @override
  List<Object> get props => [type];
}

class CheckoutAddCard extends CheckoutEvent {
  final CardModel card;

  const CheckoutAddCard({
    required this.card,
  });

  @override
  List<Object> get props => [card];
}

class CheckoutGoToConfirmStep extends CheckoutEvent {
  @override
  List<Object> get props => [];
}

class CheckoutPayNow extends CheckoutEvent {
  final String email;

  @override
  List<Object> get props => [email];

  const CheckoutPayNow({
    required this.email,
  });
}

class CheckoutChangeStep extends CheckoutEvent {
  final CheckoutStep step;

  const CheckoutChangeStep({
    required this.step,
  });

  @override
  List<Object> get props => [step];
}
