import 'package:flutter/material.dart';
import 'package:my_project/app/config/app_dimen.dart';

class MyCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double? padding;
  const MyCard({Key? key, required this.child, this.color, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding ?? AppDimen.screenPadding),
      decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(AppDimen.smallRadius))),
      child: child
    );
  }
}
