part of checkout_flight;

class PromoInformationFlight extends StatelessWidget {
  const PromoInformationFlight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(AppPath.icPromoFlight, width: AppDimen.mediumSize),
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
        BlocBuilder<CheckoutFlightBloc, CheckoutFlightState>(
          builder: (context, state) {
            if (state is CheckoutFlightBookingAndReviewStep) {
              return state.promo == null
                  ? AddButton(
                      title: "Add Promo Code",
                      callback: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                                  value: context.read<CheckoutFlightBloc>(),
                                  child: PromoPage(
                                    type: CheckoutType.flight,
                                  ),
                                )));
                      })
                  : TicketMaterial(
                      radiusBorder: AppDimen.smallRadius,
                      height: 70,
                      colorBackground: Colors.white,
                      leftChild: Padding(
                        padding: const EdgeInsets.all(AppDimen.spacing),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Code: ${state.promo!.code}"),
                            Text("Discount: ${state.promo!.price * 100}%"),
                          ],
                        ),
                      ),
                      rightChild: Center(
                        child: CachedNetworkImage(
                          imageUrl: state.promo!.image,
                          width: AppDimen.largeSize,
                          height: AppDimen.largeSize,
                          placeholder: (context, url) => MySkeletonRectangle(
                              width: AppDimen.largeSize,
                              height: AppDimen.largeSize),
                          errorWidget: (_, __, ___) => Container(
                              color: AppColor.unLikedColor,
                              child: Icon(
                                Icons.error_outline_rounded,
                                color: Colors.red,
                                size: AppDimen.largeSize,
                              )),
                        ),
                      ),
                      tapHandler: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) =>
                                MyConfirmDialog(
                                  title: "Remove Promo",
                                  content: "Do you want to remove this promo",
                                  callbackOK: () {
                                    context
                                        .read<CheckoutFlightBloc>()
                                        .add(CheckoutFlightRemovePromo());
                                    Navigator.pop(dialogContext);
                                  },
                                  callbackCancel: () {
                                    Navigator.pop(dialogContext);
                                  },
                                ));
                      },
                    );
            } else {
              return SizedBox();
            }
          },
        )
      ],
    ));
  }
}
