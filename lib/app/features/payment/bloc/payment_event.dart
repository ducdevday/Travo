part of payment;

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class PaymentLoadBooking extends PaymentEvent {
  final String email;

  const PaymentLoadBooking({
    required this.email,
  });

  @override
  List<Object> get props => [email];
}

class PaymentChangeType extends PaymentEvent {
  final CheckoutType type;

  const PaymentChangeType({
    required this.type,
  });

  @override
  List<Object> get props => [type];
}