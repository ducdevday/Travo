part of promo;

class PromoPage extends StatefulWidget {
  final CheckoutType type;

  const PromoPage({Key? key, required this.type}) : super(key: key);

  @override
  State<PromoPage> createState() => _PromoPageState();
}

class _PromoPageState extends State<PromoPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            PromoCubit(promoRepository: context.read<PromoRepository>()),
        child: BlocListener<PromoCubit, PromoState>(
          listener: (context, state) {
            if (state is PromoCheckInProcess) {
              EasyLoading.show(maskType: EasyLoadingMaskType.black);
            } else if (state is PromoCheckHaveResult) {
              EasyLoading.dismiss();
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Added Promo!")));
              if (widget.type == CheckoutType.hotel) {
                context
                    .read<CheckoutBloc>()
                    .add(CheckoutAddPromo(promo: state.promo));
              } else {
                context
                    .read<CheckoutFlightBloc>()
                    .add(CheckoutFlightAddPromo(promo: state.promo));
              }
              Navigator.of(context).pop();
            } else if (state is PromoCheckFailure) {
              EasyLoading.dismiss();
              showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) => MyAlertDialog(
                      title: "",
                      content: "Promo Not Found",
                      callback: () {
                        Navigator.pop(dialogContext);
                      }));
            }
          },
          child: Column(
            children: [
              const PromoHeader(),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(AppDimen.screenPadding),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(AppDimen.mediumRadius))),
                            child: Row(
                              children: [
                                Expanded(
                                    child: TextField(
                                  textInputAction: TextInputAction.search,
                                  style: AppStyle.normalTextBlackStyle,
                                  controller: _controller,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(16),
                                    border: InputBorder.none,
                                    hintText: "Coupon Code",
                                  ),
                                )),
                                BlocBuilder<PromoCubit, PromoState>(
                                  builder: (context, state) {
                                    return MySecondaryButton(
                                      text: "Add Code",
                                      callback: () {
                                        context
                                            .read<PromoCubit>()
                                            .checkPromo(_controller.text);
                                      },
                                      radius: AppDimen.mediumRadius,
                                      width: 130,
                                      height: 40,
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: AppDimen.smallPadding,
                          ),
                          // MyPrimaryButton(text: "Done", callback: () {
                          //
                          // }, width: double.maxFinite,)
                        ],
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
