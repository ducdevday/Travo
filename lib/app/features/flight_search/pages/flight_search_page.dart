part of flight_search;

class FlightSearchPage extends StatefulWidget {
  static const String routeName = "/flight_search";

  const FlightSearchPage({Key? key}) : super(key: key);

  @override
  State<FlightSearchPage> createState() => _FlightSearchPageState();
}

class _FlightSearchPageState extends State<FlightSearchPage> {
  late final FlightSearchCubit _cubit;
  late final TextEditingController flightFromTextController;
  late final TextEditingController flightToTextController;
  List<DateTime?> _dates = [];
  SeatType? seatType;

  // ? Data
  // * USA
  // * Australia
  // * 22/10/2023

  @override
  void initState() {
    super.initState();
    flightFromTextController = TextEditingController();
    flightToTextController = TextEditingController();
    _cubit = FlightSearchCubit();
  }

  @override
  void dispose() {
    flightFromTextController.dispose();
    flightToTextController.dispose();
    super.dispose();
  }

  void checkValidAllField() {
    _cubit.checkValidField(flightFromTextController.text,
        flightToTextController.text, _dates, seatType);
  }

  String? getErrorText(
    String text,
    FieldEnum type,
  ) {
    checkValidAllField();
    if (type == FieldEnum.NAME && !ValidateFieldUtil.validateFlightPlace(text)) {
      return "Field can't be empty";
    } else {
      return null;
    }
  }

  void switchFlightFromAndTo() {
    String temp = flightFromTextController.text;
    flightFromTextController.text = flightToTextController.text;
    flightToTextController.text = temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _cubit,
        child: Column(
          children: [
            const DefaultHeader(title: "Book Your\nFlight"),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimen.screenPadding),
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: AppDimen.screenPadding),
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          FlightInputField(
                              title: "From",
                              hint: "Enter From Country",
                              validateField: (String value) =>
                                  getErrorText(value, FieldEnum.NAME),
                              controller: flightFromTextController,
                              icPath: AppPath.icFlightFrom),
                          FlightInputField(
                              title: "To",
                              hint: "Enter To Country",
                              validateField: (String value) =>
                                  getErrorText(value, FieldEnum.NAME),
                              controller: flightToTextController,
                              icPath: AppPath.icFlightTo),
                        ],
                      ),
                      buildSwitchButton()
                    ],
                  ),
                  BlocBuilder<FlightSearchCubit, FlightSearchState>(
                    builder: (context, state) {
                      return MyFieldContainer(
                        errorText: "",
                        child: InkWell(
                          onTap: () async {
                            var results = await showCalendarDatePicker2Dialog(
                              context: context,
                              config:
                                  CalendarDatePicker2WithActionButtonsConfig(),
                              dialogSize: const Size(400, 400),
                              value: _dates,
                              borderRadius: BorderRadius.circular(15),
                            );
                            _dates = results!;
                            checkValidAllField();
                          },
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  SvgPicture.asset(
                                    AppPath.icCalendar,
                                    width: 32,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: AppDimen.smallPadding,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Departure",
                                      style: AppStyle.smallTextBlackStyle,
                                    ),
                                    const SizedBox(
                                      height: AppDimen.spacing,
                                    ),
                                    Text(
                                      _dates.isNotEmpty
                                          ? StringFormatUtil.formattedLongDate(
                                              _dates[0]!)
                                          : "Select Date",
                                      style: AppStyle.normalTextBlackStyle,
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  MyFieldContainer(
                    errorText: "",
                    child: Row(
                      children: [
                        Column(
                          children: [
                            SvgPicture.asset(
                              AppPath.icPassenger,
                              width: 32,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              height: 16,
                            )
                          ],
                        ),
                        const SizedBox(
                          width: AppDimen.smallPadding,
                        ),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Passenger",
                                style: AppStyle.smallTextBlackStyle,
                              ),
                              SizedBox(
                                height: AppDimen.spacing,
                              ),
                              Text(
                                "1 Passenger",
                                style: AppStyle.normalTextBlackStyle,
                              ),
                              SizedBox(
                                height: 16,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<FlightSearchCubit, FlightSearchState>(
                    builder: (context, state) {
                      return MyFieldContainer(
                        errorText: "",
                        child: InkWell(
                          onTap: () {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (BuildContext contextPopup) =>
                                    CupertinoActionSheet(
                                      title: const Text("Select Seat Type"),
                                      actions: [
                                        CupertinoActionSheetAction(
                                          onPressed: () {
                                            seatType = SeatType.Bussiness;
                                            checkValidAllField();
                                            Navigator.pop(contextPopup);
                                          },
                                          child: Text(
                                            SeatType.Bussiness.toJson(),
                                            style: AppStyle.mediumTextBlackStyle
                                                .copyWith(
                                                    color: AppColor.infoColor),
                                          ),
                                        ),
                                        CupertinoActionSheetAction(
                                          onPressed: () {
                                            seatType = SeatType.Economy;
                                            checkValidAllField();
                                            Navigator.pop(contextPopup);
                                          },
                                          isDestructiveAction: true,
                                          child: Text(
                                            SeatType.Economy.toJson(),
                                            style: AppStyle.mediumTextBlackStyle
                                                .copyWith(
                                                    color: AppColor.infoColor),
                                          ),
                                        ),
                                      ],
                                      cancelButton: CupertinoActionSheetAction(
                                        onPressed: () {
                                          Navigator.pop(contextPopup);
                                        },
                                        child: Text(
                                          'Cancel',
                                          style: AppStyle.mediumTextBlackStyle
                                              .copyWith(
                                                  color: AppColor.likedColor),
                                        ),
                                      ),
                                    ));
                          },
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  SvgPicture.asset(
                                    AppPath.icSeat,
                                    width: 32,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: AppDimen.smallPadding,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Class",
                                      style: AppStyle.smallTextBlackStyle,
                                    ),
                                    const SizedBox(
                                      height: AppDimen.spacing,
                                    ),
                                    Text(
                                      seatType != null
                                          ? seatType!.toJson()
                                          : "Select Seat Type",
                                      style: AppStyle.normalTextBlackStyle,
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  BlocBuilder<FlightSearchCubit, FlightSearchState>(
                    builder: (context, state) {
                      return MyPrimaryButton(
                        text: "Search",
                        callback: () {
                          Navigator.of(context)
                              .pushNamed(FlightPage.routeName, arguments: {
                            "fromPlace": flightFromTextController.text,
                            "toPlace": flightToTextController.text,
                            "departureDate": _dates[0],
                            "seatType": seatType
                          });
                        },
                        isEnable: state is FlightSearchReady ? true : false,
                      );
                    },
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget buildSwitchButton() {
    return Positioned(
      right: 20,
      bottom: 0,
      top: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              switchFlightFromAndTo();
            },
            icon: SvgPicture.asset(
              AppPath.icSwitch,
              width: AppDimen.smallSize,
              height: AppDimen.smallSize,
            ),
            style: IconButton.styleFrom(
              backgroundColor: AppColor.secondaryColor,
              padding: const EdgeInsets.all(20),
              shape: const CircleBorder(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppDimen.smallSpacing,
                horizontal: AppDimen.smallPadding),
            child: Text(
              "",
              style: AppStyle.smallTextBlackStyle.copyWith(color: Colors.red),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppDimen.smallSpacing,
                horizontal: AppDimen.smallPadding),
            child: Text(
              "",
              style: AppStyle.smallTextBlackStyle.copyWith(color: Colors.red),
            ),
          )
        ],
      ),
    );
  }
}
