part of sign_up;

class PolicyText extends StatelessWidget {
  const PolicyText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          style:
          AppStyle.smallTextBlackStyle.copyWith(height: 1.5),
          children: [
            TextSpan(
              text: "By tapping sign up you agree to the ",
            ),
            TextSpan(
                text: "Terms and Condition",
                style: AppStyle.smallTextBlackStyle
                    .copyWith(color: AppColor.primaryColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print('Terms and Condition');
                  }),
            TextSpan(text: " and "),
            TextSpan(
                text: "Privacy Policy",
                style: AppStyle.smallTextBlackStyle
                    .copyWith(color: AppColor.primaryColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print('Privacy Policy');
                  }),
            TextSpan(
              text: " of this app",
            )
          ]),
    );
  }
}
