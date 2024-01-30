part of flight;

class FlightHeader extends StatelessWidget {
  final String fromPlace;
  final String toPlace;
  final DateTime departureDate;
  final SeatType seatType;

  const FlightHeader(
      {super.key,
      required this.fromPlace,
      required this.toPlace,
      required this.departureDate,
      required this.seatType});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AppPath.imgAppBar,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Column(
          children: [
            const SizedBox(
              height: AppDimen.headerMargin,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimen.screenPadding),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back_rounded, size: 20),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            fromPlace,
                            style: AppStyle.largeTitleStyle
                                .copyWith(color: Colors.white),
                          ),
                          const SizedBox(
                            width: AppDimen.mediumSize,
                            child: Divider(
                              color: Colors.white,
                              indent: AppDimen.spacing,
                              endIndent: AppDimen.spacing,
                            ),
                          ),
                          SvgPicture.asset(
                            AppPath.icAirPlane,
                            width: AppDimen.mediumSize,
                          ),
                          const SizedBox(
                            width: AppDimen.mediumSize,
                            child: Divider(
                              color: Colors.white,
                              indent: AppDimen.spacing,
                              endIndent: AppDimen.spacing,
                            ),
                          ),
                          Text(
                            toPlace,
                            style: AppStyle.largeTitleStyle
                                .copyWith(color: Colors.white),
                          )
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          buildShowFilterBottomSheet(
                              context, fromPlace, toPlace, departureDate);
                        },
                        icon: SvgPicture.asset(
                          AppPath.icFilter,
                          width: 20,
                          height: 20,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: AppDimen.spacing,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(StringFormatUtil.formattedShortDate2(departureDate),
                          style: AppStyle.normalTextWhiteStyle),
                      SizedBox(
                        width: AppDimen.smallSpacing,
                      ),
                      Container(
                        width: AppDimen.spacing,
                        height: AppDimen.spacing,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                      ),
                      SizedBox(
                        width: AppDimen.smallSpacing,
                      ),
                      Text("1 Adult", style: AppStyle.normalTextWhiteStyle),
                      SizedBox(
                        width: AppDimen.smallSpacing,
                      ),
                      Container(
                        width: AppDimen.spacing,
                        height: AppDimen.spacing,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                      ),
                      SizedBox(
                        width: AppDimen.smallSpacing,
                      ),
                      Text(seatType.toJson(),
                          style: AppStyle.normalTextWhiteStyle),
                    ],
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}

Future<void> buildShowFilterBottomSheet(
    BuildContext context, String fromPlace, String toPlace, DateTime departureDate) {
  return showModalBottomSheet<void>(
    backgroundColor: Colors.black.withOpacity(0.75),
    isScrollControlled: true,
    context: context,
    builder: (_) {
      return BlocProvider.value(
        value: context.read<FlightBloc>(),
        child: BlocBuilder<FlightBloc, FlightState>(
          builder: (context, state) {
            if (state is FlightLoadSuccess) {
              return FlightFilterBottomSheet(
                  fromPlace: fromPlace,
                  toPlace: toPlace,
                  departureDate: departureDate,
                  budgetFrom: state.budgetFrom,
                  budgetTo: state.budgetTo,
                  duration: state.duration,
                  sortType: state.sortType,
              );
            } else {
              return SizedBox();
            }
          },
        ),
      );
    },
  );
}
