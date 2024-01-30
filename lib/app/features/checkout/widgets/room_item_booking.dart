part of checkout;

class RoomItemBooking extends StatelessWidget {
  final RoomModel room;

  const RoomItemBooking(
      {super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return RoomItem(
        room: room,
        bottom: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text(
                    "${StringFormatUtil.formatMoney(room.price)}",
                    style: AppStyle.mediumHeaderStyle,
                  ),
                  Text(
                    "/night",
                    style: AppStyle.smallTextBlackStyle.copyWith(fontSize: 10),
                  )
                ]),
            Text(
              "1 room",
              style: AppStyle.normalTextBlackStyle,
            )
          ],
        ));
  }
}
