part of sign_up;

class AuthHeader extends StatelessWidget {
  final String title;
  final String content;
  final bool showBackButton;

  const AuthHeader(
      {super.key,
      required this.title,
      required this.content,
      this.showBackButton = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(AppPath.imgAppBar),
        Column(
          children: [
            const SizedBox(
              height: AppDimen.headerMargin,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                buildBackButton(context),
              ],
            ),
          ],
        ),
        Positioned(
          left: 0,
          bottom: AppDimen.spacing,
          right: 0,
          child: Column(
            children: [
              Text(
                title,
                style: AppStyle.largeHeaderStyle,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                content,
                style: AppStyle.smallTextWhiteStyle,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget buildBackButton(BuildContext context) {
    return showBackButton
        ? IconButton(
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
          )
        : SizedBox();
  }
}
