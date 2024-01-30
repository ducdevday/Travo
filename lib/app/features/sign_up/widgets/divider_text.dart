part of sign_up;

class DividerText extends StatelessWidget {
  final String text;
  const DividerText({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            thickness: 1,
            color: AppColor.dividerColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: AppStyle.normalTextParagraphStyle,
          ),
        ),
        const Expanded(
          child: Divider(
            thickness: 1,
            color: AppColor.dividerColor,
          ),
        ),
      ],
    );
  }
}
