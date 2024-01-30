part of checkout;
class CheckoutPage extends StatefulWidget {
  static const String routeName = '/checkout';

  final RoomModel room;

  const CheckoutPage({Key? key, required this.room}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late final CheckoutBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = CheckoutBloc(bookingRepository: context.read<BookingRepository>())
      ..add(CheckoutSetHotelAndRoom(
          room: widget.room.id, hotel: widget.room.hotel));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<CheckoutBloc, CheckoutState>(
          listener: (context, state) {
            if (state.status == CheckoutStatus.inProcess) {
              EasyLoading.show(maskType: EasyLoadingMaskType.black);
            } else if (state.status == CheckoutStatus.success) {
              EasyLoading.dismiss();
              EasyLoading.showSuccess("Checkout Success");
              Navigator.of(context).pushNamedAndRemoveUntil(
                  BookingDetailPage.routeName, (route) => false,
                  arguments: state.bookingId);
            } else if (state.status == CheckoutStatus.failure) {
              EasyLoading.dismiss();
              EasyLoading.showSuccess("Checkout Failure");
            }
          },
          child: Stack(
            children: [
              const CheckoutHeader(),
              Column(
                children: [
                  const SizedBox(
                    height: 180,
                  ),
                  BlocBuilder<CheckoutBloc, CheckoutState>(
                    builder: (context, state) {
                      if (state.step == CheckoutStep.booking_and_review) {
                        return BookingAndReviewStep(room: widget.room);
                      } else if (state.step == CheckoutStep.payment) {
                        return const PaymentStep();
                      } else if (state.step == CheckoutStep.confirm) {
                        return ConfirmStep(room: widget.room);
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
