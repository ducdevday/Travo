part of checkout;

class TotalPriceInformation extends StatelessWidget {
  final num roomPrice;

  const TotalPriceInformation({Key? key, required this.roomPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(child: BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${state.nights} night",
                  style: AppStyle.normalTextBlackStyle,
                ),
                Text(
                  "${StringFormatUtil.formatMoney(state.nights * roomPrice)}",
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
                  "Taxes and Fees",
                  style: AppStyle.normalTextBlackStyle,
                ),
                Text(
                  "Free",
                  style: AppStyle.normalTextBlackStyle,
                ),
              ],
            ),
            buildDiscountItem(state),
            buildTotalItem(state)
          ],
        );
      },
    ));
  }

  Widget buildDiscountItem(CheckoutState state) {
    if (state.promo != null) {
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
                "${StringFormatUtil.formatNumber(state.promo!.price * 100)}%",
                style: AppStyle.normalTextBlackStyle,
              ),
            ],
          ),
        ],
      );
    }
    return SizedBox();
  }

  Widget buildTotalItem(CheckoutState state) {
    final discount = state.promo != null ? state.promo!.price : 0;
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
              "${StringFormatUtil.formatMoney(state.nights * roomPrice * (1 - discount))}",
              style: AppStyle.mediumTitleBlackStyle,
            ),
          ],
        ),
      ],
    );
  }
}
