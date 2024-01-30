part of checkout;

class CheckoutHeader extends StatelessWidget {
  const CheckoutHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
            BlocSelector<CheckoutBloc, CheckoutState, CheckoutStep>(
              selector: (state) {
                return state.step;
              },
              builder: (context, step) {
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
                              context.read<CheckoutBloc>().add(
                                  CheckoutChangeStep(
                                      step: CheckoutStep.values[index]));
                            }),
                        separatorBuilder: (context, index) => SizedBox(
                              width: AppDimen.mediumSize,
                              child: Divider(
                                color: Colors.white,
                                indent: AppDimen.spacing,
                                endIndent: AppDimen.spacing,
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
