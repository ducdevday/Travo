part of booking_detail;

class PromoDetail extends StatelessWidget {
  final PromoModel? promo;

  const PromoDetail({Key? key, required this.promo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return promo != null
        ? MyCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(AppPath.icPromo,
                        width: AppDimen.mediumSize),
                    SizedBox(width: AppDimen.spacing),
                    Text(
                      "Promo Code",
                      style: AppStyle.normalTextBlackStyle,
                    ),
                  ],
                ),
                SizedBox(
                  height: AppDimen.smallPadding,
                ),
                TicketMaterial(
                  useAnimationScaleOnTap: false,
                  radiusBorder: AppDimen.smallRadius,
                  height: 70,
                  colorBackground: Colors.white,
                  leftChild: Padding(
                    padding: const EdgeInsets.all(AppDimen.spacing),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Code: ${promo!.code}"),
                        Text("Discount: ${promo!.price * 100}%"),
                      ],
                    ),
                  ),
                  rightChild: Center(
                    child: CachedNetworkImage(
                      imageUrl: promo!.image,
                      width: AppDimen.largeSize,
                      height: AppDimen.largeSize,
                      placeholder: (context, url) => MySkeletonRectangle(
                          width: AppDimen.largeSize, height: AppDimen.largeSize),
                      errorWidget: (_, __, ___) => Container(
                          color: AppColor.unLikedColor,
                          child: Icon(
                            Icons.error_outline_rounded,
                            color: Colors.red,
                            size: AppDimen.largeSize,
                          )),
                    ),
                  ),
                )
              ],
            ),
          )
        : SizedBox();
  }
}
