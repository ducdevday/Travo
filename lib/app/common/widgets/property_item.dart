import 'package:flutter/cupertino.dart';
import 'package:my_project/app/common/widgets/my_checkbox.dart';
import 'package:my_project/app/config/app_style.dart';

class PropertyItem extends StatelessWidget {
  final String title;
  final bool? value;
  final ValueChanged<bool?>? callback;

  const PropertyItem({
    super.key,
    required this.title,
    this.value,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppStyle.normalTextParagraphStyle,
        ),
        MyCheckbox(
            value: value,
            onChanged: (newValue) => {
                  if (callback != null) {callback!(newValue)}
                })
      ],
    );
  }
}
