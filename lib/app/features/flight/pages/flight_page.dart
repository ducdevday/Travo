part of flight;

class FlightPage extends StatefulWidget {
  static const String routeName = "/flight";

  final String fromPlace;
  final String toPlace;
  final DateTime departureDate;
  final SeatType seatType;

  const FlightPage(
      {Key? key,
      required this.fromPlace,
      required this.toPlace,
      required this.departureDate,
      required this.seatType})
      : super(key: key);

  @override
  State<FlightPage> createState() => _FlightPageState();
}

class _FlightPageState extends State<FlightPage> {
  late final FlightBloc _bloc;
  List<FlightModel>? flights;

  @override
  void initState() {
    super.initState();
    _bloc = FlightBloc(flightRepository: context.read<FlightRepository>())
      ..add(FlightLoadAll(
          fromPlace: widget.fromPlace,
          toPlace: widget.toPlace,
          departureDate: widget.departureDate));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<FlightBloc, FlightState>(
          listener: (context, state) {
            if (state is FlightLoadSuccess) {
              flights = state.flights;
            }
          },
          child: Stack(
            children: [
              FlightHeader(
                  fromPlace: widget.fromPlace,
                  toPlace: widget.toPlace,
                  departureDate: widget.departureDate,
                  seatType: widget.seatType),
              BlocBuilder<FlightBloc, FlightState>(
                builder: (context, state) {
                  switch (state) {
                    case FlightLoadInProcess():
                      return Column(
                        children: [
                          const SizedBox(
                            height: 150,
                          ),
                          Expanded(
                            child: ListView.separated(
                                padding: const EdgeInsets.only(
                                    left: AppDimen.screenPadding,
                                    right: AppDimen.screenPadding,
                                    bottom: AppDimen.screenPadding),
                                itemBuilder: (context, index) =>
                                    Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: const MySkeletonRectangle(
                                            width: 200, height: 150)),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: AppDimen.spacing,
                                    ),
                                itemCount: 8),
                          ),
                        ],
                      );
                    case FlightLoadSuccess():
                      if (flights!.isNotEmpty) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 150,
                            ),
                            Expanded(
                              child: AnimationLimiter(
                                child: ListView.separated(
                                  padding: const EdgeInsets.only(
                                      left: AppDimen.screenPadding,
                                      right: AppDimen.screenPadding,
                                      bottom: AppDimen.screenPadding),
                                  itemCount: flights!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration: const Duration(seconds: 1),
                                      child: SlideAnimation(
                                          verticalOffset: 50.0,
                                          child: FadeInAnimation(
                                              child: FlightItem(
                                            flight: flights![index],
                                          ))),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const SizedBox(
                                    height: AppDimen.spacing,
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      } else {
                        return const Center(
                          child: Text(
                            "No Results Found",
                            style: AppStyle.mediumTextBlackStyle,
                          ),
                        );
                      }
                    default:
                      return const SizedBox();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
