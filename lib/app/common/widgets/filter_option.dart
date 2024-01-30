import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_project/app/config/app_dimen.dart';
import 'package:my_project/app/config/app_style.dart';

class FilterOption extends StatelessWidget {
  final String icPath;
  final String title;
  final List<Widget> body;
  final VoidCallback callback;

  const FilterOption(
      {Key? key,
      required this.icPath,
      required this.title,
      required this.body,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppDimen.smallPadding),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(AppDimen.spacing)),
            color: Colors.white),
        margin: const EdgeInsets.all(AppDimen.spacing),
        child: Column(
          children: [
            Theme(
              data: ThemeData().copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                backgroundColor: Colors.transparent,
                collapsedBackgroundColor: Colors.transparent,
                title: Row(
                  children: [
                    SvgPicture.asset(
                      icPath,
                      width: AppDimen.mediumSize,
                      height: AppDimen.mediumSize,
                    ),
                    const SizedBox(
                      width: AppDimen.spacing,
                    ),
                    Text(
                      title,
                      style: AppStyle.mediumTextBlackStyle,
                    ),
                  ],
                ),
                children: [...body],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
