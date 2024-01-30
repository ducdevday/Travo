part of checkout_flight;

class SeatInformation extends StatelessWidget {
  final List<SeatPlaceModel>? seatPlaces;
  final num? price;
  final String? fromPlace;
  final String? toPlace;

  const SeatInformation(
      {Key? key, this.seatPlaces, this.price, this.fromPlace, this.toPlace})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(AppPath.icSeatCheckout,
                width: AppDimen.mediumSize),
            SizedBox(width: AppDimen.spacing),
            Text(
              "Seat",
              style: AppStyle.normalTextBlackStyle,
            ),
          ],
        ),
        SizedBox(
          height: AppDimen.smallPadding,
        ),
        BlocBuilder<CheckoutFlightBloc, CheckoutFlightState>(
          builder: (context, state) {
            if (state is CheckoutFlightBookingAndReviewStep) {
              return state.seat == null
                  ? AddButton(
                      title: "Set Seat",
                      callback: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                                  value: context.read<CheckoutFlightBloc>(),
                                  child: SeatPage(
                                      seatPlaces: seatPlaces,
                                      price: price,
                                      fromPlace: fromPlace,
                                      toPlace: toPlace),
                                )));
                      })
                  : SeatItem(
                      seatPlaces: seatPlaces,
                      seat: state.seat,
                      price: price,
                      fromPlace: fromPlace,
                      toPlace: toPlace,
                    );
            } else {
              return SizedBox();
            }
          },
        )
      ],
    ));
  }
}

class SeatItem extends StatelessWidget {
  final List<SeatPlaceModel>? seatPlaces;
  final SeatModel? seat;
  final num? price;
  final String? fromPlace;
  final String? toPlace;

  const SeatItem(
      {super.key,
      required this.seatPlaces,
      required this.seat,
      required this.price,
      required this.fromPlace,
      required this.toPlace});

  @override
  Widget build(BuildContext context) {
    if (seat != null) {
      return Row(
        children: [
          Icon(
            Icons.airplane_ticket,
            color: AppColor.primaryColor,
            size: AppDimen.mediumSize,
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppDimen.smallPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Seat: ${seat!.name} | Price: \$$price",
                    style: AppStyle.normalTextBlackStyle,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: AppDimen.smallSpacing,
                  ),
                  Text("Type: ${seat!.type!.toJson()} Class"),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                        value: context.read<CheckoutFlightBloc>(),
                        child: SeatPage(
                          seat: seat,
                          seatPlaces: seatPlaces,
                          price: price,
                          fromPlace: fromPlace,
                          toPlace: toPlace,
                        ),
                      )));
            },
            icon: const Icon(
              Icons.mode_edit_outline,
              color: AppColor.primaryColor,
              size: AppDimen.smallSize,
            ),
          )
        ],
      );
    } else {
      return SizedBox();
    }
  }
}
