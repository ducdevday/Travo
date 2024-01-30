part of hotel_search;

class HotelSearchPage extends StatelessWidget {
  static const String routeName = '/hotel_search';

  const HotelSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            HotelSearchCubit(hotelRepository: context.read<HotelRepository>()),
        child: Column(
          children: [
            HotelSearchHeader(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(AppDimen.screenPadding),
                child: Column(
                  children: [
                    HotelSearchBar(),
                    BlocBuilder<HotelSearchCubit, HotelSearchState>(
                      builder: (context, state) {
                        if (state is HotelSearchHaveResult) {
                          return Expanded(
                            child: ListView.separated(
                                itemBuilder: (context, index) =>
                                    HotelItem(hotel: state.hotels[index]),
                                separatorBuilder: (context, index) => SizedBox(
                                      height: AppDimen.spacing,
                                    ),
                                itemCount: state.hotels.length),
                          );
                        } else if (state is HotelSearchNoResult) {
                          return Expanded(
                            child: Center(
                              child: Text("No result found",style: AppStyle.mediumTextBlackStyle,),
                            ),
                          );
                        } else if (state is HotelSearchError) {
                          return Center(
                            child: Text("Something went wrong",style: AppStyle.mediumTextBlackStyle,),
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
