part of hotels;

class HotelItem extends StatelessWidget {
  final HotelModel hotel;
  final VoidCallback? likePress;
  final VoidCallback? reload;
  const HotelItem({Key? key, required this.hotel, this.likePress, this.reload})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12)),
                      child: CachedNetworkImage(
                        imageUrl: hotel.image!,
                        fit: BoxFit.cover,
                        height: 100,
                        width: double.infinity,
                        placeholder: (context, url) => MySkeletonRectangle(width:  double.infinity, height: 100),
                        errorWidget: (_,__,___) => Container(color: AppColor.unLikedColor,child: Icon(Icons.error_outline_rounded, color: Colors.red, size: AppDimen.largeSize,)),
                      ),
                    ),
                    buildLikeButton()
                  ],
                ),
              ),
              SizedBox(
                width: AppDimen.screenPadding,
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(AppDimen.screenPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotel.name!,
                  style: AppStyle.largeTitleStyle,
                ),
                SizedBox(
                  height: AppDimen.spacing,
                ),
                Row(
                  children: [
                    SvgPicture.asset(AppPath.icLocation),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      hotel.location!,
                      style: AppStyle.normalTextBlackStyle,
                    )
                  ],
                ),
                SizedBox(
                  height: AppDimen.spacing,
                ),
                Row(
                  children: [
                    SvgPicture.asset(AppPath.icStar),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      hotel.rating.toString(),
                      style: AppStyle.normalTextBlackStyle,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      "(${hotel.totalReview})",
                      style: AppStyle.normalTextBlackStyle
                          .copyWith(color: AppColor.textGreyColor),
                    )
                  ],
                ),
                SizedBox(
                  height: AppDimen.spacing,
                ),
                const DottedLine(
                  direction: Axis.horizontal,
                  dashLength: 8.0,
                  dashColor: AppColor.dottedColor,
                ),
                SizedBox(
                  height: AppDimen.spacing,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${StringFormatUtil.formatMoney(hotel.price)}",
                            style: AppStyle.mediumHeaderStyle,
                          ),
                          SizedBox(
                            height: AppDimen.spacing,
                          ),
                          Text(
                            "/night",
                            style: AppStyle.smallTextBlackStyle
                                .copyWith(fontSize: 10),
                          )
                        ]),
                    MyPrimaryButton(
                      width: 150,
                      text: "Book a room",
                      callback: () {
                        Navigator.of(context)
                            .pushNamed(HotelDetailPage.routeName,
                                arguments: hotel)
                            .then((isChangeLiked) {
                          if (isChangeLiked != null && isChangeLiked as bool) {
                            if(reload != null){
                              reload!();
                            }
                          }
                        });
                      },
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildLikeButton() {
    if (likePress != null) {
      return Positioned(
        right: 0,
        child: IconButton(
            onPressed: () {
              likePress!();
            },
            icon: Icon(
              Icons.favorite_rounded,
              color: hotel.isLiked! ? AppColor.likedColor : Colors.white,
            )),
      );
    }
    return SizedBox();
  }
}
