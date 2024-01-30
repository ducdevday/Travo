part of home;

class PlaceItem extends StatelessWidget {
  final PlaceModel place;
  final VoidCallback likePress;
  const PlaceItem({Key? key, required this.place, required this.likePress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: CachedNetworkImage(
              imageUrl: place.image,
              fit: BoxFit.cover,
            )),
        Positioned(
          top: 4,
          right: 4,
          child: IconButton(
            icon: Icon(
              Icons.favorite_rounded,
              color: place.isLiked ? AppColor.likedColor: Colors.white,
            ),
            onPressed: () {
              likePress();
            },
          ),
        ),
        Positioned(
          bottom: 4,
          left: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                place.name,
                style: AppStyle.normalTextWhiteStyle.copyWith(shadows: [
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 3.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ]),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: AppColor.starColor,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      place.rating.toString(),
                      style:
                          AppStyle.smallTextBlackStyle.copyWith(fontSize: 10),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
