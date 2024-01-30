import 'package:flutter/material.dart';
import 'package:my_project/app/config/app_dimen.dart';
import 'package:my_project/app/config/app_path.dart';
import 'package:my_project/app/config/app_style.dart';

class DefaultHeader extends StatelessWidget {
  final String title;
  final bool showBackButton;

  const DefaultHeader(
      {Key? key, required this.title, this.showBackButton = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AppPath.imgAppBar,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Column(
          children: [
            const SizedBox(
              height: AppDimen.headerMargin,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimen.screenPadding),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  buildBackButton(context),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      style: AppStyle.largeHeaderStyle,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget buildBackButton(BuildContext context) {
    if (showBackButton) {
      return Positioned(
        left: 0,
        top: 0,
        child: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_rounded, size: 20),
          style: IconButton.styleFrom(
            backgroundColor: Colors.white,
            padding: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
          ),
        ),
      );
    }
    return SizedBox();
  }
}
