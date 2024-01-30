part of checkout_flight;

class ConfirmStep extends StatelessWidget {
  final FlightModel? flight;
  final GuestModel? guest;
  final PromoModel? promo;
  final TypePayment? typePayment;
  final CardModel? card;
  final SeatModel? seat;

  const ConfirmStep({
    super.key,
    required this.flight,
    required this.guest,
    required this.promo,
    required this.typePayment,
    required this.card,
    required this.seat,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutFlightBloc, CheckoutFlightState>(
      builder: (context, state) {
        return Expanded(
          child: ListView(
            padding: const EdgeInsets.only(
                top: AppDimen.smallPadding,
                left: AppDimen.screenPadding,
                right: AppDimen.screenPadding,
                bottom: AppDimen.smallPadding),
            children: [
              FlightTicket(
                flight: flight!,
                guest: guest,
                seat: seat,
                step: CheckoutStep.confirm,
              ),
              const SizedBox(
                height: AppDimen.smallPadding,
              ),
              TotalPriceInformationFlight(
                  price: flight!.price!, promo: promo),
              const SizedBox(
                height: AppDimen.smallPadding,
              ),
              PaymentInformationFlight(
                typePayment: typePayment!,
                card: card,
              ),
              const SizedBox(
                height: AppDimen.smallPadding,
              ),
              BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  if (state is UserLoadSuccess) {
                    return MyPrimaryButton(
                        text: "Pay Now",
                        callback: () {
                          context
                              .read<CheckoutFlightBloc>()
                              .add(CheckoutFlightPayNow(
                            email: state.user.email,
                            flight: flight!.id!,
                            guest: guest!,
                            promoCode: promo?.code,
                            seat: seat!,
                            typePayment: typePayment!,
                            card: card,
                          ));
                        });
                  } else {
                    return const SizedBox();
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }
}