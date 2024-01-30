part of hotels;

class HotelsPage extends StatefulWidget {
  static const String routeName = '/hotels';

  const HotelsPage({Key? key}) : super(key: key);

  @override
  State<HotelsPage> createState() => _HotelsPageState();
}

class _HotelsPageState extends State<HotelsPage> {
  List<HotelModel>? hotels;
  late final HotelsBloc _bloc;
  int page = 0;
  int size = 5;
  late final ScrollController _scrollController;
  late bool isLoadingMore;
  late bool cannotLoadMore;

  @override
  void initState() {
    super.initState();
    _bloc = HotelsBloc(hotelRepository: context.read<HotelRepository>())
      ..add(HotelsLoadAll(page: page, size: size));
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (isLoadingMore || cannotLoadMore) return;
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      page = page + 1;
      _bloc.add(HotelsLoadMore(page: page, size: size));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<HotelsBloc, HotelsState>(
          listener: (context, state) {
            if (state is HotelsLoadSuccess) {
              hotels = state.hotels;
              isLoadingMore = state.isLoadingMore;
              cannotLoadMore = state.cannotLoadMore;
            }
          },
          child: Stack(
            children: [
              HotelsHeader(
                size: size,
              ),
              BlocBuilder<HotelsBloc, HotelsState>(
                builder: (context, state) {
                  switch (state) {
                    case HotelsLoadInProcess():
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
                                    bottom: 80),
                                itemBuilder: (context, index) =>
                                    Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: const MySkeletonRectangle(
                                            width: 200, height: 300)),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: AppDimen.spacing,
                                    ),
                                itemCount: 8),
                          ),
                        ],
                      );
                    case HotelsLoadSuccess():
                      if(hotels!.isEmpty) {
                        return const Center(
                          child: Text(
                            "No Results Found",
                            style: AppStyle.mediumTextBlackStyle,
                          ),
                        );
                      }
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
                                    bottom: 80),
                                controller: _scrollController,
                                itemBuilder: (context, index) =>
                                    index < hotels!.length
                                        ? HotelItem(
                                            hotel: hotels![index],
                                            likePress: () {
                                              _bloc.add(HotelsLikePressed(
                                                  hotelId: hotels![index].id!));
                                            },
                                            reload: () {
                                              page = 0;
                                              _bloc.add(HotelsLoadAll(
                                                  page: page, size: size));
                                            },
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                top: AppDimen.spacing),
                                            child:
                                                const CupertinoActivityIndicator(),
                                          ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: AppDimen.spacing,
                                    ),
                                itemCount: isLoadingMore
                                    ? hotels!.length + 1
                                    : hotels!.length),
                          ),
                        ],
                      );
                    default:
                      return const SizedBox();
                  }
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(HotelSearchPage.routeName);
        },
        foregroundColor: Colors.black,
        backgroundColor: AppColor.secondaryColor,
        child: const Icon(Icons.search_rounded),
      ),
    );
  }
}
