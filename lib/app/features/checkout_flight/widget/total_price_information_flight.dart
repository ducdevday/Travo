part of checkout_flight;

class TotalPriceInformationFlight extends StatelessWidget {
  final num price;
  final PromoModel? promo;

  const TotalPriceInformationFlight(
      {Key? key, required this.price, required this.promo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "1 Passenger",
                style: AppStyle.normalTextBlackStyle,
              ),
              Text(
                "${StringFormatUtil.formatMoney(price)}",
                style: AppStyle.normalTextBlackStyle,
              ),
            ],
          ),
          SizedBox(
            height: AppDimen.spacing,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Insurance",
                style: AppStyle.normalTextBlackStyle,
              ),
              Text(
                "-",
                style: AppStyle.normalTextBlackStyle,
              ),
            ],
          ),
          buildDiscountItem(),
          buildTotalItem()
        ],
      ),
    );
  }

  Widget buildDiscountItem() {
    if (promo != null) {
      return Column(
        children: [
          SizedBox(
            height: AppDimen.spacing,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Discount",
                style: AppStyle.normalTextBlackStyle,
              ),
              Text(
                "${StringFormatUtil.formatNumber(promo!.price * 100)}%",
                style: AppStyle.normalTextBlackStyle,
              ),
            ],
          ),
        ],
      );
    }
    return SizedBox();
  }

  Widget buildTotalItem() {
    final discount = promo != null ? promo!.price : 0;
    return Column(
      children: [
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
            Text(
              "Total",
              style: AppStyle.mediumTitleBlackStyle,
            ),
            Text(
              "${StringFormatUtil.formatMoney(price * (1 - discount))}",
              style: AppStyle.mediumTitleBlackStyle,
            ),
          ],
        ),
      ],
    );
  }
}
