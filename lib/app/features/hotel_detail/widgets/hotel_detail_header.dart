part of hotel_detail;

class HotelDetailHeader extends StatelessWidget {
  const HotelDetailHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelDetailBloc, HotelDetailState>(
      builder: (context, state) {
        if (state is HotelDetailLoadSuccess) {
          return Column(
            children: [
              const SizedBox(
                height: AppDimen.headerMargin,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimen.screenPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop(state.isChangeLiked);
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
                    IconButton(
                      onPressed: () {
                        context.read<HotelDetailBloc>().add(
                            HotelDetailLikePressed(hotelId: state.hotel.id!));
                      },
                      icon: Icon(
                        Icons.favorite_rounded,
                        color: state.hotel.isLiked!
                            ? AppColor.likedColor
                            : AppColor.unLikedColor,
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
              ),
            ],
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
