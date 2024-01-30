part of flight;

class FlightFilterBottomSheet extends StatefulWidget {
  final String fromPlace;
  final String toPlace;
  final DateTime departureDate;
  final num? budgetFrom;
  final num? budgetTo;
  final num? duration;
  final FlightSortType? sortType;

  const FlightFilterBottomSheet(
      {super.key,
      required this.fromPlace,
      required this.toPlace,
      required this.departureDate,
      required this.budgetFrom,
      required this.budgetTo,
      required this.duration,
      required this.sortType});

  @override
  State<FlightFilterBottomSheet> createState() =>
      _FlightFilterBottomSheetState();
}

class _FlightFilterBottomSheetState extends State<FlightFilterBottomSheet> {
  late RangeValues _currentBudgetRangeValues;
  late RangeValues _currentDurationRangeValues;
  FlightSortType? sortType;

  // ? Data
  // * 51h or 42h
  // * 0 - 200
  @override
  void initState() {
    super.initState();
    _currentBudgetRangeValues = RangeValues(
        widget.budgetFrom != null ? widget.budgetFrom!.toDouble() : 100,
        widget.budgetTo != null ? widget.budgetTo!.toDouble() : 300);
    _currentDurationRangeValues = RangeValues(
        0, widget.duration != null ? widget.duration!.toDouble() : 10);
    sortType = widget.sortType;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      maxChildSize: 0.85,
      minChildSize: 0.2,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          padding: const EdgeInsets.only(
              left: AppDimen.screenPadding,
              right: AppDimen.screenPadding,
              bottom: AppDimen.screenPadding),
          decoration: const BoxDecoration(
            color: AppColor.backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppDimen.mediumPadding),
              topRight: Radius.circular(AppDimen.mediumPadding),
            ),
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: AppDimen.screenPadding),
                child: Container(
                  height: 5,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: AppDimen.mediumPadding,
              ),
              BlocBuilder<FlightBloc, FlightState>(
                builder: (context, state) {
                  if (state is FlightLoadSuccess) {
                    return Expanded(
                      child: ListView(
                        controller: scrollController,
                        padding: EdgeInsets.zero,
                        physics: const ClampingScrollPhysics(),
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Choose Your Filter",
                                style: AppStyle.mediumHeaderStyle,
                              ),
                              const SizedBox(
                                height: AppDimen.smallPadding,
                              ),
                              buildCurrentFilter(state),
                              const Text(
                                "Transit Duration",
                                style: AppStyle.mediumTextBlackStyle,
                              ),
                              const SizedBox(
                                height: AppDimen.mediumPadding,
                              ),
                              SliderTheme(
                                data: const SliderThemeData(
                                  thumbColor: AppColor.primaryColor,
                                  thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 20),
                                  showValueIndicator: ShowValueIndicator.always,
                                ),
                                child: RangeSlider(
                                  values: _currentDurationRangeValues,
                                  max: 72,
                                  divisions: 24,
                                  inactiveColor: const Color(0xffE5E5E5),
                                  labels: RangeLabels(
                                    "${_currentDurationRangeValues.start.round().toString()}h",
                                    "${_currentDurationRangeValues.end.round().toString()}h",
                                  ),
                                  onChanged: (RangeValues values) {
                                    setState(() {
                                      _currentDurationRangeValues =
                                          RangeValues(0, values.end);
                                    });
                                  },
                                ),
                              ),
                              const Text(
                                "Budget",
                                style: AppStyle.mediumTextBlackStyle,
                              ),
                              const SizedBox(
                                height: AppDimen.mediumPadding,
                              ),
                              SliderTheme(
                                data: const SliderThemeData(
                                  thumbColor: AppColor.primaryColor,
                                  thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 20),
                                  showValueIndicator: ShowValueIndicator.always,
                                ),
                                child: RangeSlider(
                                  values: _currentBudgetRangeValues,
                                  max: 1000,
                                  divisions: 10,
                                  inactiveColor: const Color(0xffE5E5E5),
                                  labels: RangeLabels(
                                    "${StringFormatUtil.formatMoney(_currentBudgetRangeValues.start.round())}",
                                    "${StringFormatUtil.formatMoney(_currentBudgetRangeValues.end.round())}",
                                  ),
                                  onChanged: (RangeValues values) {
                                    setState(() {
                                      _currentBudgetRangeValues = values;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: AppDimen.spacing,
                              ),
                              FilterOption(
                                  icPath: AppPath.icSort,
                                  title: "Sort By",
                                  callback: () {},
                                  body: FlightSortType.values
                                      .mapIndexed((index, e) => Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: AppDimen.spacing,
                                                horizontal:
                                                    AppDimen.smallPadding),
                                            child: SortItem(
                                                title:
                                                    FlightSortType.getName(e),
                                                value: e,
                                                groupValue: sortType,
                                                callback:
                                                    (FlightSortType? value) {
                                                  setState(() {
                                                    sortType = value;
                                                  });
                                                }),
                                          ))
                                      .toList()),
                              const SizedBox(
                                height: AppDimen.spacing,
                              ),
                              Column(
                                children: [
                                  MyPrimaryButton(
                                      width: double.infinity,
                                      text: "Apply",
                                      callback: () {
                                        context.read<FlightBloc>().add(
                                            FlightApplyFilter(
                                                fromPlace: widget.fromPlace,
                                                toPlace: widget.toPlace,
                                                departureDate:
                                                    widget.departureDate,
                                                duration:
                                                    _currentDurationRangeValues
                                                        .end,
                                                budgetFrom:
                                                    _currentBudgetRangeValues
                                                        .start,
                                                budgetTo:
                                                    _currentBudgetRangeValues
                                                        .end,
                                                sortType: sortType));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content:
                                                    Text("Applied Filter")));
                                        Navigator.of(context).pop();
                                      }),
                                  const SizedBox(
                                    height: AppDimen.spacing,
                                  ),
                                  MySecondaryButton(
                                      width: double.infinity,
                                      text: "Reset",
                                      isEnable: state.budgetTo != null &&
                                          state.budgetFrom != null &&
                                          state.duration != null,
                                      callback: () {
                                        showDialog(
                                            context: context,
                                            builder:
                                                (BuildContext dialogContext) =>
                                                    MyConfirmDialog(
                                                      title: "Clear Filter",
                                                      content:
                                                          "Are you sure to clear filter",
                                                      callbackOK: () {
                                                        Navigator.of(context)
                                                            .pop(true);
                                                      },
                                                      callbackCancel: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    )).then((value) {
                                          if (value != null && value == true) {
                                            context.read<FlightBloc>().add(
                                                FlightLoadAll(
                                                    fromPlace: widget.fromPlace,
                                                    toPlace: widget.toPlace,
                                                    departureDate:
                                                        widget.departureDate));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Cleared Filter")));
                                            Navigator.of(context).pop();
                                          }
                                        });
                                      }),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildCurrentFilter(FlightLoadSuccess state) {
    if (state.budgetFrom != null &&
        state.budgetTo != null &&
        state.duration != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: AppDimen.smallPadding,
          ),
          const Text(
            "Current Filter: ",
            style: AppStyle.mediumTitleBlackStyle,
          ),
          const SizedBox(
            height: AppDimen.spacing,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: AppDimen.spacing),
            padding:
            const EdgeInsets.symmetric(horizontal: AppDimen.smallPadding, vertical: AppDimen.spacing),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: Colors.white),
            child: Text(
              "Duration: ${StringFormatUtil.formatNumber(state.duration!)}h",
              style: AppStyle.normalTextBlackStyle,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: AppDimen.spacing),
            padding:
            const EdgeInsets.symmetric(horizontal: AppDimen.smallPadding, vertical: AppDimen.spacing),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: Colors.white),
            child: Text(
              "Budget: ${StringFormatUtil.formatMoney(state.budgetFrom)} - ${StringFormatUtil.formatMoney(state.budgetTo)}",
              style: AppStyle.normalTextBlackStyle,
            ),
          ),
          if (state.sortType != null)
            Container(
              margin: const EdgeInsets.only(bottom: AppDimen.spacing),
              padding:
                  const EdgeInsets.symmetric(horizontal: AppDimen.smallPadding, vertical: AppDimen.spacing),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: Colors.white),
              child: Text(
                "Sort By: ${FlightSortType.getName(state.sortType!)}",
                style: AppStyle.normalTextBlackStyle,
              ),
            ),
          const SizedBox(
            height: AppDimen.smallPadding,
          ),
        ],
      );
    }
    return const SizedBox();
  }
}
