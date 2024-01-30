part of checkout_flight;

class CheckoutFlightHeader extends StatefulWidget {
  const CheckoutFlightHeader({Key? key}) : super(key: key);

  @override
  State<CheckoutFlightHeader> createState() => _CheckoutFlightHeaderState();
}

class _CheckoutFlightHeaderState extends State<CheckoutFlightHeader> {
  GuestModel? guest;
  PromoModel? promo;
  TypePayment? typePayment;
  CardModel? card;
  SeatModel? seat;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckoutFlightBloc, CheckoutFlightState>(
      listener: (context, state) {
        switch (state) {
          case CheckoutFlightBookingAndReviewStep():
            guest = state.guest;
            promo = state.promo;
            seat = state.seat;
            break;
          case CheckoutFlightPaymentStep():
            typePayment = state.typePayment;
            card = state.card;
        }
      },
      child: Stack(
        children: [
          Image.asset(
            AppPath.imgAppBar,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              const SizedBox(
                height: AppDimen.headerMargin,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimen.screenPadding),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) =>
                                  MyConfirmDialog(
                                    title: "Cancel Checkout",
                                    content:
                                        "If you cancel, every information will be delete",
                                    callbackOK: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    callbackCancel: () {
                                      Navigator.of(context).pop();
                                    },
                                  )).then((value) {
                            if (value != null && value == true) {
                              Navigator.of(context).pop();
                            }
                          });
                        },
                        icon: const Icon(Icons.arrow_back_rounded, size: 20),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Checkout",
                        style: AppStyle.largeHeaderStyle,
                      ),
                    )
                  ],
                ),
              ),
              BlocBuilder<CheckoutFlightBloc, CheckoutFlightState>(
                builder: (context, state) {
                  CheckoutStep step;
                  switch (state) {
                    case CheckoutFlightBookingAndReviewStep():
                      step = CheckoutStep.booking_and_review;
                      break;
                    case CheckoutFlightPaymentStep():
                      step = CheckoutStep.payment;
                      break;
                    case CheckoutFlightConfirmStep():
                      step = CheckoutStep.confirm;
                      break;
                    default:
                      step = CheckoutStep.confirm;
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimen.screenPadding),
                    child: Container(
                      height: 100,
                      child: ListView.separated(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => buildStepItem(
                              numStep: "${index + 1}",
                              title: StringFormatUtil.formatStep(
                                  CheckoutStep.values[index].name),
                              step: CheckoutStep.values[index],
                              currentStep: step,
                              callback: () {
                                if (CheckoutStep.values
                                        .indexOf(CheckoutStep.values[index]) <
                                    CheckoutStep.values.indexOf(step)) {
                                  if (CheckoutStep.values[index] ==
                                      CheckoutStep.booking_and_review) {
                                    context.read<CheckoutFlightBloc>().add(
                                        CheckoutFlightGoToBookingAndReviewStep(
                                            guest: guest,
                                            promo: promo,
                                            seat: seat));
                                  } else if (CheckoutStep.values[index] ==
                                      CheckoutStep.payment) {
                                    context.read<CheckoutFlightBloc>().add(
                                        CheckoutFlightGoToPaymentStep(
                                            typePayment: typePayment,
                                            card: card));
                                  }
                                }
                              }),
                          separatorBuilder: (context, index) => SizedBox(
                                width: AppDimen.smallSize,
                                child: Divider(
                                  color: Colors.white,
                                  indent: AppDimen.smallSpacing,
                                  endIndent: AppDimen.smallSpacing,
                                ),
                              ),
                          itemCount: CheckoutStep.values.length),
                    ),
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildStepItem(
      {required String numStep,
      required String title,
      required CheckoutStep step,
      required CheckoutStep currentStep,
      VoidCallback? callback}) {
    return InkWell(
      onTap: () {
        if (callback != null) {
          callback();
        }
      },
      child: Row(
        children: [
          Container(
            height: 24,
            width: 24,
            margin: EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
              color: step == currentStep
                  ? Colors.white
                  : Colors.white.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                numStep,
                style: step == currentStep
                    ? AppStyle.smallTextWhiteStyle.copyWith(
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.w500)
                    : AppStyle.smallTextWhiteStyle,
              ),
            ),
          ),
          Text(
            title,
            style: step == currentStep
                ? AppStyle.smallTextWhiteStyle
                    .copyWith(fontWeight: FontWeight.w500)
                : AppStyle.smallTextWhiteStyle,
          )
        ],
      ),
    );
  }
}
