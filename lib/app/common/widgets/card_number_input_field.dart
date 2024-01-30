import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_project/app/common/widgets/my_field_container.dart';
import 'package:my_project/app/config/app_dimen.dart';
import 'package:my_project/app/config/app_path.dart';
import 'package:my_project/app/config/app_style.dart';
import 'package:my_project/app/utils/card_util.dart';
import 'package:my_project/data/model/card_model.dart';

class CardNumberInputField extends StatefulWidget {
  final String title;
  final String hint;
  final Function(String input) validateField;
  final String? initValue;
  final bool isEnable;
  final TextEditingController controller;

  CardNumberInputField(
      {required this.title,
      required this.hint,
      required this.validateField,
      this.initValue,
      this.isEnable = true,
      required this.controller});

  @override
  State<CardNumberInputField> createState() => _CardNumberInputFieldState();
}

class _CardNumberInputFieldState extends State<CardNumberInputField> {
  final FocusNode _focusNode = FocusNode();
  CardType cardType = CardType.Others;
  String? errorText;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        handleCardTypeFrmNumber();
        setState(() {
          errorText = widget.validateField(widget.controller.text);
        });
      }
    });

    if (widget.controller.text.isNotEmpty) {
      handleCardTypeFrmNumber();
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void handleCardTypeFrmNumber() {
    String input = CardUtil.getCleanedNumber(widget.controller.text);
    CardType type = CardUtil.getCardTypeFrmNumber(input);
    if (type != cardType) {
      setState(() {
        cardType = type;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyFieldContainer(
      errorText: errorText,
      child: Row(
        children: [
          getCardIcon(cardType),
          SizedBox(
            width: AppDimen.spacing,
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
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                    CardNumberInputFormatter(),
                  ],
                  validator: (value) {
                    return widget.validateField(value!);
                  },
                  controller: widget.controller,
                  focusNode: _focusNode,
                  style: AppStyle.normalTextBlackStyle,
                  decoration: InputDecoration(
                    border: InputBorder.none,
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

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}

Widget getCardIcon(CardType? cardType) {
  String imgPath = "";
  Icon icon = const Icon(
    Icons.warning,
    size: 24.0,
    color: Color(0xFFB8B5C3),
  );
  switch (cardType) {
    case CardType.Master:
      imgPath = AppPath.imgMasterCard;
      break;
    case CardType.Visa:
      imgPath = AppPath.imgVisa;
      break;
    case CardType.Verve:
      imgPath = AppPath.imgVerve;
      break;
    case CardType.AmericanExpress:
      imgPath = AppPath.imgAmericanExpress;
      break;
    case CardType.Discover:
      imgPath = AppPath.imgDiscover;
      break;
    case CardType.DinersClub:
      imgPath = AppPath.imgDinnerClubs;
      break;
    case CardType.Jcb:
      imgPath = AppPath.imgJcb;
      break;
    case CardType.Others:
      icon = const Icon(
        Icons.credit_card,
        size: 24.0,
        color: Color(0xFFB8B5C3),
      );
      break;
    default:
      icon = const Icon(
        Icons.warning,
        size: 24.0,
        color: Color(0xFFB8B5C3),
      );
      break;
  }
  Widget widget;
  if (imgPath.isNotEmpty) {
    widget = Image.asset(
      imgPath,
      width: 40.0,
      fit: BoxFit.cover,
    );
  } else {
    widget = icon;
  }
  return Column(
    children: [
      widget,
      SizedBox(
        height: 16,
      )
    ],
  );
}
