import 'package:flutter/material.dart';
import 'package:my_project/app/config/app_color.dart';

class MyRadio<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final BoxShape shape;

  const MyRadio(
      {Key? key,
      required this.value,
      required this.groupValue,
      required this.onChanged,
      this.shape = BoxShape.rectangle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSelected = value == groupValue;
    return InkWell(
      onTap: () {
        isSelected = !isSelected;
        if (isSelected) {
          onChanged!(value);
        } else if (!isSelected) {
          onChanged!(null);
        }
      },
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
            color: AppColor.secondaryColor,
            borderRadius: shape != BoxShape.circle
                ? BorderRadius.all(Radius.circular(10))
                : null,
            shape: shape),
        child: isSelected
            ? const Icon(
                Icons.check,
                color: AppColor.primaryColor,
                size: 20,
              )
            : null,
      ),
    );
  }
}
