part of checkout;

class PaymentStep extends StatelessWidget {
  const PaymentStep({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (context, state) {
        return Expanded(
          child: ListView(
            padding: const EdgeInsets.only(
                left: AppDimen.screenPadding,
                right: AppDimen.screenPadding,
                bottom: AppDimen.smallPadding),
            children: [
              MyCard(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppPath.icMiniMarket,
                        width: AppDimen.mediumSize,
                        height: AppDimen.mediumSize,
                      ),
                      const SizedBox(width: AppDimen.spacing),
                      const Expanded(
                        child: Text(
                          "Mini Market",
                          style: AppStyle.normalTextBlackStyle,
                        ),
                      ),
                      MyRadio(
                          shape: BoxShape.circle,
                          value: TypePayment.miniMarket,
                          groupValue: state.typePayment,
                          onChanged: (TypePayment? value) {
                            context.read<CheckoutBloc>().add(
                                const CheckoutChooseTypePayment(
                                    type: TypePayment.miniMarket));
                          })
                    ],
                  )),
              const SizedBox(
                height: AppDimen.smallPadding,
              ),
              MyCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppPath.icCredit,
                            width: AppDimen.mediumSize,
                            height: AppDimen.mediumSize,
                          ),
                          const SizedBox(width: AppDimen.spacing),
                          const Expanded(
                            child: Text(
                              "Credit / Debit Card",
                              style: AppStyle.normalTextBlackStyle,
                            ),
                          ),
                          MyRadio(
                              shape: BoxShape.circle,
                              value: TypePayment.card,
                              groupValue: state.typePayment,
                              onChanged: (TypePayment? value) {
                                context.read<CheckoutBloc>().add(
                                    const CheckoutChooseTypePayment(
                                        type: TypePayment.card));
                              })
                        ],
                      ),
                      buildCardButton(context, state),
                    ],
                  )),
              const SizedBox(
                height: AppDimen.smallPadding,
              ),
              MyCard(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppPath.icBankTransfer,
                        width: AppDimen.mediumSize,
                        height: AppDimen.mediumSize,
                      ),
                      const SizedBox(width: AppDimen.spacing),
                      const Expanded(
                        child: Text(
                          "Bank Transfer",
                          style: AppStyle.normalTextBlackStyle,
                        ),
                      ),
                      MyRadio(
                          shape: BoxShape.circle,
                          value: TypePayment.bankTransfer,
                          groupValue: state.typePayment,
                          onChanged: (TypePayment? value) {
                            context.read<CheckoutBloc>().add(
                                const CheckoutChooseTypePayment(
                                    type: TypePayment.bankTransfer));
                          })
                    ],
                  )),
              const SizedBox(
                height: AppDimen.smallPadding,
              ),
              const GoToConfirmButton(
                type: CheckoutType.hotel,
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildCardButton(
      BuildContext context,
      CheckoutState state,
      ) {
    if (state.typePayment == TypePayment.card) {
      if (state.card == null) {
        return Column(
          children: [
            SizedBox(height: AppDimen.spacing,),
            AddButton(
                title: "Add Card",
                callback: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<CheckoutBloc>(),
                        child: const AddCardPage(
                          type: CheckoutType.hotel,
                        ),
                      )));
                }),
          ],
        );
      }
      return Column(
        children: [
          SizedBox(height: AppDimen.spacing,),
          CardItem(
            card: state.card!,
            type: CheckoutType.hotel,
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
