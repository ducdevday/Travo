import 'package:flutter/material.dart';
import 'package:my_project/app/config/app_color.dart';
import 'package:my_project/app/config/app_style.dart';

class MySecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  final double? width;
  final double? height;
  final double? radius;
  final bool isEnable;

  const MySecondaryButton(
      {Key? key,
      required this.text,
      required this.callback,
      this.width,
      this.height,
      this.radius, this.isEnable = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 200,
      height: height ?? 50,
      child: ElevatedButton(
        child: Text(
          text,
          style:isEnable? AppStyle.mediumTextWhiteStyle.copyWith(color: AppColor.primaryColor) : AppStyle.mediumTextWhiteStyle,
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.secondaryColor,
            disabledBackgroundColor: const Color(0xffCACACA),
            disabledForegroundColor: const Color(0xffFEFEFE),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 24),
            )),
        onPressed: isEnable? () {
          callback();
        }: null,
      ),
    );
  }
}
