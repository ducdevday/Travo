import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:my_project/app/common/widgets/my_primary_button.dart';
import 'package:my_project/app/config/app_dimen.dart';
import 'package:my_project/app/config/app_path.dart';
import 'package:my_project/app/config/app_style.dart';

class MyDeveloping extends StatelessWidget {
  const MyDeveloping({Key? key}) : super(key: key);

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
                SvgPicture.asset(AppPath.icDeveloping, width: 400, height: 400),
                Text(
                  "This feature is in development",
                  style: AppStyle.mediumTextBlackStyle.copyWith(height: 1.5),
                ),
                SizedBox(height: AppDimen.spacing,),
                MyPrimaryButton(
                    text: "Go Back",
                    callback: () {
                      Navigator.of(context).pop();
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
