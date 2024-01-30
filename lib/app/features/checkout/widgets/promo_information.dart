part of checkout;

class PromoInformation extends StatelessWidget {
  const PromoInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(AppPath.icPromo, width: AppDimen.mediumSize),
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
        BlocSelector<CheckoutBloc, CheckoutState, PromoModel?>(
          selector: (state) {
            return state.promo;
          },
          builder: (context, promo) {
            return promo == null
                ? AddButton(
                    title: "Add Promo Code",
                    callback: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                                value: context.read<CheckoutBloc>(),
                                child: PromoPage(
                                  type: CheckoutType.hotel,
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
                          Text("Code: ${promo.code}"),
                          Text("Discount: ${promo.price * 100}%"),
                        ],
                      ),
                    ),
                    rightChild: Center(
                      child: CachedNetworkImage(
                        imageUrl: promo.image,
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
                                      .read<CheckoutBloc>()
                                      .add(CheckoutRemovePromo());
                                  Navigator.pop(dialogContext);
                                },
                                callbackCancel: () {
                                  Navigator.pop(dialogContext);
                                },
                              ));
                    },
                  );
          },
        )
      ],
    ));
  }
}
