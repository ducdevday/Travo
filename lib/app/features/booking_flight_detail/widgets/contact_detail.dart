part of booking_flight_detail;

class ContactDetail extends StatelessWidget {
  final GuestModel guest;

  const ContactDetail({Key? key, required this.guest}) : super(key: key);

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
          Align(
            alignment: Alignment.centerLeft,
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
      ),
    );
  }
}
