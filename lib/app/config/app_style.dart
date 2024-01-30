import 'package:flutter/material.dart';
import 'package:my_project/app/config/app_color.dart';
import 'package:my_project/app/config/app_dimen.dart';

class AppStyle {
  static const largeHeaderStyle = TextStyle(
    color: AppColor.textWhiteColor,
    fontSize: AppDimen.largeHeader,
    fontWeight: FontWeight.w500,
  );

  static const mediumHeaderStyle = TextStyle(
    color: AppColor.textBlackColor,
    fontSize: AppDimen.mediumHeader,
    fontWeight: FontWeight.w500,
  );

  static const largeTitleStyle = TextStyle(
    color: AppColor.textBlackColor,
    fontSize: AppDimen.largeTitle,
    fontWeight: FontWeight.w500,
  );

  static const mediumTitleBlackStyle = TextStyle(
      color: AppColor.textBlackColor,
      fontSize: AppDimen.mediumTitle,
      fontWeight: FontWeight.w500);

  static const mediumTextBlackStyle = TextStyle(
      color: AppColor.textBlackColor,
      fontSize: AppDimen.mediumText,
      fontWeight: FontWeight.w500);

  static const mediumTextWhiteStyle = TextStyle(
      color: AppColor.textWhiteColor,
      fontSize: AppDimen.mediumText,
      fontWeight: FontWeight.w500);

  static const normalTextBlackStyle = TextStyle(
      color: AppColor.textBlackColor,
      fontSize: AppDimen.normalText,
      fontWeight: FontWeight.w500);

  static const normalTextWhiteStyle = TextStyle(
      color: AppColor.textWhiteColor,
      fontSize: AppDimen.normalText,
      fontWeight: FontWeight.w500);

  static const normalTextParagraphStyle = TextStyle(
      color: AppColor.textBlackColor,
      fontSize: AppDimen.normalText,
      fontWeight: FontWeight.w400);

  static const smallTextBlackStyle = TextStyle(
      color: AppColor.textBlackColor,
      fontSize: AppDimen.smallText,
      fontWeight: FontWeight.w400);

  static const smallTextWhiteStyle = TextStyle(
      color: AppColor.textWhiteColor,
      fontSize: AppDimen.smallText,
      fontWeight: FontWeight.w400);
}
