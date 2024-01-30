import 'package:flutter/material.dart';
import 'package:my_project/app/config/app_color.dart';
import 'package:my_project/app/config/app_dimen.dart';
import 'package:my_project/app/config/app_style.dart';

class MyFieldContainer extends StatelessWidget {
  final Widget child;
  final String? errorText;
  final double? paddingRight;
  final double? paddingTop;
  final double? paddingBottom;
  final double? paddingLeft;
  final bool isEnable;

  const MyFieldContainer(
      {Key? key,
      required this.errorText,
      required this.child,
      this.paddingRight,
      this.paddingTop,
      this.paddingBottom,
      this.paddingLeft,
      this.isEnable = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
              top: paddingTop ?? 16.0,
              left: paddingLeft ?? 20,
              right: paddingRight ?? 20,
              bottom: paddingBottom ?? 0),
          decoration: BoxDecoration(
              color: isEnable ? Colors.white : AppColor.nonactiveColor,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: child,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: AppDimen.smallSpacing,
              horizontal: AppDimen.smallPadding),
          child: Text(
            errorText ?? "",
            style: AppStyle.smallTextBlackStyle.copyWith(color: Colors.red),
          ),
        )
      ],
    );
  }
}
