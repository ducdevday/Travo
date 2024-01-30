import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_project/app/config/app_color.dart';
import 'package:my_project/app/config/app_style.dart';

class MyConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback callbackOK;
  final VoidCallback callbackCancel;
  final String? cancelText;
  final String? confirmText;

  const MyConfirmDialog(
      {Key? key,
        required this.title,
        required this.content,
        required this.callbackOK,
        required this.callbackCancel,this.cancelText, this.confirmText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: title.isNotEmpty ? Text(title) : null,
      content: content.isNotEmpty ? Text(content) : null,
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
            onPressed: callbackCancel,
            child: Text(
              cancelText ?? "Cancel",
              style: AppStyle.normalTextBlackStyle.copyWith(color: AppColor.primaryColor),
            )),
        CupertinoDialogAction(
            onPressed: callbackOK,
            child: Text(
              confirmText ?? "Confirm",
              style: AppStyle.normalTextBlackStyle.copyWith(color: AppColor.primaryColor),
            ))
      ],
    );
  }
}