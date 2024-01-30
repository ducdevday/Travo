part of rooms;

class RoomItemSelect extends StatelessWidget {
  final RoomModel room;
  final bool isFirstItem;

  const RoomItemSelect(
      {super.key, required this.room, required this.isFirstItem});

  @override
  Widget build(BuildContext context) {
    return RoomItem(
      room: room,
      isFirstItem: isFirstItem,
      bottom: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "${StringFormatUtil.formatMoney(room.price)}",
              style: AppStyle.mediumHeaderStyle,
            ),
            SizedBox(
              height: AppDimen.spacing,
            ),
            Text(
              "/night",
              style: AppStyle.smallTextBlackStyle.copyWith(fontSize: 10),
            )
          ]),
          MyPrimaryButton(
            width: 150,
            text: "Choose",
            callback: () {
              Navigator.of(context)
                  .pushNamed(CheckoutPage.routeName, arguments: room);
            },
          )
        ],
      ),
    );
  }
}
