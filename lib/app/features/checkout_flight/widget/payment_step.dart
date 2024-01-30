part of checkout_flight;

class PaymentStep extends StatelessWidget {
  final TypePayment? typePayment;
  final CardModel? card;

  const PaymentStep({
    super.key,
    required this.typePayment,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckoutFlightBloc, CheckoutFlightState>(
      listener: (context, state) {
        if (state is CheckoutFlightPaymentStep) {
          print("listener CheckoutFlightPaymentStep");
        }
      },
      builder: (context, state) {
        if (state is CheckoutFlightPaymentStep) {
          return Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppDimen.screenPadding),
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
                            groupValue: typePayment,
                            onChanged: (TypePayment? value) {
                              context.read<CheckoutFlightBloc>().add(
                                  const CheckoutFlightChooseTypePayment(
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
                                groupValue: typePayment,
                                onChanged: (TypePayment? value) {
                                  context.read<CheckoutFlightBloc>().add(
                                      const CheckoutFlightChooseTypePayment(
                                          type: TypePayment.card));
                                })
                          ],
                        ),
                        buildCardButton(context, typePayment, card),
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
                            groupValue: typePayment,
                            onChanged: (TypePayment? value) {
                              context.read<CheckoutFlightBloc>().add(
                                  const CheckoutFlightChooseTypePayment(
                                      type: TypePayment.bankTransfer));
                            })
                      ],
                    )),
                const SizedBox(
                  height: AppDimen.smallPadding,
                ),
                const GoToConfirmButton(
                  type: CheckoutType.flight,
                )
              ],
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

  Widget buildCardButton(
      BuildContext context, TypePayment? typePayment, CardModel? card) {
    if (typePayment == TypePayment.card) {
      if (card == null) {
        return Column(
          children: [
            SizedBox(height: AppDimen.spacing,),
            AddButton(
                title: "Add Card",
                callback: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<CheckoutFlightBloc>(),
                        child: const AddCardPage(
                          type: CheckoutType.flight,
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
            card: card,
            type: CheckoutType.flight,
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
