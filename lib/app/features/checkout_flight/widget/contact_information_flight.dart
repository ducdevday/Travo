part of checkout_flight;

class ContactInformationFlight extends StatelessWidget {
  const ContactInformationFlight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(AppPath.icContactFlight,
                width: AppDimen.mediumSize),
            SizedBox(width: AppDimen.spacing),
            Text(
              "Contact Details",
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
              return Column(
                children: [
                  ListView.separated(
                      padding: EdgeInsets.only(bottom: AppDimen.smallPadding),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => ContactItem(
                            guest: state.guest,
                          ),
                      separatorBuilder: (context, index) => Divider(
                            indent: AppDimen.smallPadding,
                            color: AppColor.dividerColor,
                          ),
                      itemCount: state.guest != null ? 1 : 0),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: state.guest == null ? AddButton(
                          title: "Add Contact",
                          callback: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                      value: context.read<CheckoutFlightBloc>(),
                                      child: ContactPage(
                                        type: CheckoutType.flight,
                                      ),
                                    )));
                          }) : SizedBox())
                ],
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

class ContactItem extends StatelessWidget {
  final GuestModel? guest;

  const ContactItem({
    super.key,
    required this.guest,
  });

  @override
  Widget build(BuildContext context) {
    if (guest != null) {
      return Row(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppDimen.smallPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${StringFormatUtil.formatLongString(guest!.name, 10)} | ${guest!.phone}",
                    style: AppStyle.normalTextBlackStyle,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: AppDimen.smallSpacing,
                  ),
                  Text("${guest!.email}"),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                        value: context.read<CheckoutFlightBloc>(),
                        child: ContactPage(
                          guest: guest,
                          type: CheckoutType.flight,
                        ),
                      )));
            },
            icon: const Icon(
              Icons.mode_edit_outline,
              color: AppColor.primaryColor,
              size: AppDimen.smallSize,
            ),
          )
        ],
      );
    } else {
      return SizedBox();
    }
  }
}
