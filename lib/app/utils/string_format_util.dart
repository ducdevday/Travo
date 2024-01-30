import 'package:intl/intl.dart';

class StringFormatUtil {
  static String formatShortDate(DateTime date) {
    return DateFormat('E, d MMM', 'en_US').format(date);
  }

  static String formattedShortDate2(DateTime dateTime) {
    return DateFormat('d MMM, yyyy').format(dateTime.toLocal());
  }

  static String formattedLongDate(DateTime dateTime) {
    return DateFormat('MMMM dd, yyy').format(dateTime.toLocal());
  }

  static String formattedLongDate2(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime.toLocal());
  }

  static String formattedLongTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime.toLocal());
  }

  static String formatLongString(String input, int maxLength) {
    if (input.length > maxLength) {
      return '${input.substring(0, maxLength)}...';
    } else {
      return input;
    }
  }

  static String formatCapitalizeString(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  static String formatNumber(num number) {
    try {
      int intResult = number.toInt();
      return intResult.toString();
    } catch (e) {
      return number.toString();
    }
  }

  static String formatMoney(num? number) {
    if (number == null) return "\$${number.toString()}";
    try {
      int intResult = number.toInt();
      return "\$${intResult.toString()}";
    } catch (e) {
      return "\$${number.toString()}";
    }
  }

  static String formatStep(String text) {
    if (text.isEmpty) {
      return text;
    }

    List<String> words = text.toLowerCase().split('_');
    List<String> capitalizedWords =
        words.map((word) => word[0].toUpperCase() + word.substring(1)).toList();

    return capitalizedWords.join(' ');
  }

  static String getLastWord(String text) {
    List<String> sArr = text.split(" ");
    return sArr.isNotEmpty ? sArr.last : "";
  }
}
