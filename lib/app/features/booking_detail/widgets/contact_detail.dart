part of booking_detail;

class ContactDetail extends StatelessWidget {
  final List<GuestModel> guests;

  const ContactDetail({Key? key, required this.guests}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(AppPath.icContact, width: AppDimen.mediumSize),
              const SizedBox(width: AppDimen.spacing),
              const Text(
                "Contact Details",
              ),
            ],
          ),
          const SizedBox(
            height: AppDimen.smallPadding,
          ),
          ListView.separated(
              padding: EdgeInsets.only(bottom: AppDimen.smallPadding),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => ContactItem(
                    guest: guests[index],
                    index: index,
                  ),
              separatorBuilder: (context, index) => Divider(
                    indent: AppDimen.smallPadding,
                    color: AppColor.dividerColor,
                  ),
              itemCount: guests.length),
        ],
      ),
    );
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
      ],
    );
  }
}
