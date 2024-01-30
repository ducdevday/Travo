import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_project/app/config/app_dimen.dart';
import 'package:my_project/app/config/app_style.dart';

import 'my_field_container.dart';

class FlightInputField extends StatefulWidget {
  final String title;
  final String hint;
  final Function(String input) validateField;
  final String? initValue;
  final bool isEnable;
  final TextEditingController controller;
  final String icPath;
  final double? icSize;

  FlightInputField(
      {required this.title,
      required this.hint,
      required this.validateField,
      this.initValue,
      this.isEnable = true,
      required this.controller,
      required this.icPath,
      this.icSize});

  @override
  State<FlightInputField> createState() => _FlightInputFieldState();
}

class _FlightInputFieldState extends State<FlightInputField> {
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
      child: Row(
        children: [
          Column(
            children: [
              SvgPicture.asset(
                widget.icPath,
                width: widget.icSize ?? 20.0,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 16,
              )
            ],
          ),
          SizedBox(
            width: AppDimen.smallPadding,
          ),
          Expanded(
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
                  keyboardType: TextInputType.text,
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
          ),
        ],
      ),
    );
  }
}
