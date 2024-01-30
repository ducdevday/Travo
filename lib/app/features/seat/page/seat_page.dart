part of seat;

class SeatPage extends StatefulWidget {
  final SeatModel? seat;
  final List<SeatPlaceModel>? seatPlaces;
  final num? price;
  final String? fromPlace;
  final String? toPlace;

  const SeatPage(
      {Key? key,
      this.seat,
      required this.seatPlaces,
      required this.price,
      required this.fromPlace,
      required this.toPlace})
      : super(key: key);

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  late SeatBloc _bloc;
  List<SeatPlaceModel>? seatPlaces;

  SeatType? chosenSeatType;
  int? chosenRowIndex;
  int? chosenSeatIndex;
  bool canProcessed = false;

  @override
  void initState() {
    super.initState();
    seatPlaces = widget.seatPlaces;
    _bloc = SeatBloc();
    if (widget.seat != null) {
      _bloc.add(SeatChoosePressed(
          chosenSeatType: widget.seat?.type,
          chosenRowIndex: SeatPlaceModel.getChosenRowIndex(widget.seat!.name!),
          chosenSeatIndex:
              SeatPlaceModel.getChosenSeatIndex(widget.seat!.name!)));
    }
  }

  bool checkConditionProcess() {
    if (chosenSeatType != null &&
        chosenRowIndex != null &&
        chosenSeatIndex != null) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<SeatBloc, SeatState>(
          listener: (context, state) {
            switch (state) {
              case SeatLoadChosenSuccess():
                chosenSeatType = state.chosenSeatType;
                chosenRowIndex = state.chosenRowIndex;
                chosenSeatIndex = state.chosenSeatIndex;
                canProcessed = checkConditionProcess();
                break;
              case SeatProcessSuccess():
                context.read<CheckoutFlightBloc>().add(CheckoutFlightAddSeat(
                    seat: SeatModel(
                        name:
                            "${chosenRowIndex}${SeatPlaceModel.getChosenSeatCharacter(chosenSeatIndex!)}",
                        type: chosenSeatType)));
                EasyLoading.showSuccess("Success");
                Navigator.of(context).pop();
            }
          },
          child: Stack(
            children: [
              const DefaultHeader(title: "Select Seat"),
              buildSeatsPlane(),
              buildSeatChosen(),
              BlocBuilder<SeatBloc, SeatState>(
                builder: (context, state) {
                  return Positioned(
                      left: AppDimen.screenPadding,
                      right: AppDimen.screenPadding,
                      bottom: AppDimen.spacing,
                      child: MyPrimaryButton(
                        text: "Processed",
                        callback: () {
                          _bloc.add(SeatProcessPressed());
                        },
                        isEnable: canProcessed,
                      ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Positioned buildSeatChosen() {
    return Positioned(
                top: 240,
                left: 20,
                child: SizedBox(
                  width: 135,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyCard(
                        padding: AppDimen.spacing,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(
                                  AppPath.icSeat,
                                  width: AppDimen.mediumSize,
                                  height: AppDimen.mediumSize,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Seat",
                                      style: AppStyle.normalTextBlackStyle
                                          .copyWith(
                                              color: AppColor.headingColor),
                                    ),
                                    BlocBuilder<SeatBloc, SeatState>(
                                      builder: (context, state) {
                                        return Text(
                                          "${chosenRowIndex ?? " "}${SeatPlaceModel.getChosenSeatCharacter(chosenSeatIndex ?? -1)}",
                                          style: AppStyle.largeTitleStyle
                                              .copyWith(
                                                  color:
                                                      AppColor.primaryColor),
                                        );
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
                            BlocBuilder<SeatBloc, SeatState>(
                              builder: (context, state) {
                                return Text(
                                  "${chosenSeatType != null ? chosenSeatType!.toJson() : ""} ${chosenSeatType != null ? "Class" : ""}",
                                  style: AppStyle.normalTextBlackStyle,
                                );
                              },
                            ),
                            const SizedBox(
                              height: AppDimen.spacing,
                            ),
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: AppDimen.spacing),
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                    color: AppColor.secondaryColor,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            AppDimen.smallRadius))),
                                child: Center(
                                  child: Text(
                                    "${StringFormatUtil.formatMoney(widget.price)}",
                                    style: AppStyle.largeTitleStyle.copyWith(
                                        color: AppColor.primaryColor),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      Column(
                        children: [
                          Text(widget.toPlace!,
                              style: AppStyle.largeTitleStyle
                                  .copyWith(color: AppColor.primaryColor)),
                          const SizedBox(
                            height: AppDimen.smallPadding,
                          ),
                          RotatedBox(
                            quarterTurns: 3,
                            child: SvgPicture.asset(AppPath.icAirPlane,
                                width: AppDimen.mediumSize,
                                color: AppColor.primaryColor),
                          ),
                          const SizedBox(
                            height: AppDimen.smallPadding,
                          ),
                          Text(widget.fromPlace!,
                              style: AppStyle.largeTitleStyle
                                  .copyWith(color: AppColor.primaryColor)),
                        ],
                      )
                    ],
                  ),
                ));
  }

  Positioned buildSeatsPlane() {
    return Positioned(
              top: 100,
              right: 0,
              child: SizedBox(
                width: 240,
                height: 678,
                child: Stack(
                  children: [
                    Image.asset(
                      AppPath.img_in_plane,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 220,
                          ),
                          SizedBox(
                            height: 440,
                            child: ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              itemCount: seatPlaces!.length,
                              itemBuilder: (context, index) {
                                final seatType =
                                    SeatPlaceModel.getSeatType(index);
                                return Column(
                                  children: [
                                    Text(
                                      "${seatType.toJson()} Class",
                                      style: AppStyle.normalTextBlackStyle,
                                    ),
                                    Column(
                                      children: seatPlaces![index]
                                          .positions
                                          .entries
                                          .map((entry) {
                                        return Column(
                                          children: [
                                            // Text('Seat ${entry.key}:'),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ...entry.value
                                                    .asMap()
                                                    .entries
                                                    .take(
                                                        ((entry.value.length -
                                                                    1) /
                                                                2)
                                                            .round())
                                                    .map((seatEntry) {
                                                  final int rowIndex =
                                                      int.parse(entry.key);
                                                  final int seatIndex =
                                                      seatEntry.key;
                                                  final bool isOccupied =
                                                      seatEntry.value;
                                                  return SeatItem(
                                                    type: seatType,
                                                    rowIndex: rowIndex,
                                                    seatIndex: seatIndex,
                                                    isOccupied: isOccupied,
                                                  );
                                                }).toList(),
                                                Text(
                                                  '${entry.key}',
                                                  style: AppStyle
                                                      .mediumTextBlackStyle
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                ),
                                                ...entry.value
                                                    .asMap()
                                                    .entries
                                                    .skip(
                                                        ((entry.value.length -
                                                                    1) /
                                                                2)
                                                            .round())
                                                    .map((seatEntry) {
                                                  final int rowIndex =
                                                      int.parse(entry.key);
                                                  final int seatIndex =
                                                      seatEntry.key;
                                                  final bool isOccupied =
                                                      seatEntry.value;
                                                  return SeatItem(
                                                    type: seatType,
                                                    rowIndex: rowIndex,
                                                    seatIndex: seatIndex,
                                                    isOccupied: isOccupied,
                                                  );
                                                }).toList(),
                                              ],
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                    const SizedBox(height: AppDimen.spacing),
                                  ],
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
  }
}

