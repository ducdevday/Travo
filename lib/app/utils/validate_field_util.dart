import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

import 'card_util.dart';

class ValidateFieldUtil {
  static bool validateName(String name) {
    // final RegExp nameRegRxp = RegExp(r'^[a-zA-Z]{2,12}(?: [a-zA-Z]+){0,2}$');
    final RegExp nameRegRxp = RegExp(r'^(?!.*\s{3,})(?!.*[^a-zA-Z\s]).{2,12}$');
    if (!nameRegRxp.hasMatch(name)) {
      return false;
    }
    return true;
  }

  static bool validateFlightPlace(String text) {
    if (text.isEmpty) {
      return false;
    }
    return true;
  }

  static bool validateEmail(String email) {
    final RegExp emailRegExp = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );
    if (!emailRegExp.hasMatch(email)) {
      return false;
    }
    return true;
  }

  static bool validatePassword(String password) {
    if (password.length < 6) {
      return false;
    }
    return true;
  }

  static bool validateCountry(String country) {
    if (country.isEmpty) {
      return false;
    }
    return true;
  }

  static bool validatePhone(CountryCode countryCode, String phone) {
    StringBuffer result = StringBuffer();

    for (int i = 0; i < phone.length; i++) {
      if (RegExp(r'[0-9]').hasMatch(phone[i])) {
        result.write(phone[i]);
      }
    }
    phone = result.toString();
    if (countryCode.nationalSignificantNumber != null) {
      if (phone.length != countryCode.nationalSignificantNumber!) {
        return false;
      }
      return true;
    } else if (countryCode.code == "VN") {
      if (phone.length != 9) {
        return false;
      }
      return true;
    } else if (phone.isEmpty) {
      return false;
    }
    return true;
  }

  static bool validateCardNum(String? input) {
    if (input == null || input.isEmpty) {
      return false;
    }
    input = CardUtil.getCleanedNumber(input);
    if (input.length < 8) {
      return false;
    }
    int sum = 0;
    int length = input.length;
    for (var i = 0; i < length; i++) {
      // get digits in reverse order
      int digit = int.parse(input[length - i - 1]);
      // every 2nd number multiply with 2
      if (i % 2 == 1) {
        digit *= 2;
      }
      sum += digit > 9 ? (digit - 9) : digit;
    }
    if (sum % 10 == 0) {
      return true;
    }
    return false;
  }

  static bool validateCVV(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    if (value.length < 3 || value.length > 4) {
      return false;
    }
    return true;
  }

  static bool validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    int year;
    int month;
    if (value.contains(RegExp(r'(/)'))) {
      var split = value.split(RegExp(r'(/)'));

      month = int.parse(split[0]);
      year = int.parse(split[1]);
    } else {
      month = int.parse(value.substring(0, (value.length)));
      year = -1; // Lets use an invalid year intentionally
    }
    if ((month < 1) || (month > 12)) {
      // A valid month is between 1 (January) and 12 (December)
      return false;
    }
    var fourDigitsYear = convertYearTo4Digits(year);
    if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
      // We are assuming a valid should be between 1 and 2099.
      // Note that, it's valid doesn't mean that it has not expired.
      return false;
    }
    if (!hasDateExpired(month, year)) {
      return false;
    }
    return true;
  }

  static int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  static bool hasDateExpired(int month, int year) {
    return isNotExpired(year, month);
  }

  static bool isNotExpired(int year, int month) {
    // It has not expired if both the year and date has not passed
    return !hasYearPassed(year) && !hasMonthPassed(year, month);
  }

  static List<int> getExpiryDate(String value) {
    var split = value.split(RegExp(r'(/)'));
    return [int.parse(split[0]), int.parse(split[1])];
  }

  static bool hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    // The month has passed if:
    // 1. The year is in the past. In that case, we just assume that the month
    // has passed
    // 2. Card's month (plus another month) is more than current month.
    return hasYearPassed(year) ||
        convertYearTo4Digits(year) == now.year && (month < now.month + 1);
  }

  static bool hasYearPassed(int year) {
    int fourDigitsYear = convertYearTo4Digits(year);
    var now = DateTime.now();
    // The year has passed if the year we are currently is more than card's
    // year
    return fourDigitsYear < now.year;
  }
}
