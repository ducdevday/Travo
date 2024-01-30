import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:my_project/app/common/widgets/my_field_container.dart';
import 'package:my_project/app/config/app_dimen.dart';
import 'package:my_project/app/config/app_style.dart';

class PhoneInputField extends StatefulWidget {
  final TextEditingController controller;

  // final FocusNode focusNode;
  final FlCountryCodePicker countryPicker;
  final CountryCode? countryCode;
  final Function(CountryCode) chooseCountryCode;
  final Function(String input) validateField;

  const PhoneInputField(
      {Key? key,
      required this.controller,
      // required this.focusNode,
      required this.countryPicker,
      required this.countryCode,
      required this.chooseCountryCode,
      required this.validateField})
      : super(key: key);

  @override
  State<PhoneInputField> createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField> {
  String? errorText;
  final FocusNode focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        setState(() {
          errorText = widget.validateField(widget.controller.text);
        });
      }
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyFieldContainer(
        errorText: errorText,
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Phone",
                style: AppStyle.smallTextBlackStyle,
              ),
            ),
            TextFormField(
              maxLines: 1,
              controller: widget.controller,
              focusNode: focusNode,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              style: AppStyle.normalTextBlackStyle,
              inputFormatters: [
                PhoneInputFormatter(
                  allowEndlessPhone: false,
                  defaultCountryCode: widget.countryCode?.code,
                )
              ],
              decoration: InputDecoration(
                hintText: "Enter your Phone Number",
                prefixIconConstraints: const BoxConstraints(),
                prefixIcon: InkWell(
                  onTap: () async {
                    final code = await widget.countryPicker.showPicker(
                      context: context,
                      scrollToDeviceLocale: true,
                    );
                    if (code != null) {
                      // setState(() => countryCode = code);
                      // countryTextController.text = code.name;
                      widget.chooseCountryCode(code);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: const BoxDecoration(
                      border: Border(right: BorderSide(color: Colors.grey)),
                    ),
                    child: Text(widget.countryCode?.dialCode ?? "+?",
                        style: AppStyle.normalTextBlackStyle),
                  ),
                ),
                border: InputBorder.none,
                // errorText: errorText,
              ),
            ),
          ],
        ));
  }
}
