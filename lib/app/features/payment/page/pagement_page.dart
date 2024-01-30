part of payment;

class PaymentPage extends StatefulWidget {
  static const int page = 2;
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> with AutomaticKeepAliveClientMixin<PaymentPage>{
  late final PaymentBloc _bloc;
  List<BookingDetailModel>? bookings;
  List<BookingFlightDetailModel>? bookingFlights;
  CheckoutType? selectedType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = PaymentBloc(
        bookingRepository: context.read<BookingRepository>(),
        bookingFlightRepository:
        context.read<BookingFlightRepository>())
      ..add(PaymentLoadBooking(email: SharedService.getUserEmail()));
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: BlocProvider(
        create: (context) => _bloc,
        child: Column(
          children: [
            const DefaultHeader(
              title: "Payment",
              showBackButton: false,
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimen.screenPadding),
              child: Column(
                children: [
                  BlocBuilder<PaymentBloc, PaymentState>(
                    builder: (context, state) {
                      if (state is PaymentLoadSuccess) {
                        selectedType = state.checkoutType;
                      }
                      return Wrap(
                          direction: Axis.horizontal,
                          spacing: 4,
                          children: CheckoutType.values
                              .map((type) => FilterChip(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppDimen.spacing,
                                  ),
                                  showCheckmark: false,
                                  selectedColor: AppColor.selectedDayColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppDimen.mediumRadius),
                                    side: BorderSide(
                                      color: type == selectedType
                                          ? AppColor.selectedDayColor
                                          : AppColor.secondaryColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  backgroundColor: type == selectedType
                                      ? AppColor.selectedDayColor
                                      : AppColor.secondaryColor,
                                  label: Text(
                                    StringFormatUtil.formatCapitalizeString(
                                        type.toJson()),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: type == selectedType
                                            ? Colors.white
                                            : AppColor.primaryColor),
                                  ),
                                  color: MaterialStateProperty.all(
                                      type == selectedType
                                          ? AppColor.selectedDayColor
                                          : AppColor.secondaryColor),
                                  selected: type == selectedType,
                                  onSelected: (bool selected) {
                                    if (selected) {
                                      context
                                          .read<PaymentBloc>()
                                          .add(PaymentChangeType(type: type));
                                    }
                                  }))
                              .toList());
                    },
                  ),
                  Expanded(
                    child: BlocBuilder<PaymentBloc, PaymentState>(
                      builder: (context, state) {
                        if (state is PaymentLoadSuccess) {
                          bookings ??= state.bookings;
                          bookingFlights ??= state.bookingFlights;
                        }
                        switch (state) {
                          case PaymentLoadInProcess():
                            return ListView.separated(
                                padding: EdgeInsets.symmetric(
                                    vertical: AppDimen.spacing),
                                itemBuilder: (context, index) =>
                                    Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: const MySkeletonRectangle(
                                            width: double.infinity,
                                            height: 210)),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: AppDimen.spacing,
                                    ),
                                itemCount: 8);
                          case PaymentLoadSuccess():
                            if (selectedType == CheckoutType.hotel) {
                              if (bookings!.isEmpty) {
                                return const Center(
                                  child: Text(
                                    "Empty Booking Hotels",
                                    style: AppStyle.mediumTextBlackStyle,
                                  ),
                                );
                              }
                              return ListView.separated(
                                  padding: EdgeInsets.symmetric(
                                      vertical: AppDimen.spacing),
                                  itemBuilder: (context, index) =>
                                      BookingItem(booking: bookings![index]),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: AppDimen.spacing,
                                      ),
                                  itemCount: bookings!.length);
                            } else if (selectedType == CheckoutType.flight) {
                              if (bookingFlights!.isEmpty) {
                                return const Center(
                                  child: Text(
                                    "Empty Booking Flights",
                                    style: AppStyle.mediumTextBlackStyle,
                                  ),
                                );
                              }
                              return ListView.separated(
                                  padding: EdgeInsets.symmetric(
                                      vertical: AppDimen.spacing),
                                  itemBuilder: (context, index) =>
                                      BookingFlightItem(
                                          bookingFlight:
                                              bookingFlights![index]),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: AppDimen.spacing,
                                      ),
                                  itemCount: bookingFlights!.length);
                            }
                            return SizedBox();
                          default:
                            return SizedBox();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class BookingFlightItem extends StatelessWidget {
  final BookingFlightDetailModel bookingFlight;

  const BookingFlightItem({super.key, required this.bookingFlight});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(BookingFlightDetailPage.routeName,
            arguments: bookingFlight.id);
      },
      child: MyCard(
          child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(AppDimen.smallRadius)),
                child: Image.asset(
                  getAirlinePath(bookingFlight.flight.airline!),
                  width: 60,
                  height: 60,
                ),
              ),
              SizedBox(
                width: AppDimen.spacing,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bookingFlight.flight.airline!.toJson(),
                      overflow: TextOverflow.ellipsis,
                      style: AppStyle.mediumTextBlackStyle,
                    ),
                    SizedBox(
                      height: AppDimen.spacing,
                    ),
                    Text(
                      "From: ${bookingFlight.flight.fromPlace}",
                      overflow: TextOverflow.ellipsis,
                      style: AppStyle.normalTextBlackStyle,
                    ),
                  ],
                ),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text(
                  "${StringFormatUtil.formatMoney(bookingFlight.flight.price)}",
                  style: AppStyle.mediumTextBlackStyle,
                ),
                SizedBox(
                  height: AppDimen.spacing,
                ),
                Text(
                  "To: ${bookingFlight.flight.toPlace}",
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.normalTextBlackStyle,
                ),
              ]),
            ],
          ),
          const SizedBox(
            height: AppDimen.spacing,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${StringFormatUtil.formatShortDate(bookingFlight.flight.departureTime!)} - ${StringFormatUtil.formatShortDate(bookingFlight.flight.arriveTime!)}",
                style: AppStyle.normalTextBlackStyle,
              ),
              Text(
                "Seat: ${bookingFlight.seat.name}",
                style: AppStyle.normalTextBlackStyle,
              )
            ],
          ),
          const SizedBox(
            height: AppDimen.spacing,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Seat: ${bookingFlight.seat.name}",
                style: AppStyle.normalTextBlackStyle,
              ),
              Text(
                "Class: ${bookingFlight.seat.type?.toJson()}",
                style: AppStyle.normalTextBlackStyle,
              )
            ],
          ),
          buildDiscountItem(),
          buildTotalItem()
        ],
      )),
    );
  }

  Widget buildDiscountItem() {
    if (bookingFlight.promo != null) {
      return Column(
        children: [
          const SizedBox(
            height: AppDimen.spacing,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Discount",
                style: AppStyle.normalTextBlackStyle,
              ),
              Text(
                "${StringFormatUtil.formatNumber(bookingFlight.promo!.price * 100)}%",
                style: AppStyle.normalTextBlackStyle,
              ),
            ],
          ),
        ],
      );
    }
    return const SizedBox();
  }

  Widget buildTotalItem() {
    final discount =
        bookingFlight.promo != null ? bookingFlight.promo!.price : 0;
    return Column(
      children: [
        const SizedBox(
          height: AppDimen.spacing,
        ),
        const DottedLine(
          direction: Axis.horizontal,
          dashLength: 8.0,
          dashColor: AppColor.dottedColor,
        ),
        const SizedBox(
          height: AppDimen.spacing,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Total",
              style: AppStyle.mediumTitleBlackStyle,
            ),
            Text(
              "${StringFormatUtil.formatMoney(bookingFlight.flight.price! * (1 - discount))}",
              style: AppStyle.mediumTitleBlackStyle,
            ),
          ],
        ),
      ],
    );
  }
}

class BookingItem extends StatefulWidget {
  final BookingDetailModel booking;

  const BookingItem({Key? key, required this.booking}) : super(key: key);

  @override
  State<BookingItem> createState() => _BookingItemState();
}

class _BookingItemState extends State<BookingItem> {
  late num nights;

  @override
  void initState() {
    super.initState();
    nights =
        widget.booking.dateEnd!.difference(widget.booking.dateStart!).inDays;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(BookingDetailPage.routeName,
            arguments: widget.booking.id);
      },
      child: MyCard(
          child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(AppDimen.smallRadius)),
                child: CachedNetworkImage(
                  imageUrl: widget.booking.hotel!.image!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      MySkeletonRectangle(width: 60, height: 60),
                  errorWidget: (_, __, ___) => Container(
                      color: AppColor.unLikedColor,
                      child: Icon(
                        Icons.error_outline_rounded,
                        color: Colors.red,
                        size: AppDimen.largeSize,
                      )),
                ),
              ),
              SizedBox(
                width: AppDimen.spacing,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.booking.hotel!.name!,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyle.mediumTextBlackStyle,
                    ),
                    SizedBox(
                      height: AppDimen.spacing,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(AppPath.icLocation),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          widget.booking.hotel!.location!,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyle.normalTextBlackStyle,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text(
                  "${StringFormatUtil.formatMoney(widget.booking.room!.price)}",
                  style: AppStyle.mediumTextBlackStyle,
                ),
                SizedBox(
                  height: AppDimen.spacing,
                ),
                Text(
                  "/night",
                  style: AppStyle.smallTextBlackStyle.copyWith(fontSize: 10),
                )
              ]),
            ],
          ),
          const SizedBox(
            height: AppDimen.spacing,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${StringFormatUtil.formatShortDate(widget.booking.dateStart!)} - ${StringFormatUtil.formatShortDate(widget.booking.dateEnd!)}",
                style: AppStyle.normalTextBlackStyle,
              ),
              Text(
                "$nights nights",
                style: AppStyle.normalTextBlackStyle,
              )
            ],
          ),
          buildDiscountItem(),
          buildTotalItem()
        ],
      )),
    );
  }

  Widget buildDiscountItem() {
    if (widget.booking.promo != null) {
      return Column(
        children: [
          const SizedBox(
            height: AppDimen.spacing,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Discount",
                style: AppStyle.normalTextBlackStyle,
              ),
              Text(
                "${StringFormatUtil.formatNumber(widget.booking.promo!.price * 100)}%",
                style: AppStyle.normalTextBlackStyle,
              ),
            ],
          ),
        ],
      );
    }
    return const SizedBox();
  }

  Widget buildTotalItem() {
    final discount =
        widget.booking.promo != null ? widget.booking.promo!.price : 0;
    return Column(
      children: [
        const SizedBox(
          height: AppDimen.spacing,
        ),
        const DottedLine(
          direction: Axis.horizontal,
          dashLength: 8.0,
          dashColor: AppColor.dottedColor,
        ),
        const SizedBox(
          height: AppDimen.spacing,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Total",
              style: AppStyle.mediumTitleBlackStyle,
            ),
            Text(
              "${StringFormatUtil.formatMoney(nights * widget.booking.room!.price * (1 - discount))}",
              style: AppStyle.mediumTitleBlackStyle,
            ),
          ],
        ),
      ],
    );
  }
}
