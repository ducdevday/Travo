import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_project/app/common/widgets/my_field_container.dart';
import 'package:my_project/app/config/app_dimen.dart';
import 'package:my_project/app/config/app_style.dart';

class CountryInputField extends StatefulWidget {
  final TextEditingController controller;
  final FlCountryCodePicker countryPicker;
  final CountryCode? countryCode;
  final Function(CountryCode) chooseCountryCode;
  final Function(String input) validateField;

  const CountryInputField(
      {Key? key,
      required this.controller,
      required this.countryPicker,
      required this.countryCode,
      required this.chooseCountryCode,
      required this.validateField})
      : super(key: key);

  @override
  State<CountryInputField> createState() => _CountryInputFieldState();
}

class _CountryInputFieldState extends State<CountryInputField> {
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
        paddingRight: 0,
        errorText: errorText,
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Country",
                style: AppStyle.smallTextBlackStyle,
              ),
            ),
            InkWell(
              onTap: () async {
                final code = await widget.countryPicker.showPicker(
                  context: context,
                  scrollToDeviceLocale: true,
                );
                if (code != null) {
                  widget.chooseCountryCode(code);
                }
              },
              child: TextFormField(
                enabled: false,
                keyboardType: TextInputType.text,
                controller: widget.controller,
                style: AppStyle.normalTextBlackStyle,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down,
                    size: 30,
                    color: Color(0xff232323),
                  ),
                  // errorText: errorText,
                ),
              ),
            ),
          ],
        ));
  }
}
