import 'package:flutter/material.dart';
import 'package:gradient_coloured_buttons/gradient_coloured_buttons.dart';
import 'package:my_project/app/config/app_color.dart';
import 'package:my_project/app/config/app_style.dart';

class MyPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  final bool isEnable;
  final double? width;
  final double? height;
  final double? radius;

  const MyPrimaryButton(
      {Key? key,
      required this.text,
      required this.callback,
      this.isEnable = true,
      this.width,
      this.height,
      this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isEnable) {
      return GradientButton(
        width: width ?? 200,
        height: height ?? 50,
        borderRadius: radius ?? 24,
        text: text,
        onPressed: () {
          callback();
        },
        textStyle: AppStyle.mediumTextWhiteStyle,
        gradientColors: const [
          AppColor.linearFromColor,
          AppColor.linearToColor
        ],
      );
    } else {
      return SizedBox(
        width: width ?? 200,
        height: height ?? 50,
        child: ElevatedButton(
            onPressed: null,
            child: Text(
              text,
              style: AppStyle.mediumTextWhiteStyle,
            ),
            style: ElevatedButton.styleFrom(
                disabledBackgroundColor: const Color(0xffCACACA),
                disabledForegroundColor: const Color(0xffFEFEFE),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius ?? 24),
                ))),
      );
    }
  }
}
