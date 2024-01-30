part of checkout_flight;

class BookingAndReviewStep extends StatelessWidget {
  final FlightModel? flight;
  final GuestModel? guest;
  final PromoModel? promo;
  final SeatModel? seat;
  final TypePayment? typePayment;
  final CardModel? card;

  const BookingAndReviewStep({
    Key? key,
    required this.flight,
    required this.guest,
    required this.promo,
    required this.seat,
    required this.typePayment,
    required this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckoutFlightBloc, CheckoutFlightState>(
      listener: (context, state) {
        if (state is CheckoutFlightBookingAndReviewStep) {
          print("listener CheckoutFlightPaymentStep");
        }
      },
      builder: (context, state) {
        if (state is CheckoutFlightBookingAndReviewStep) {
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
                  step: CheckoutStep.booking_and_review,
                ),
                const SizedBox(
                  height: AppDimen.smallPadding,
                ),
                const ContactInformationFlight(),
                const SizedBox(
                  height: AppDimen.smallPadding,
                ),
                SeatInformation(
                    seatPlaces: flight?.seat,
                    price: flight?.price,
                    fromPlace: flight?.fromPlace,
                    toPlace: flight?.toPlace),
                const SizedBox(
                  height: AppDimen.smallPadding,
                ),
                const PromoInformationFlight(),
                const SizedBox(
                  height: AppDimen.smallPadding,
                ),
                GoToPaymentButton(
                    type: CheckoutType.flight,
                    typePayment: typePayment,
                    card: card)
              ],
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
