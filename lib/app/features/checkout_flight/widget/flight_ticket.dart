part of checkout_flight;

class FlightTicket extends StatefulWidget {
  final FlightModel flight;
  final GuestModel? guest;
  final SeatModel? seat;
  final CheckoutStep step;

  const FlightTicket(
      {Key? key,
      required this.flight,
      required this.guest,
      required this.seat,
      required this.step})
      : super(key: key);

  @override
  State<FlightTicket> createState() => _FlightTicketState();
}

class _FlightTicketState extends State<FlightTicket> {
  double? ticketSize;
  int? divisions;

  @override
  void initState() {
    super.initState();
    switch (widget.step) {
      case CheckoutStep.booking_and_review:
        ticketSize = AppDimen.mediumTicketSize;
        divisions = 10;
        break;
      case CheckoutStep.confirm:
        ticketSize = AppDimen.largeTicketSize;
        divisions = 11;
        break;
      default:
        ticketSize = AppDimen.mediumTicketSize;
        divisions = 10;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalShape(
      color: Colors.white,
      elevation: 4,
      shadowColor: const Color(0xFFE4E4E4).withOpacity(0.5),
      clipper: TicketClipperVertical(divisions: divisions!),
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: TicketClipperVertical(divisions: divisions!),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: ticketSize,
              child: Column(
                children: [
                  SizedBox(
                    height: ticketSize! * 2 / divisions!,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.flight.fromPlace!,
                          style: AppStyle.largeTitleStyle,
                        ),
                        const SizedBox(
                          width: AppDimen.mediumSize,
                          child: Divider(
                            color: AppColor.textBlackColor,
                            indent: AppDimen.spacing,
                            endIndent: AppDimen.spacing,
                          ),
                        ),
                        SvgPicture.asset(
                          AppPath.icAirPlane,
                          width: AppDimen.mediumSize,
                          color: AppColor.textBlackColor,
                        ),
                        const SizedBox(
                          width: AppDimen.mediumSize,
                          child: Divider(
                            color: AppColor.textBlackColor,
                            indent: AppDimen.spacing,
                            endIndent: AppDimen.spacing,
                          ),
                        ),
                        Text(
                          widget.flight.toPlace!,
                          style: AppStyle.largeTitleStyle,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const DottedLine(
                    direction: Axis.horizontal,
                    dashLength: 8.0,
                    dashColor: AppColor.dottedColor,
                  ),
                  SizedBox(
                    height: ticketSize! * 6 / divisions!,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppDimen.screenPadding,
                          horizontal: AppDimen.mediumPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                getAirlinePath(widget.flight.airline!),
                                width: AppDimen.mediumSize,
                                height: AppDimen.mediumSize,
                              ),
                              const SizedBox(
                                width: AppDimen.screenPadding,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Airline",
                                    style: AppStyle.normalTextBlackStyle
                                        .copyWith(color: AppColor.headingColor),
                                  ),
                                  Text(
                                    widget.flight.airline!.toJson(),
                                    style: AppStyle.mediumTextBlackStyle
                                        .copyWith(height: 2),
                                  )
                                ],
                              ),
                              const Spacer(),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Passengers",
                                      style: AppStyle.normalTextBlackStyle
                                          .copyWith(
                                              color: AppColor.headingColor),
                                    ),
                                    Text(
                                      widget.guest?.name ?? " ",
                                      style: AppStyle.mediumTextBlackStyle
                                          .copyWith(height: 2),
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Date",
                                    style: AppStyle.normalTextBlackStyle
                                        .copyWith(color: AppColor.headingColor),
                                  ),
                                  Text(
                                    StringFormatUtil.formattedLongDate2(
                                        widget.flight.departureTime!),
                                    style: AppStyle.mediumTextBlackStyle
                                        .copyWith(height: 2),
                                  )
                                ],
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Gate",
                                    style: AppStyle.normalTextBlackStyle
                                        .copyWith(color: AppColor.headingColor),
                                  ),
                                  Text(
                                    "24A",
                                    style: AppStyle.mediumTextBlackStyle
                                        .copyWith(height: 2),
                                  )
                                ],
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Flight No.",
                                    style: AppStyle.normalTextBlackStyle
                                        .copyWith(color: AppColor.headingColor),
                                  ),
                                  Text(
                                    widget.flight.no!,
                                    style: AppStyle.mediumTextBlackStyle
                                        .copyWith(height: 2),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Boarding Time",
                                    style: AppStyle.normalTextBlackStyle
                                        .copyWith(color: AppColor.headingColor),
                                  ),
                                  Text(
                                    StringFormatUtil.formattedLongTime(
                                        widget.flight.departureTime!),
                                    style: AppStyle.mediumTextBlackStyle
                                        .copyWith(height: 2),
                                  )
                                ],
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Seat",
                                    style: AppStyle.normalTextBlackStyle
                                        .copyWith(color: AppColor.headingColor),
                                  ),
                                  Text(
                                    widget.seat?.name ?? " ",
                                    style: AppStyle.mediumTextBlackStyle
                                        .copyWith(height: 2),
                                  )
                                ],
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Class",
                                    style: AppStyle.normalTextBlackStyle
                                        .copyWith(color: AppColor.headingColor),
                                  ),
                                  Text(
                                    widget.seat?.type?.toJson() ?? " ",
                                    style: AppStyle.mediumTextBlackStyle
                                        .copyWith(height: 2),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const DottedLine(
                    direction: Axis.horizontal,
                    dashLength: 8.0,
                    dashColor: AppColor.dottedColor,
                  ),
                  buildFlightTicketBottom()
                ],
              ),
            ),
          ),
          // CustomPaint(
          //   painter: BorderPainter(),
          //   child: Container(
          //     height: 150,
          //     width: double.infinity,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget buildFlightTicketBottom() {
    if (widget.step == CheckoutStep.booking_and_review) {
      return SizedBox(
          height: ticketSize! * 2 / divisions! - 12,
          child: Padding(
            padding: const EdgeInsets.all(AppDimen.screenPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Text(
                        "${StringFormatUtil.formatMoney(widget.flight.price)}",
                        style: AppStyle.mediumHeaderStyle,
                      ),
                      Text(
                        "/passenger",
                        style:
                            AppStyle.smallTextBlackStyle.copyWith(fontSize: 10),
                      )
                    ]),
                const Text(
                  "1 passenger",
                  style: AppStyle.normalTextBlackStyle,
                )
              ],
            ),
          ));
    } else {
      return SizedBox(
          height: ticketSize! * 3 / divisions! - 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppDimen.spacing, horizontal: AppDimen.mediumPadding),
            child: Image.asset(
              AppPath.img_code,
              width: double.infinity,
            ),
          ));
    }
  }
}

class TicketClipperVertical extends CustomClipper<Path> {
  final int divisions;

  TicketClipperVertical({super.reclip, required this.divisions});

  //! Change size.height * 2 && size.height * 8 to change position of haft circle
  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.lineTo(size.width - 10, 0);
    path.quadraticBezierTo(size.width, 0.0, size.width, 10.0);
    path.lineTo(size.width, size.height * 2 / divisions);
    path.relativeArcToPoint(const Offset(0, 20),
        radius: const Radius.circular(10.0), largeArc: true, clockwise: false);
    path.lineTo(size.width, size.height * 8 / divisions);
    path.relativeArcToPoint(const Offset(0, 20),
        radius: const Radius.circular(10.0), largeArc: true, clockwise: false);
    path.lineTo(size.width, size.height - 10);
    path.quadraticBezierTo(
        size.width, size.height, size.width - 10, size.height);
    path.lineTo(10, size.height);
    path.quadraticBezierTo(0.0, size.height, 0.0, size.height - 10);
    path.lineTo(0, size.height * 8 / divisions + 20);
    path.arcToPoint(Offset(0, size.height * 8 / divisions),
        radius: const Radius.circular(10.0), clockwise: false);
    path.lineTo(0, size.height * 2 / divisions + 20);
    path.arcToPoint(Offset(0, size.height * 2 / divisions),
        radius: const Radius.circular(10.0), clockwise: false);
    path.lineTo(0.0, 10.0);
    path.quadraticBezierTo(0.0, 0.0, 10.0, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
