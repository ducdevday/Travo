import 'package:flutter/material.dart';
import 'package:my_project/app/common/widgets/my_radio.dart';
import 'package:my_project/app/config/app_style.dart';

class SortItem<T> extends StatelessWidget {
  final String title;
  final T value;
  final T? groupValue;
  final Function(T?) callback;
  final BoxShape shape;

  const SortItem(
      {Key? key,
      required this.title,
      required this.value,
      required this.groupValue,
      required this.callback,
      this.shape = BoxShape.rectangle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Text(
          title,
          style: AppStyle.normalTextParagraphStyle,
        ),
        MyRadio(
            value: value,
            groupValue: groupValue,
            onChanged: (T? value) {
              callback(value);
            },
            shape: shape),
      ],
    );
  }
}
