import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_project/app/config/app_color.dart';

class MyCheckbox extends StatelessWidget {
  final bool? value;
  final ValueChanged<bool?>? onChanged;

  const MyCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = value ?? false;
    return InkWell(
      onTap: () {
        isSelected = !isSelected;
        if (isSelected) {
          onChanged!(isSelected);
        } else if (!isSelected) {
          onChanged!(isSelected);
        }
      },
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
            color: AppColor.secondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(4))),
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
