part of hotel_detail;

class MoreItem extends StatefulWidget {
  final String hotelId;

  const MoreItem({Key? key, required this.hotelId}) : super(key: key);

  @override
  State<MoreItem> createState() => _MoreItemState();
}

class _MoreItemState extends State<MoreItem> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return isClicked == false ?  GestureDetector(
      onTap: () {
        context.read<HotelDetailBloc>()
            .add(HotelDetailMoreServicePressed(hotelId: widget.hotelId));
        setState(() {
          isClicked = true;
        });
      },
      child: Column(
        children: [
          SvgPicture.asset(
            AppPath.icMore,
            width: AppDimen.mediumSize,
            height: AppDimen.mediumSize,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "More",
            textAlign: TextAlign.center,
            style: AppStyle.smallTextBlackStyle.copyWith(fontSize: 10),
          )
        ],
      ),
    ) : SizedBox();
  }
}
