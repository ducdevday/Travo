part of booking_detail;

class BookingDetailPage extends StatefulWidget {
  static const String routeName = "/booking_detail";
  final String bookingId;

  const BookingDetailPage({Key? key, required this.bookingId})
      : super(key: key);

  @override
  State<BookingDetailPage> createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends State<BookingDetailPage> {
  late BookingDetailBloc _bloc;
  BookingDetailModel? bookingDetail;

  @override
  void initState() {
    super.initState();
    _bloc =
        BookingDetailBloc(bookingRepository: context.read<BookingRepository>())
          ..add(BookingDetailLoadById(bookingId: widget.bookingId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocConsumer<BookingDetailBloc, BookingDetailState>(
        listener: (context, state) {
          if (state is BookingDetailLoadSuccess) {
            bookingDetail ??= state.bookingDetail;
          }
        },
        builder: (context, state) {
          switch (state) {
            case BookingDetailLoadInProcess():
              return MyLoading();
            case BookingDetailLoadSuccess():
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
                                  BookingDetailHeader(
                                      bookingId: bookingDetail!.id!,
                                      createdAt: bookingDetail!.createdAt,
                                      hotelName: bookingDetail!.hotel!.name!),
                                  Container(
                                    height: 4,
                                    color: Color(0xffEFEBE9),
                                  ),
                                  RoomItemBooking(
                                    room: bookingDetail!.room!,
                                  ),
                                  Container(
                                    height: 4,
                                    color: Color(0xffEFEBE9),
                                  ),
                                  ContactDetail(guests: bookingDetail!.guest!),
                                  Container(
                                    height: 4,
                                    color: Color(0xffEFEBE9),
                                  ),
                                  PromoDetail(promo: bookingDetail!.promo),
                                  Container(
                                    height: 4,
                                    color: Color(0xffEFEBE9),
                                  ),
                                  BookingDateDetail(bookingDates: [
                                    bookingDetail!.dateStart,
                                    bookingDetail!.dateEnd
                                  ]),
                                  Container(
                                    height: 4,
                                    color: Color(0xffEFEBE9),
                                  ),
                                  PaymentDetail(
                                      card: bookingDetail!.card,
                                      typePayment: bookingDetail!.typePayment!),
                                  Container(
                                    height: 4,
                                    color: Color(0xffEFEBE9),
                                  ),
                                  TotalPriceDetail(
                                    bookingDates: [
                                      bookingDetail!.dateStart,
                                      bookingDetail!.dateEnd
                                    ],
                                    roomPrice: bookingDetail!.room!.price,
                                    promo: bookingDetail!.promo,
                                  )
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
