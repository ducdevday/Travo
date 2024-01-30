part of checkout;

enum CheckoutStatus { initial, inProcess, success, failure }

enum CheckoutStep { booking_and_review, payment, confirm }



class CheckoutState extends Equatable {
  final CheckoutStatus status;
  final CheckoutStep step;
  final String? hotel;
  final String? room;
  final List<GuestModel> guest;
  final PromoModel? promo;
  final List<DateTime?> bookingDates;
  final TypePayment? typePayment;
  final CardModel? card;
  final String? bookingId;

  num get nights => bookingDates[1]!.difference(bookingDates[0]!).inDays;

  const CheckoutState(
      {this.status = CheckoutStatus.initial,
      this.step = CheckoutStep.booking_and_review,
      this.hotel,
      this.room,
      this.guest = const [],
      this.promo,
      this.bookingDates = const [],
      this.typePayment,
      this.card,
      this.bookingId});

  @override
  List<Object?> get props => [
        status,
        step,
        hotel,
        room,
        guest,
        promo,
        bookingDates,
        typePayment,
        card,
        bookingId
      ];

  CheckoutState copyWith(
      {CheckoutStatus? status,
      CheckoutStep? step,
      String? hotel,
      String? room,
      List<GuestModel>? guest,
      ValueGetter<PromoModel?>? promo,
      List<DateTime?>? bookingDates,
      TypePayment? typePayment,
      CardModel? card,
      String? bookingId}) {
    return CheckoutState(
        status: status ?? this.status,
        step: step ?? this.step,
        hotel: hotel ?? this.hotel,
        room: room ?? this.room,
        guest: guest ?? this.guest,
        promo: promo != null ? promo() : this.promo,
        bookingDates: bookingDates ?? this.bookingDates,
        typePayment: typePayment ?? this.typePayment,
        card: card ?? this.card,
        bookingId: bookingId ?? this.bookingId);
  }
}
