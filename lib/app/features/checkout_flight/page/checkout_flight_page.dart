part of checkout_flight;

class CheckoutFlightPage extends StatefulWidget {
  static const String routeName = '/checkout_flight';

  final FlightModel flight;

  const CheckoutFlightPage({Key? key, required this.flight}) : super(key: key);

  @override
  State<CheckoutFlightPage> createState() => _CheckoutFlightPageState();
}

class _CheckoutFlightPageState extends State<CheckoutFlightPage> {
  late final CheckoutFlightBloc _bloc;
  FlightModel? flight;
  GuestModel? guest;
  PromoModel? promo;
  SeatModel? seat;
  TypePayment? typePayment;
  CardModel? card;

  @override
  void initState() {
    super.initState();
    _bloc = CheckoutFlightBloc(
        bookingFlightRepository: context.read<BookingFlightRepository>())
      ..add(CheckoutFlightGoToBookingAndReviewStep());
    flight = widget.flight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<CheckoutFlightBloc, CheckoutFlightState>(
          listener: (context, state) {
            switch (state) {
              case CheckoutFlightBookingAndReviewStep():
                guest = state.guest;
                promo = state.promo;
                seat = state.seat;
                break;
              case CheckoutFlightPaymentStep():
                typePayment = state.typePayment;
                card = state.card;
                break;
              case CheckoutFlightPaymentInProcess():
                EasyLoading.show(maskType: EasyLoadingMaskType.black);
                break;
              case CheckoutFlightPaymentSuccess():
                EasyLoading.dismiss();
                EasyLoading.showSuccess("Checkout Success");
                Navigator.of(context).pushNamedAndRemoveUntil(
                    BookingFlightDetailPage.routeName, (route) => false,
                    arguments: state.bookingFlightId);
                break;
              case CheckoutFlightPaymentFailure():
                EasyLoading.dismiss();
                EasyLoading.showError("Checkout Failure\nPlease try a again");
                break;
            }
          },
          child: Column(
            children: [
              const CheckoutFlightHeader(),
              BlocBuilder<CheckoutFlightBloc, CheckoutFlightState>(
                builder: (context, state) {
                  switch (state) {
                    case CheckoutFlightBookingAndReviewStep():
                      return BookingAndReviewStep(
                        flight: flight,
                        guest: guest,
                        seat: seat,
                        promo: promo,
                        typePayment: typePayment,
                        card: card,
                      );
                    case CheckoutFlightPaymentStep():
                      return PaymentStep(
                        typePayment: typePayment,
                        card: card,
                      );
                    case CheckoutFlightConfirmStep():
                    case CheckoutFlightPaymentInProcess():
                    case CheckoutFlightPaymentFailure():
                      return ConfirmStep(
                          flight: flight,
                          guest: guest,
                          promo: promo,
                          typePayment: typePayment,
                          card: card,
                          seat: seat);
                    default:
                      return SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
