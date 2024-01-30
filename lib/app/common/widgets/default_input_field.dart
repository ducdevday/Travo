import 'package:flutter/material.dart';
import 'package:my_project/app/common/widgets/my_field_container.dart';
import 'package:my_project/app/config/app_color.dart';
import 'package:my_project/app/config/app_dimen.dart';
import 'package:my_project/app/config/app_style.dart';

class DefaultInputField extends StatefulWidget {
  final String title;
  final String hint;
  final Function(String input) validateField;
  final String? initValue;
  final bool isEnable;
  final bool isPassword;
  final TextEditingController controller;

  DefaultInputField(
      {required this.title,
      required this.hint,
      required this.validateField,
      this.initValue,
      this.isEnable = true,
      this.isPassword = false,
      required this.controller});

  @override
  State<DefaultInputField> createState() => _DefaultInputFieldState();
}

class _DefaultInputFieldState extends State<DefaultInputField> {
  final FocusNode _focusNode = FocusNode();
  String? errorText;
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
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
        isEnable: widget.isEnable,
        paddingRight: widget.isPassword ? 0 : 20,
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
              keyboardType: TextInputType.text,
              validator: (value) {
                return widget.validateField(value!);
              },
              obscuringCharacter: '*',
              obscureText: widget.isPassword && _passwordVisible == false,
              controller: widget.controller,
              focusNode: _focusNode,
              style: AppStyle.normalTextBlackStyle,
              decoration: InputDecoration(
                // errorText: errorText,
                border: InputBorder.none,
                suffixIcon: widget.isPassword
                    ? GestureDetector(
                        child: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Color(0xff232323),
                          size: 20,
                        ),
                        onTap: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      )
                    : null,
                hintText: widget.hint,
              ),
            ),
          ],
        ));
  }
}
