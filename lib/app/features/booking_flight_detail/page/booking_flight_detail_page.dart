part of booking_flight_detail;

class BookingFlightDetailPage extends StatefulWidget {
  static const String routeName = "/booking_flight_detail";
  final String id;

  const BookingFlightDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<BookingFlightDetailPage> createState() =>
      _BookingFlightDetailPageState();
}

class _BookingFlightDetailPageState extends State<BookingFlightDetailPage> {
  late BookingFlightDetailBloc _bloc;
  BookingFlightDetailModel? bookingFlightDetail;

  @override
  void initState() {
    super.initState();
    _bloc = BookingFlightDetailBloc(
        bookingFlightRepository: context.read<BookingFlightRepository>())
      ..add(BookingFlightDetailLoadById(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocConsumer<BookingFlightDetailBloc, BookingFlightDetailState>(
        listener: (context, state) {
          if (state is BookingFlightDetailLoadSuccess) {
            bookingFlightDetail ??= state.bookingFlightDetail;
          }
        },
        builder: (context, state) {
          switch (state) {
            case BookingFlightDetailLoadInProcess():
              return MyLoading();
            case BookingFlightDetailLoadSuccess():
              return Scaffold(
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: AppDimen.screenPadding,
                        right: AppDimen.screenPadding,
                        bottom: AppDimen.screenPadding),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: AppDimen.screenPadding * 2,
                                bottom: AppDimen.screenPadding),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    DefaultPage.routeName, (route) => false);
                              },
                              child: Icon(Icons.close_rounded),
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 40),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Color(0xffefebe9)),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Column(
                                children: [
                                  BookingFlightDetailHeader(
                                    id: bookingFlightDetail!.id!,
                                    createdAt: bookingFlightDetail!.createdAt,
                                  ),
                                  Container(
                                    height: 4,
                                    color: Color(0xffEFEBE9),
                                  ),
                                  FlightTicket(
                                    flight: bookingFlightDetail!.flight,
                                    guest: bookingFlightDetail!.guest,
                                    seat: bookingFlightDetail!.seat,
                                    step: CheckoutStep.confirm,
                                  ),
                                  Container(
                                    height: 4,
                                    color: Color(0xffEFEBE9),
                                  ),
                                  ContactDetail(
                                      guest: bookingFlightDetail!.guest),
                                  Container(
                                    height: 4,
                                    color: Color(0xffEFEBE9),
                                  ),
                                  PromoDetail(
                                      promo: bookingFlightDetail!.promo),
                                  Container(
                                    height: 4,
                                    color: Color(0xffEFEBE9),
                                  ),
                                  PaymentDetail(
                                      card: bookingFlightDetail!.card,
                                      typePayment:
                                          bookingFlightDetail!.typePayment),
                                  Container(
                                    height: 4,
                                    color: Color(0xffEFEBE9),
                                  ),
                                  TotalPriceInformationFlight(
                                      price: bookingFlightDetail!.flight.price!,
                                      promo: bookingFlightDetail!.promo),
                                ],
                              ),
                            ),
                            Center(child: SvgPicture.asset(AppPath.icSuccess))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            case BookingDetailLoadFailure():
              return MyError();
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
