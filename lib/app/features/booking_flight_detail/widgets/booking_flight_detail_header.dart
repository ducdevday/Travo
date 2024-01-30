part of booking_flight_detail;

class BookingFlightDetailHeader extends StatelessWidget {
  final String id;
  final DateTime? createdAt;

  const BookingFlightDetailHeader({
    required this.id,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Column(
              children: [
                Text(
                  "Thank you!",
                  style: AppStyle.largeTitleStyle
                      .copyWith(color: AppColor.primaryColor),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Your booking was succeed",
                  style: AppStyle.normalTextBlackStyle
                      .copyWith(fontWeight: FontWeight.w500),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "ID Booking",
                  style: AppStyle.normalTextBlackStyle
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  id,
                  style: AppStyle.normalTextBlackStyle,
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Date",
                  style: AppStyle.normalTextBlackStyle
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  StringFormatUtil.formattedLongDate(
                      createdAt ?? DateTime.now()),
                  style: AppStyle.normalTextBlackStyle,
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Time",
                  style: AppStyle.normalTextBlackStyle
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  StringFormatUtil.formattedLongTime(
                      createdAt ?? DateTime.now()),
                  style: AppStyle.normalTextBlackStyle,
                )
              ],
            ),
          ],
        ));
  }
}
