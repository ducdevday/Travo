import 'package:flutter/material.dart';
import 'package:my_project/app/config/app_color.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
      useMaterial3: true,
      textTheme: ThemeData.light().textTheme.apply(fontFamily: "Rubik"),
      colorScheme: const ColorScheme.light(primary: AppColor.primaryColor),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: AppColor.primaryColor,
      ),
      scaffoldBackgroundColor: AppColor.backgroundColor,
      dividerTheme:
          DividerThemeData(color: AppColor.dividerColor, thickness: 1));

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
      useMaterial3: true,
      textTheme: ThemeData.light().textTheme.apply(fontFamily: "Rubik"),
      colorScheme: const ColorScheme.dark(primary: AppColor.primaryColor),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: AppColor.primaryColor,
      ),
      dividerTheme:
          DividerThemeData(color: AppColor.dividerColor, thickness: 1));
}
