part of home;

class HomeItem extends StatelessWidget {
  final String title;
  final Color icColor;
  final String icPath;
  final VoidCallback callback;

  const HomeItem({
    super.key,
    required this.title,
    required this.icColor,
    required this.icPath,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              callback();
            },
            child: Container(
              // padding: EdgeInsets.symmetric(
              //     horizontal: MediaQuery.of(context).size.width / 6 -
              //         AppDimen.screenPadding -
              //         5,
              //     vertical: 30
              // ),
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                  color: icColor,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: icPath == AppPath.icAll
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        SvgPicture.asset(
                          icPath,
                          width: 28,
                          height: 28,
                          fit: BoxFit.cover,
                        ),
                      ],
                    )
                  : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SvgPicture.asset(
                        icPath,
                        width: 28,
                        height: 28,
                        fit: BoxFit.cover,
                      )
                    ]),
            ),
          ),
          const SizedBox(
            height: AppDimen.spacing,
          ),
          Text(
            title,
            style: AppStyle.normalTextParagraphStyle,
          )
        ],
      ),
    );
  }
}
