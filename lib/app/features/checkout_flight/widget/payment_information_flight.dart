part of checkout_flight;

class PaymentInformationFlight extends StatelessWidget {
  final TypePayment typePayment;
  final CardModel? card;

  const PaymentInformationFlight(
      {Key? key, required this.typePayment, required this.card})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(child: buildPaymentInformation(context));
  }

  RenderObjectWidget buildPaymentInformation(BuildContext context) {
    if (typePayment == TypePayment.miniMarket) {
      return Row(
        children: [
          SvgPicture.asset(
            AppPath.icMiniMarket,
            width: AppDimen.mediumSize,
            height: AppDimen.mediumSize,
          ),
          SizedBox(width: AppDimen.spacing),
          Expanded(
            child: Text(
              "Mini Market",
              style: AppStyle.normalTextBlackStyle,
            ),
          ),
          buildChangeButton(context)
        ],
      );
    } else if (typePayment == TypePayment.bankTransfer) {
      return Row(
        children: [
          SvgPicture.asset(
            AppPath.icBankTransfer,
            width: AppDimen.mediumSize,
            height: AppDimen.mediumSize,
          ),
          SizedBox(width: AppDimen.spacing),
          Expanded(
            child: Text(
              "Bank Transfer",
              style: AppStyle.normalTextBlackStyle,
            ),
          ),
          buildChangeButton(context)
        ],
      );
    } else if (typePayment == TypePayment.card) {
      return Row(
        children: [
          getCardIcon(CardUtil.getCardTypeFrmNumber(card!.number)),
          SizedBox(width: AppDimen.spacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Credit / Debit Card",
                  style: AppStyle.normalTextBlackStyle,
                ),
                Text(
                  CardUtil.getCardTypeFrmNumber(card!.number).toJson(),
                  style: AppStyle.mediumTextBlackStyle,
                ),
              ],
            ),
          ),
          buildChangeButton(context)
        ],
      );
    } else {
      return SizedBox();
    }
  }

  TextButton buildChangeButton(BuildContext context) {
    return TextButton(
        onPressed: () {
          context.read<CheckoutFlightBloc>().add(CheckoutFlightGoToPaymentStep(
              typePayment: typePayment, card: card));
        },
        child: Text(
          "Change",
          style: AppStyle.normalTextBlackStyle
              .copyWith(color: AppColor.primaryColor),
        ));
  }
}
