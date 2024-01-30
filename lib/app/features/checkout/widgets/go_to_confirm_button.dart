part of checkout;

class GoToConfirmButton extends StatelessWidget {
  final CheckoutType type;

  const GoToConfirmButton({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    if (type == CheckoutType.hotel) {
      return BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          return MyPrimaryButton(
              text: "Done",
              isEnable: state.typePayment == null ||
                      (state.typePayment == TypePayment.card &&
                          state.card == null)
                  ? false
                  : true,
              width: double.maxFinite,
              callback: () {
                context.read<CheckoutBloc>().add(CheckoutGoToConfirmStep());
              });
        },
      );
    } else {
      return BlocBuilder<CheckoutFlightBloc, CheckoutFlightState>(
        builder: (context, state) {
          if (state is CheckoutFlightPaymentStep) {
            return MyPrimaryButton(
                width: double.maxFinite,
                text: "Done",
                isEnable: state.typePayment == null ||
                        (state.typePayment == TypePayment.card &&
                            state.card == null)
                    ? false
                    : true,
                callback: () {
                  context
                      .read<CheckoutFlightBloc>()
                      .add(CheckoutFlightGoToConfirmStep());
                });
          } else {
            return SizedBox();
          }
        },
      );
    }
  }
}
