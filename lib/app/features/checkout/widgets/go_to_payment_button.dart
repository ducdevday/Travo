part of checkout;

class GoToPaymentButton extends StatelessWidget {
  final CheckoutType type;
  final TypePayment? typePayment;
  final CardModel? card;

  const GoToPaymentButton(
      {super.key, required this.type, this.typePayment, this.card});

  @override
  Widget build(BuildContext context) {
    if (type == CheckoutType.hotel) {
      return BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          return MyPrimaryButton(
              text: "Payment",
              isEnable: state.guest.isEmpty || state.bookingDates.isEmpty
                  ? false
                  : true,
              width: double.maxFinite,
              callback: () {
                context.read<CheckoutBloc>().add(CheckoutGoToPaymentStep());
              });
        },
      );
    } else {
      return BlocBuilder<CheckoutFlightBloc, CheckoutFlightState>(
        builder: (context, state) {
          if (state is CheckoutFlightBookingAndReviewStep) {
            return MyPrimaryButton(
                text: "Payment",
                isEnable:
                    state.guest == null || state.seat == null ? false : true,
                width: double.maxFinite,
                callback: () {
                  context.read<CheckoutFlightBloc>().add(
                      CheckoutFlightGoToPaymentStep(
                          typePayment: typePayment, card: card));
                });
          }
          return SizedBox();
        },
      );
    }
  }
}
