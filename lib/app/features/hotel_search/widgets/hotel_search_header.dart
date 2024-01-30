part of hotel_search;

class HotelSearchHeader extends StatelessWidget {
  const HotelSearchHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AppPath.imgAppBar,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Column(
          children: [
            const SizedBox(
              height: AppDimen.headerMargin,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimen.screenPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_rounded, size: 20),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                    ),
                  ),
                  Text(
                    "Search Hotel",
                    style: AppStyle.largeHeaderStyle,
                  ),
                  SizedBox(width: 20,)
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
