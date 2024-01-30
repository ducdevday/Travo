part of checkout;

class AddButton extends StatelessWidget {
  final String title;
  final VoidCallback callback;

  const AddButton({
    super.key,required this.title, required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        callback();
      },
      child: Container(
        width: 200,
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(color: AppColor.secondaryColor, borderRadius: BorderRadius.all(Radius.circular(AppDimen.mediumRadius))),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              height: 40,
              width: 40,
              decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: SvgPicture.asset(AppPath.icAdd),),
            SizedBox(width: AppDimen.spacing),
            Text(title, style: AppStyle.normalTextBlackStyle.copyWith(color: AppColor.primaryColor),)
          ],
        ),
      ),
    );
  }
}