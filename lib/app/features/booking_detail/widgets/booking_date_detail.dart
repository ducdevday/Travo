part of booking_detail;

class BookingDateDetail extends StatelessWidget {
  final List<DateTime?> bookingDates;

  const BookingDateDetail({Key? key, required this.bookingDates})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Booking Date",
            style: AppStyle.normalTextBlackStyle,
          ),
          SizedBox(
            height: AppDimen.smallPadding,
          ),
          BookingDateItem(
            bookingDates: bookingDates,
          )
        ],
      ),
    );
  }
}

class BookingDateItem extends StatelessWidget {
  final List<DateTime?> bookingDates;

  const BookingDateItem({super.key, required this.bookingDates});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(AppPath.icCheckIn, width: AppDimen.mediumSize),
            SizedBox(width: AppDimen.spacing),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Check-in",
                  style: AppStyle.smallTextBlackStyle
                      .copyWith(color: AppColor.headingColor),
                ),
                SizedBox(height: AppDimen.smallSpacing),
                Text(
                  StringFormatUtil.formatShortDate(bookingDates[0]!),
                  style: AppStyle.normalTextBlackStyle,
                ),
              ],
            )
          ],
        ),
        Row(
          children: [
            SvgPicture.asset(AppPath.icCheckOut, width: AppDimen.mediumSize),
            SizedBox(width: AppDimen.spacing),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Check-out",
                  style: AppStyle.smallTextBlackStyle
                      .copyWith(color: AppColor.headingColor),
                ),
                SizedBox(height: AppDimen.smallSpacing),
                Text(
                  StringFormatUtil.formatShortDate(bookingDates[1]!),
                  style: AppStyle.normalTextBlackStyle,
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
