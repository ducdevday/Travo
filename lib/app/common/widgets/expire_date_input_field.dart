import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_project/app/common/widgets/my_field_container.dart';
import 'package:my_project/app/config/app_dimen.dart';
import 'package:my_project/app/config/app_style.dart';

class ExpireDateInputField extends StatefulWidget {
  final String title;
  final String hint;
  final Function(String input) validateField;
  final String? initValue;
  final bool isEnable;
  final TextEditingController controller;

  ExpireDateInputField(
      {required this.title,
      required this.hint,
      required this.validateField,
      this.initValue,
      this.isEnable = true,
      required this.controller});

  @override
  State<ExpireDateInputField> createState() => _ExpireDateInputFieldState();
}

class _ExpireDateInputFieldState extends State<ExpireDateInputField> {
  final FocusNode _focusNode = FocusNode();
  String? errorText;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          errorText = widget.validateField(widget.controller.text);
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyFieldContainer(
        errorText: errorText,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                widget.title,
                style: AppStyle.smallTextBlackStyle,
              ),
            ),
            TextFormField(
              enabled: widget.isEnable,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
                CardMonthInputFormatter()
              ],
              validator: (value) {
                return widget.validateField(value!);
              },
              controller: widget.controller,
              focusNode: _focusNode,
              style: AppStyle.normalTextBlackStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
                // errorText: errorText,
                hintText: widget.hint,
              ),
            ),
          ],
        ));
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
