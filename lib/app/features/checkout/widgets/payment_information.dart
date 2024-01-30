part of checkout;

class PaymentInformation extends StatelessWidget {
  const PaymentInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(child: BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (context, state) {
        if (state.typePayment == TypePayment.miniMarket) {
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
              buildChangeButton()
            ],
          );
        } else if (state.typePayment == TypePayment.bankTransfer) {
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
              buildChangeButton()
            ],
          );
        } else if (state.typePayment == TypePayment.card) {
          return Row(
            children: [
              getCardIcon(CardUtil.getCardTypeFrmNumber(state.card!.number)),
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
                      CardUtil.getCardTypeFrmNumber(state.card!.number)
                          .toJson(),
                      style: AppStyle.mediumTextBlackStyle,
                    ),
                  ],
                ),
              ),
              buildChangeButton()
            ],
          );
        } else {
          return SizedBox();
        }
      },
    ));
  }
}

class buildChangeButton extends StatelessWidget {
  const buildChangeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          context.read<CheckoutBloc>().add(CheckoutGoToPaymentStep());
        },
        child: Text(
          "Change",
          style: AppStyle.normalTextBlackStyle
              .copyWith(color: AppColor.primaryColor),
        ));
  }
}
