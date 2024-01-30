part of checkout;

class ContactInformation extends StatelessWidget {
  final num maxGuest;
  const ContactInformation({Key? key, required this.maxGuest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(AppPath.icContact, width: AppDimen.mediumSize),
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
        BlocSelector<CheckoutBloc, CheckoutState, List<GuestModel>>(
          selector: (state) {
            return state.guest;
          },
          builder: (context, guest) {
            return Column(
              children: [
                ListView.separated(
                    padding: EdgeInsets.only(bottom: AppDimen.smallPadding),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => ContactItem(
                          guest: guest[index],
                          index: index,
                        ),
                    separatorBuilder: (context, index) => Divider(
                          indent: AppDimen.smallPadding,
                          color: AppColor.dividerColor,
                        ),
                    itemCount: guest.length),
                Align(
                    alignment: Alignment.centerLeft,
                    child: AddButton(
                      title: "Add Contact",
                      callback: guest.length < maxGuest
                          ? () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                        value: context.read<CheckoutBloc>(),
                                        child: ContactPage(type: CheckoutType.hotel,),
                                      )));
                            }
                          : (){
                        showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) =>
                                MyAlertDialog(
                                    title: "",
                                    content:
                                    "You can only add max 3 contacts",
                                    callback: () {
                                      Navigator.pop(dialogContext);
                                    }));
                      },
                    ))
              ],
            );
          },
        ),
      ],
    ));
  }
}

class ContactItem extends StatelessWidget {
  final GuestModel guest;
  final int index;

  const ContactItem({
    super.key,
    required this.guest,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          index.toString(),
          style: AppStyle.largeTitleStyle,
        ),
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppDimen.smallPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${guest.name} | ${guest.phone}",
                  style: AppStyle.normalTextBlackStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: AppDimen.smallSpacing,
                ),
                Text("${guest.email}"),
              ],
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                      value: context.read<CheckoutBloc>(),
                      child: ContactPage(
                        guest: guest,
                        type: CheckoutType.hotel,
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
  }
}
