import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_project/app/config/app_path.dart';
import 'package:my_project/app/config/app_style.dart';

class MyLoading extends StatelessWidget {
  const MyLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Lottie.asset(AppPath.icLoading, width: 200, height: 200),
                Text(
                  "Loading...",
                  style: AppStyle.mediumTextBlackStyle.copyWith(height: 1.5),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
