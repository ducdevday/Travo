part of flight;

class FlightItem extends StatelessWidget {
  final FlightModel flight;

  const FlightItem({Key? key, required this.flight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(CheckoutFlightPage.routeName, arguments: flight);
      },
      child: PhysicalShape(
        color: Colors.white,
        elevation: 4,
        shadowColor: Color(0xFFE4E4E4).withOpacity(0.5),
        clipper: TicketClipperHorizontal(),
        child: Stack(
          children: <Widget>[
            ClipPath(
              clipper: TicketClipperHorizontal(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(AppDimen.screenPadding),
                      width: MediaQuery.of(context).size.width * 3.5 / 10 - 5,
                      child: Image.asset(
                        getAirlinePath(flight.airline!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    DottedLine(
                      direction: Axis.vertical,
                      dashLength: 8.0,
                      dashColor: AppColor.dottedColor,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: AppDimen.spacing,horizontal: AppDimen.screenPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              Text(
                                "Departure",
                                style: AppStyle.normalTextBlackStyle,
                              ),
                              Text(
                                StringFormatUtil.formattedLongTime(
                                    flight.departureTime!),
                                style: AppStyle.mediumTextBlackStyle,
                              ),
                              Text(
                                "Flight No.",
                                style: AppStyle.normalTextBlackStyle,
                              ),
                              Text(
                                flight.no!,
                                style: AppStyle.mediumTextBlackStyle
                                    ,
                              ),
                            ],),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              Text(
                                "Arrive",
                                style: AppStyle.normalTextBlackStyle,
                              ),
                              Text(
                                StringFormatUtil.formattedLongTime(
                                    flight.arriveTime!),
                                style: AppStyle.mediumTextBlackStyle
                                    ,
                              ),
                                Text(
                                  "",
                                  style: AppStyle.normalTextBlackStyle,
                                ),
                              Text(
                                "${StringFormatUtil.formatMoney(flight.price)}",
                                style: AppStyle.largeTitleStyle
                                    ,
                              ),
                            ],),
                          ],
                        ),
                      ),
                    )
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
      ),
    );
  }
}

String getAirlinePath(AirlineType type) {
  switch (type) {
    case AirlineType.AirAsia:
      return AppPath.img_air_asia;
    case AirlineType.BatikAir:
      return AppPath.img_batik_air;
    case AirlineType.Citilink:
      return AppPath.img_citilink;
    case AirlineType.Garuna:
      return AppPath.img_garuda_indonesia;
    case AirlineType.LionAir:
      return AppPath.img_lion_air;
    default:
      return "";
  }
}

class TicketClipperHorizontal extends CustomClipper<Path> {
  //! Change size.width * 3.5 to change position of haft circle
  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.lineTo(size.width * 3.5 / 10, 0.0);
    path.relativeArcToPoint(const Offset(20, 0),
        radius: const Radius.circular(10.0), largeArc: true, clockwise: false);
    path.lineTo(size.width - 10, 0);
    path.quadraticBezierTo(size.width, 0.0, size.width, 10.0);
    path.lineTo(size.width, size.height - 10);
    path.quadraticBezierTo(
        size.width, size.height, size.width - 10, size.height);
    path.lineTo(size.width * 3.5 / 10 + 20, size.height);
    path.arcToPoint(Offset((size.width * 3.5 / 10), size.height),
        radius: const Radius.circular(10.0), clockwise: false);
    path.lineTo(10.0, size.height);
    path.quadraticBezierTo(0.0, size.height, 0.0, size.height - 10);
    path.lineTo(0.0, 10.0);
    path.quadraticBezierTo(0.0, 0.0, 10.0, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.grey.shade300;
    Path path = Path();
//    uncomment this and will get the border for all lines
    path.lineTo(size.width * 3 / 4, 0.0);
    path.relativeArcToPoint(const Offset(20, 0),
        radius: const Radius.circular(10.0), largeArc: true, clockwise: false);
    path.lineTo(size.width - 10, 0);
    path.quadraticBezierTo(size.width, 0.0, size.width, 10.0);
    path.lineTo(size.width, size.height - 10);
    path.quadraticBezierTo(
        size.width, size.height, size.width - 10, size.height);
    path.lineTo(size.width * 3 / 4 + 20, size.height);
    path.arcToPoint(Offset((size.width * 3 / 4), size.height),
        radius: const Radius.circular(10.0), clockwise: false);
    path.lineTo(10.0, size.height);
    path.quadraticBezierTo(0.0, size.height, 0.0, size.height - 10);
    path.lineTo(0.0, 10.0);
    path.quadraticBezierTo(0.0, 0.0, 10.0, 0.0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
