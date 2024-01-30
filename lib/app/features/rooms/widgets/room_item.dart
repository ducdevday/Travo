part of rooms;

class RoomItem extends StatelessWidget {
  final RoomModel room;
  final bool isFirstItem;
  final bool showService;
  final Widget bottom;

  const RoomItem(
      {Key? key,
      required this.room,
      this.isFirstItem = false,
      this.showService = true,
      required this.bottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    room.name,
                    style: AppStyle.largeTitleStyle,
                  ),
                  SizedBox(
                    height: AppDimen.spacing,
                  ),
                  Text(
                    "Room size: ${room.maxGuest.toString()} people",
                    style: AppStyle.normalTextBlackStyle,
                  ),
                  SizedBox(
                    height: AppDimen.spacing,
                  ),
                  Text(
                    room.typePrice,
                    style: AppStyle.smallTextBlackStyle,
                  ),
                  SizedBox(
                    height: AppDimen.spacing,
                  ),
                ],
              ),
              Spacer(),
              buildRoomImage(context)
            ],
          ),
          buildRoomServices(),
          SizedBox(
            height: AppDimen.spacing,
          ),
          const DottedLine(
            direction: Axis.horizontal,
            dashLength: 8.0,
            dashColor: AppColor.dottedColor,
          ),
          SizedBox(
            height: AppDimen.spacing,
          ),
          bottom
        ],
      ),
    );
  }

  Widget buildRoomServices() {
    if (showService) {
      return Wrap(
        spacing: 30,
        children: [...room.services.map((e) => ServiceItem(serviceId: e))],
      );
    } else {
      return SizedBox();
    }
  }

  Widget buildRoomImage(BuildContext context) {
    if (isFirstItem && SharedService.getSeenTooltip() == false) {
      return OverlayTooltipItem(
        displayIndex: 0,
        tooltip: (controller) {
          return Padding(
            padding: const EdgeInsets.only(top: AppDimen.spacing),
            child: MyTooltip(
              title: 'Tap image to see in full screen',
              controller: controller,
              okCallBack: () {
                SharedService.setSeenTooltip(true);
              },
            ),
          );
        },
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return ImageFullScreen(imgPath: room.image);
            }));
          },
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: CachedNetworkImage(
                imageUrl: room.image,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                placeholder: (context, url) => MySkeletonRectangle(width:  60, height: 60),
                errorWidget: (_,__,___) => Container(color: AppColor.unLikedColor,child: Icon(Icons.error_outline_rounded, color: Colors.red, size: AppDimen.largeSize,)),
              )),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return ImageFullScreen(imgPath: room.image);
          }));
        },
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: CachedNetworkImage(
              imageUrl: room.image,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              placeholder: (context, url) => MySkeletonRectangle(width:  60, height: 60),
              errorWidget: (_,__,___) => Container(color: AppColor.unLikedColor,child: Icon(Icons.error_outline_rounded, color: Colors.red, size: AppDimen.largeSize,)),
            )),
      );
    }
  }
}
