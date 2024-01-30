import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpFormPage extends StatefulWidget {
  const OtpFormPage({Key? key}) : super(key: key);

  @override
  State<OtpFormPage> createState() => _OtpFormPageState();
}

class _OtpFormPageState extends State<OtpFormPage> {
  late List<String> otps = ["", "", "", "", "", ""];

  bool isAllValid() {
    if (otps.contains("")) return false;
    return true;
  }

  void setOTP(int index, String value) {
    final List<String> updatedOtps = List.from(otps);
    updatedOtps[index] = value;
    setState(() {
      otps = updatedOtps;
    });
  }

  void verifyOTP() {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Verifying...")));
    print(otps);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verify"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OtpBox(
                    index: 0,
                    callback: (String value) {
                      setOTP(0, value);
                    }),
                SizedBox(
                  width: 8,
                ),
                OtpBox(
                    index: 1,
                    callback: (String value) {
                      setOTP(1, value);
                    }),
                SizedBox(
                  width: 8,
                ),
                OtpBox(
                    index: 2,
                    callback: (String value) {
                      setOTP(2, value);
                    }),
                SizedBox(
                  width: 8,
                ),
                OtpBox(
                    index: 3,
                    callback: (String value) {
                      setOTP(3, value);
                    }),
                SizedBox(
                  width: 8,
                ),
                OtpBox(
                    index: 4,
                    callback: (String value) {
                      setOTP(4, value);
                    }),
                SizedBox(
                  width: 8,
                ),
                OtpBox(
                    index: 5,
                    isLast: true,
                    callback: (String value) {
                      setOTP(5, value);
                    }),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Spacer(
              flex: 1,
            ),
            Container(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isAllValid() ? verifyOTP : null,
                  child: const Text("Confirm"),
                  style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: const Color(0xffCACACA),
                      disabledForegroundColor: const Color(0xffFEFEFE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      )),
                )),
          ],
        ),
      ),
    );
  }
}

class OtpBox extends StatefulWidget {
  final int index;
  final bool isLast;

  final Function(String) callback;

  const OtpBox(
      {required this.index, this.isLast = false, required this.callback});

  @override
  State<OtpBox> createState() => _OtpBoxState();
}

class _OtpBoxState extends State<OtpBox> {
  final FocusNode _textFieldFocus = FocusNode();
  Color _color = const Color(0xffF0F0F0);
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _textFieldFocus.addListener(() {
      if (_textFieldFocus.hasFocus) {
        setState(() {
          _color = Colors.white;
        });
      } else {
        setState(() {
          if (_controller.text.isEmpty) {
            _color = const Color(0xffF0F0F0);
          } else {
            _color = Colors.white;
          }
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 56,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color(0xffF0F0F0)),
      child: TextField(
        onChanged: (value) {
          // context.read<OtpCubit>().addOTP(_controller.text, widget.index),
          widget.callback(value);
          if (widget.isLast == false && _controller.text.isNotEmpty) {
            FocusScope.of(context).nextFocus();
          }
        },
        focusNode: _textFieldFocus,
        style: const TextStyle(fontSize: 20),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        controller: _controller,
        decoration: InputDecoration(
          fillColor: _color,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: _controller.text.isEmpty
                ? BorderSide.none
                : const BorderSide(color: Color(0xff16919c)),
          ),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xff16919c)),
              borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
