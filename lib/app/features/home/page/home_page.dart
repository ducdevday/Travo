part of home;

class HomePage extends StatefulWidget {
  static const int page = 0;

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin<HomePage>  {
  late HomeBloc _bloc;
  List<PlaceModel>? popularPlaces;
  bool isFocusedSearchBar = false;
  List<PlaceModel>? searchPlaces;

  @override
  void initState() {
    super.initState();
    _bloc = HomeBloc(placeRepository: context.read<PlaceRepository>())
      ..add(HomeGetPlaces());
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            switch (state) {
              case HomeLoadInProcess():
                isFocusedSearchBar = false;
              case HomeLoadSuccess():
                popularPlaces = state.places;
                break;
              case HomeSearchInitial():
                isFocusedSearchBar = true;
              case HomeSearchSuccess():
                searchPlaces = state.places;
            }
          },
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: isFocusedSearchBar
                    ? const NeverScrollableScrollPhysics()
                    : null,
                child: Column(
                  children: [
                    Stack(children: [
                      buildHomeHeader(),
                      buildHomeOverlay(context),
                      AnimatedContainer(
                        duration: Duration(
                            milliseconds: isFocusedSearchBar ? 500 : 0),
                        margin: EdgeInsets.only(
                            top: isFocusedSearchBar
                                ? AppDimen.screenPadding
                                : 180),
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppDimen.screenPadding),
                        child: Column(
                          children: [
                            const HomeSearchBar(),
                            BlocBuilder<HomeBloc, HomeState>(
                              builder: (context, state) {
                                if (state is HomeSearchInProcess) {
                                  return GridView.builder(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.only(
                                        top: AppDimen.screenPadding),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing:
                                                AppDimen.smallPadding,
                                            mainAxisSpacing:
                                                AppDimen.smallPadding),
                                    itemBuilder: (context, index) =>
                                        Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor:
                                                Colors.grey.shade100,
                                            child: const MySkeletonRectangle(
                                                width: double.infinity,
                                                height: 250)),
                                    itemCount: 16,
                                  );
                                }
                                if (searchPlaces != null) {
                                  return searchPlaces!.isNotEmpty
                                      ? GridView.builder(
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.only(
                                              top: AppDimen.screenPadding),
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  crossAxisSpacing:
                                                      AppDimen.smallPadding,
                                                  mainAxisSpacing:
                                                      AppDimen.smallPadding),
                                          itemBuilder: (context, index) =>
                                              PlaceItem(
                                            place: searchPlaces![index],
                                            likePress: () {
                                              context.read<HomeBloc>().add(
                                                  HomeSearchLikePlacePressed(
                                                      placeId:
                                                          searchPlaces![index]
                                                              .id));
                                            },
                                          ),
                                          itemCount: searchPlaces!.length,
                                        )
                                      : const Center(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: AppDimen.screenPadding,
                                              ),
                                              Text(
                                                "No Result Found",
                                                style: AppStyle
                                                    .mediumTextBlackStyle,
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
                      )
                    ]),
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        if (!isFocusedSearchBar) {
                          return Column(
                            children: [
                              const SizedBox(
                                height: AppDimen.spacing * 2,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppDimen.screenPadding),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        HomeItem(
                                            title: "Hotels",
                                            icColor: AppColor.hotelColor,
                                            icPath: AppPath.icHotels,
                                            callback: () {
                                              Navigator.of(context).pushNamed(
                                                  HotelsPage.routeName);
                                            }),
                                        SizedBox(width: AppDimen.smallPadding,),
                                        HomeItem(
                                            title: "Flights",
                                            icColor: AppColor.flightColor,
                                            icPath: AppPath.icFlights,
                                            callback: () {
                                              Navigator.of(context).pushNamed(
                                                  FlightSearchPage.routeName);
                                            }),
                                        SizedBox(width: AppDimen.smallPadding,),
                                        HomeItem(
                                            title: "All",
                                            icColor: AppColor.allColor,
                                            icPath: AppPath.icAll,
                                            callback: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          MyDeveloping()));
                                            }),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: AppDimen.spacing,
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Popular Destinations",
                                          style: AppStyle.mediumTitleBlackStyle,
                                        ),
                                        SeeAllButton()
                                      ],
                                    ),
                                    BlocBuilder<HomeBloc, HomeState>(
                                      builder: (context, state) {
                                        if (state is HomeLoadInProcess) {
                                          return GridView.custom(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            gridDelegate:
                                                SliverQuiltedGridDelegate(
                                              crossAxisCount: 2,
                                              mainAxisSpacing: 8,
                                              crossAxisSpacing: 8,
                                              repeatPattern:
                                                  QuiltedGridRepeatPattern
                                                      .inverted,
                                              pattern: [
                                                const QuiltedGridTile(2, 1),
                                                const QuiltedGridTile(1, 1),
                                              ],
                                            ),
                                            childrenDelegate:
                                                SliverChildBuilderDelegate(
                                              childCount: 10,
                                              (context, index) =>
                                                  Shimmer.fromColors(
                                                      baseColor:
                                                          Colors.grey.shade300,
                                                      highlightColor:
                                                          Colors.grey.shade100,
                                                      child:
                                                          const MySkeletonRectangle(
                                                              width: 200,
                                                              height: 200)),
                                            ),
                                          );
                                        } else if (state is HomeLoadSuccess &&
                                            popularPlaces != null) {
                                          return GridView.custom(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            gridDelegate:
                                                SliverQuiltedGridDelegate(
                                              crossAxisCount: 2,
                                              mainAxisSpacing:
                                                  AppDimen.smallPadding,
                                              crossAxisSpacing:
                                                  AppDimen.smallPadding,
                                              repeatPattern:
                                                  QuiltedGridRepeatPattern
                                                      .inverted,
                                              pattern: [
                                                const QuiltedGridTile(2, 1),
                                                const QuiltedGridTile(1, 1),
                                              ],
                                            ),
                                            childrenDelegate:
                                                SliverChildBuilderDelegate(
                                              childCount: popularPlaces!.length,
                                              (context, index) => PlaceItem(
                                                place: popularPlaces![index],
                                                likePress: () {
                                                  context.read<HomeBloc>().add(
                                                      HomeLikePlacePressed(
                                                          placeId:
                                                              popularPlaces![
                                                                      index]
                                                                  .id));
                                                },
                                              ),
                                            ),
                                          );
                                        } else {
                                          return const SizedBox();
                                        }
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildHomeOverlay(BuildContext context) {
    if (isFocusedSearchBar) {
      return Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildHomeHeader() {
    if (!isFocusedSearchBar) {
      return const HomeHeader();
    }
    return const SizedBox();
  }
}

class SeeAllButton extends StatefulWidget {
  const SeeAllButton({
    super.key,
  });

  @override
  State<SeeAllButton> createState() => _SeeAllButtonState();
}

class _SeeAllButtonState extends State<SeeAllButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return isPressed == false
            ? TextButton(
                onPressed: () {
                  context.read<HomeBloc>().add(HomeSeeAllPressed());
                  setState(() {
                    isPressed = true;
                  });
                },
                child: Text(
                  "See All",
                  style: AppStyle.normalTextBlackStyle
                      .copyWith(color: AppColor.primaryColor),
                ))
            : TextButton(
                onPressed: () {},
                child: Text("",
                    style: AppStyle.normalTextBlackStyle
                        .copyWith(color: AppColor.primaryColor)));
      },
    );
  }
}
