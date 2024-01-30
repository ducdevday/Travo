part of favourite;

class FavouritePage extends StatefulWidget {
  static const int page = 1;
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> with AutomaticKeepAliveClientMixin<FavouritePage>{
  List<PlaceModel>? places;
  List<HotelModel>? hotels;
  FavouriteType? selectedType;
  late FavouriteCubit _cubit;
  int pageHotel = 0;
  int size = 5;
  late final ScrollController _scrollHotelController;
  late bool isLoadingHotelMore;
  late bool cannotLoadHotelMore;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _cubit = FavouriteCubit(
        placeRepository: context.read<PlaceRepository>(),
        hotelRepository: context.read<HotelRepository>())
      ..loadFavourites(page: 0, size: size);

    _scrollHotelController = ScrollController();
    _scrollHotelController.addListener(_scrollHotelListener);
  }

  void _scrollHotelListener() {
    if (isLoadingHotelMore || cannotLoadHotelMore) return;
    if (_scrollHotelController.position.pixels ==
        _scrollHotelController.position.maxScrollExtent) {
      pageHotel = pageHotel + 1;
      _cubit.loadMoreHotelFavourites(page: pageHotel, size: size);
    }
  }

  void handleLikeHotelPressed(BuildContext context, HotelModel hotel) {
    if (hotel.isLiked == true) {
      showDialog(
          context: context,
          builder: (BuildContext dialogContext) => MyConfirmDialog(
                title: "Confirm unlike",
                content:
                    "Are you sure to remove this hotel from favourite list",
                callbackOK: () {
                  context.read<FavouriteCubit>().likeHotelPressed(hotel.id!);
                  Navigator.of(context).pop(true);
                },
                callbackCancel: () {
                  Navigator.of(context).pop();
                },
              ));
    }
  }

  void handleLikePlacePressed(BuildContext context, PlaceModel place) {
    if (place.isLiked == true) {
      showDialog(
          context: context,
          builder: (BuildContext dialogContext) => MyConfirmDialog(
                title: "Confirm unlike",
                content:
                    "Are you sure to remove this destination from favourite list",
                callbackOK: () {
                  context.read<FavouriteCubit>().likePlacePressed(place.id);
                  Navigator.of(context).pop(true);
                },
                callbackCancel: () {
                  Navigator.of(context).pop();
                },
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          const DefaultHeader(
            title: "Favourite",
            showBackButton: false,
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimen.screenPadding),
            child: BlocProvider(
              create: (context) => _cubit,
              child: Column(
                children: [
                  BlocConsumer<FavouriteCubit, FavouriteState>(
                    listener: (context, state) {
                      if (state is FavouriteLoadSuccess) {
                        places = state.places;
                        hotels = state.hotels;
                        selectedType = state.type;
                        isLoadingHotelMore = state.isLoadingHotelMore;
                        cannotLoadHotelMore = state.cannotLoadHotelMore;
                      }
                    },
                    builder: (context, state) {
                      return Wrap(
                          direction: Axis.horizontal,
                          spacing: 4,
                          children: FavouriteType.values
                              .map((type) => FilterChip(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: AppDimen.spacing,
                                      vertical: 0),
                                  showCheckmark: false,
                                  selectedColor: AppColor.selectedDayColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppDimen.mediumRadius),
                                    side: BorderSide(
                                      color: type == selectedType
                                          ? AppColor.selectedDayColor
                                          : AppColor.secondaryColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  backgroundColor: type == selectedType
                                      ? AppColor.selectedDayColor
                                      : AppColor.secondaryColor,
                                  label: Text(
                                    type.toJson(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: type == selectedType
                                            ? Colors.white
                                            : AppColor.primaryColor),
                                  ),
                                  color: MaterialStateProperty.all(
                                      type == selectedType
                                          ? AppColor.selectedDayColor
                                          : AppColor.secondaryColor),
                                  selected: type == selectedType,
                                  onSelected: (bool selected) {
                                    if (selected) {
                                      context
                                          .read<FavouriteCubit>()
                                          .chooseFavouriteType(type);
                                    }
                                  }))
                              .toList());
                    },
                  ),
                  Expanded(
                    child: BlocBuilder<FavouriteCubit, FavouriteState>(
                      builder: (context, state) {
                        if (state is FavouriteLoadInProcess) {
                          return GridView.builder(
                            padding: EdgeInsets.symmetric(
                                vertical: AppDimen.spacing),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: AppDimen.smallPadding,
                                    mainAxisSpacing: AppDimen.smallPadding),
                            itemBuilder: (context, index) => Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: const MySkeletonRectangle(
                                    width: double.infinity, height: 250)),
                            itemCount: 8,
                          );
                        }
                        if (state is FavouriteLoadSuccess) {
                          if (selectedType == FavouriteType.Place) {
                            return places!.isNotEmpty
                                ? GridView.builder(
                                    padding: EdgeInsets.symmetric(
                                        vertical: AppDimen.spacing),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing:
                                                AppDimen.smallPadding,
                                            mainAxisSpacing:
                                                AppDimen.smallPadding),
                                    itemBuilder: (context, index) => PlaceItem(
                                      place: places![index],
                                      likePress: () {
                                        handleLikePlacePressed(
                                            context, places![index]);
                                      },
                                    ),
                                    itemCount: places!.length,
                                  )
                                : const Center(
                                    child: Text(
                                      "Empty Liked Places",
                                      style: AppStyle.mediumTextBlackStyle,
                                    ),
                                  );
                          } else if (selectedType == FavouriteType.Hotel) {
                            return hotels!.isNotEmpty
                                ? ListView.separated(
                                    padding: EdgeInsets.symmetric(
                                        vertical: AppDimen.spacing),
                                    controller: _scrollHotelController,
                                    itemBuilder: (context, index) => index <
                                            hotels!.length
                                        ? HotelItem(
                                            hotel: hotels![index],
                                            likePress: () {
                                              handleLikeHotelPressed(
                                                  context, hotels![index]);
                                            },
                                            reload: () {
                                              pageHotel = 0;
                                              context
                                                  .read<FavouriteCubit>()
                                                  .loadFavourites(
                                                      page: pageHotel,
                                                      size: size);
                                            },
                                          )
                                        : const Padding(
                                            padding: EdgeInsets.only(
                                                top: AppDimen.spacing),
                                            child: CupertinoActivityIndicator(),
                                          ),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                          height: AppDimen.spacing,
                                        ),
                                    itemCount: isLoadingHotelMore
                                        ? hotels!.length + 1
                                        : hotels!.length)
                                : const Center(
                                    child: Text(
                                      "Empty Liked Hotels",
                                      style: AppStyle.mediumTextBlackStyle,
                                    ),
                                  );
                          }
                          return const SizedBox();
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
