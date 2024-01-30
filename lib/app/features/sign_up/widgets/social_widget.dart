part of sign_up;

class SocialWidget extends StatelessWidget {
  final VoidCallback callbackGoogle;
  final VoidCallback callbackFaceBook;

  const SocialWidget({
    super.key,
    required this.callbackGoogle,
    required this.callbackFaceBook,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ElevatedButton.icon(
            icon: SvgPicture.asset(
              AppPath.icGoogle,
              width: 22,
              height: 22,
            ),
            onPressed: () {
              callbackGoogle();
            },
            label: const Text(
              "Google",
              style: AppStyle.mediumTextBlackStyle,
            ),
            style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
          ),
        ),
        const SizedBox(
          width: AppDimen.spacing * 4,
        ),
        Expanded(
          child: ElevatedButton.icon(
            icon: SvgPicture.asset(
              AppPath.icFacebook,
              width: 22,
              height: 22,
            ),
            onPressed: () {
              callbackFaceBook();
            },
            label: const Text(
              "Facebook",
              style: AppStyle.mediumTextWhiteStyle,
            ),
            style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                backgroundColor: AppColor.facebookColor),
          ),
        ),
      ],
    );
  }
}
