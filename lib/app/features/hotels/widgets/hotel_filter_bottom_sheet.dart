part of hotels;

class HotelFilterBottomSheet extends StatefulWidget {
  final int size;
  final num? budgetFrom;
  final num? budgetTo;
  final num? maxRating;
  final HotelSortType? sortType;
  final List<PropertyType> propertyTypes;

  const HotelFilterBottomSheet(
      {super.key,
      required this.size,
      required this.budgetFrom,
      required this.budgetTo,
      required this.maxRating,
      required this.sortType,
      required this.propertyTypes});

  @override
  State<HotelFilterBottomSheet> createState() => _HotelFilterBottomSheetState();
}

class _HotelFilterBottomSheetState extends State<HotelFilterBottomSheet> {
  late RangeValues _currentRangeValues;
  late num maxRating;
  HotelSortType? sortType;
  List<PropertyType> propertyTypes = [];

  @override
  void initState() {
    super.initState();
    _currentRangeValues = RangeValues(
        widget.budgetFrom != null ? widget.budgetFrom!.toDouble() : 100,
        widget.budgetTo != null ? widget.budgetTo!.toDouble() : 300);
    maxRating = widget.maxRating != null ? widget.maxRating!.toDouble() : 4;
    sortType = widget.sortType;
    propertyTypes = List<PropertyType>.from(widget.propertyTypes);
  }

  bool isChosenPropertyType(PropertyType type) {
    return propertyTypes.contains(type);
  }

  void handleChoosePropertyType(PropertyType type) {
    if (isChosenPropertyType(type)) {
      propertyTypes.remove(type);
    } else {
      propertyTypes.add(type);
    }
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
              BlocBuilder<HotelsBloc, HotelsState>(
                builder: (context, state) {
                  if (state is HotelsLoadSuccess) {
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
                                  values: _currentRangeValues,
                                  max: 1000,
                                  divisions: 10,
                                  inactiveColor: const Color(0xffE5E5E5),
                                  labels: RangeLabels(
                                    "${StringFormatUtil.formatMoney(_currentRangeValues.start.round())}",
                                    "${StringFormatUtil.formatMoney(_currentRangeValues.end.round())}",
                                  ),
                                  onChanged: (RangeValues values) {
                                    setState(() {
                                      _currentRangeValues = values;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: AppDimen.smallPadding,
                              ),
                              const Text(
                                "Hotel Class",
                                style: AppStyle.mediumTextBlackStyle,
                              ),
                              const SizedBox(
                                height: AppDimen.smallPadding,
                              ),
                              RatingBar(
                                  minRating: 0,
                                  maxRating: 5,
                                  initialRating: maxRating.toDouble(),
                                  glow: false,
                                  itemPadding: const EdgeInsets.only(
                                      right: AppDimen.smallPadding),
                                  ratingWidget: RatingWidget(
                                      full: const Icon(
                                        Icons.star_rounded,
                                        color: AppColor.starColor,
                                      ),
                                      half: const Icon(
                                        Icons.star_half_rounded,
                                        color: Colors.amber,
                                      ),
                                      empty: const Icon(
                                        Icons.star_rounded,
                                        color: AppColor.secondaryColor,
                                      )),
                                  onRatingUpdate: (value) {
                                    setState(() {
                                      maxRating = value;
                                    });
                                  }),
                              const SizedBox(
                                height: AppDimen.smallPadding,
                              ),
                              // FilterOption(
                              //     icPath: AppPath.icFacilities,
                              //     title: "Facilities",
                              //     callback: () {},
                              //     body: []),
                              FilterOption(
                                  icPath: AppPath.icProperty,
                                  title: "Property Type",
                                  callback: () {},
                                  body: PropertyType.values
                                      .mapIndexed((index, e) => Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: AppDimen.spacing,
                                                horizontal:
                                                    AppDimen.smallPadding),
                                            child: PropertyItem(
                                                title: PropertyType.getName(e),
                                                value: isChosenPropertyType(e),
                                                callback: (newValue) =>
                                                    setState(() {
                                                      handleChoosePropertyType(
                                                          e);
                                                    })),
                                          ))
                                      .toList()),
                              FilterOption(
                                  icPath: AppPath.icSort,
                                  title: "Sort By",
                                  callback: () {},
                                  body: HotelSortType.values
                                      .mapIndexed((index, e) => Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: AppDimen.spacing,
                                                horizontal:
                                                    AppDimen.smallPadding),
                                            child: SortItem(
                                                title: HotelSortType.getName(e),
                                                value: e,
                                                groupValue: sortType,
                                                callback:
                                                    (HotelSortType? value) {
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
                                      width: double.maxFinite,
                                      text: "Apply",
                                      callback: () {
                                        context.read<HotelsBloc>().add(
                                            HotelsLoadAll(
                                                page: 0,
                                                size: widget.size,
                                                budgetFrom:
                                                    _currentRangeValues.start,
                                                budgetTo:
                                                    _currentRangeValues.end,
                                                maxRating: maxRating,
                                                sortType: sortType,
                                                propertyTypes: propertyTypes));
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
                                      width: double.maxFinite,
                                      text: "Reset",
                                      isEnable: state.budgetTo != null &&
                                          state.budgetFrom != null &&
                                          state.maxRating != null,
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
                                            context.read<HotelsBloc>().add(
                                                HotelsLoadAll(
                                                    page: 0,
                                                    size: widget.size));
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

  Widget buildCurrentFilter(HotelsLoadSuccess state) {
    if (state.budgetFrom != null &&
        state.budgetTo != null &&
        state.maxRating != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
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
            padding: EdgeInsets.symmetric(
                vertical: AppDimen.spacing, horizontal: AppDimen.smallPadding),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: Colors.white),
            child: Text(
              "Budget: ${StringFormatUtil.formatMoney(state.budgetFrom)} - ${StringFormatUtil.formatMoney(state.budgetTo)}",
              style: AppStyle.normalTextBlackStyle,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: AppDimen.spacing),
            padding: EdgeInsets.symmetric(
                vertical: AppDimen.spacing, horizontal: AppDimen.smallPadding),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: Colors.white),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Star: ",
                  style: AppStyle.normalTextBlackStyle,
                ),
                const Icon(
                  Icons.star_rounded,
                  color: AppColor.starColor,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  "${state.maxRating}",
                  style: AppStyle.normalTextBlackStyle,
                )
              ],
            ),
          ),
          if (state.propertyTypes.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(bottom: AppDimen.spacing),
              padding: EdgeInsets.symmetric(
                  vertical: AppDimen.spacing,
                  horizontal: AppDimen.smallPadding),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: Colors.white),
              child: Text(
                "Property: ${propertyTypes.map((e) => PropertyType.getName(e)).join(", ")}",
                style: AppStyle.normalTextBlackStyle,
              ),
            ),
          if (state.sortType != null)
            Container(
              margin: const EdgeInsets.only(bottom: AppDimen.spacing),
              padding: EdgeInsets.symmetric(
                  vertical: AppDimen.spacing,
                  horizontal: AppDimen.smallPadding),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: Colors.white),
              child: Text(
                "Sort By: ${HotelSortType.getName(state.sortType!)}",
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
