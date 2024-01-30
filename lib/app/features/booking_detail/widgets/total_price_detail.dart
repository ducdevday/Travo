part of booking_detail;

class TotalPriceDetail extends StatefulWidget {
  final List<DateTime?> bookingDates;
  final num roomPrice;
  final PromoModel? promo;

  const TotalPriceDetail(
      {Key? key,
      required this.bookingDates,
      required this.roomPrice,
      required this.promo})
      : super(key: key);

  @override
  State<TotalPriceDetail> createState() => _TotalPriceDetailState();
}

class _TotalPriceDetailState extends State<TotalPriceDetail> {
  late final num nights;

  @override
  void initState() {
    super.initState();
    nights = widget.bookingDates[1]!.difference(widget.bookingDates[0]!).inDays;
  }

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$nights night",
                style: AppStyle.normalTextBlackStyle,
              ),
              Text(
                "${StringFormatUtil.formatMoney(nights * widget.roomPrice)}",
                style: AppStyle.normalTextBlackStyle,
              ),
            ],
          ),
          const SizedBox(
            height: AppDimen.spacing,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Taxes and Fees",
                style: AppStyle.normalTextBlackStyle,
              ),
              Text(
                "Free",
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
    if (widget.promo != null) {
      return Column(
        children: [
          const SizedBox(
            height: AppDimen.spacing,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Discount",
                style: AppStyle.normalTextBlackStyle,
              ),
              Text(
                "${StringFormatUtil.formatNumber(widget.promo!.price * 100)}%",
                style: AppStyle.normalTextBlackStyle,
              ),
            ],
          ),
        ],
      );
    }
    return const SizedBox();
  }

  Widget buildTotalItem() {
    final discount = widget.promo != null ? widget.promo!.price : 0;
    return Column(
      children: [
        const SizedBox(
          height: AppDimen.spacing,
        ),
        const DottedLine(
          direction: Axis.horizontal,
          dashLength: 8.0,
          dashColor: AppColor.dottedColor,
        ),
        const SizedBox(
          height: AppDimen.spacing,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Total",
              style: AppStyle.mediumTitleBlackStyle,
            ),
            Text(
              "${StringFormatUtil.formatMoney(nights * widget.roomPrice * (1 - discount))}",
              style: AppStyle.mediumTitleBlackStyle,
            ),
          ],
        ),
      ],
    );
  }
}
