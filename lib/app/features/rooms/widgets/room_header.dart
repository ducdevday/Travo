part of rooms;

class RoomsHeader extends StatelessWidget {
  const RoomsHeader({
    super.key,
  });

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
                    "Select Room",
                    style: AppStyle.largeHeaderStyle,
                  ),
                  SizedBox(
                    width: 20,
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
