part of booking_detail;

class PaymentDetail extends StatelessWidget {
  final CardModel? card;
  final TypePayment typePayment;

  const PaymentDetail({Key? key, required this.card, required this.typePayment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (typePayment == TypePayment.miniMarket) {
      return MyCard(
        child: Row(
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
          ],
        ),
      );
    } else if (typePayment == TypePayment.bankTransfer) {
      return MyCard(
        child: Row(
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
          ],
        ),
      );
    } else if (typePayment == TypePayment.card) {
      return MyCard(
        child: Row(
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
          ],
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
