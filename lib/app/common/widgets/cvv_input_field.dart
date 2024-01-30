import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_project/app/common/widgets/my_field_container.dart';
import 'package:my_project/app/config/app_dimen.dart';
import 'package:my_project/app/config/app_style.dart';

class CvvInputField extends StatefulWidget {
  final String title;
  final String hint;
  final Function(String input) validateField;
  final String? initValue;
  final bool isEnable;
  final TextEditingController controller;

  CvvInputField(
      {required this.title,
      required this.hint,
      required this.validateField,
      this.initValue,
      this.isEnable = true,
      required this.controller});

  @override
  State<CvvInputField> createState() => _CvvInputFieldState();
}

class _CvvInputFieldState extends State<CvvInputField> {
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
              LengthLimitingTextInputFormatter(3),
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
      ),
    );
  }
}
