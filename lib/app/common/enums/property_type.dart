import 'package:my_project/app/utils/string_format_util.dart';

enum PropertyType {
  lodge,
  castle,
  retreat,
  resort,
  hotel,
  villa,
  others;

  static String getName(PropertyType type) {
    switch (type) {
      case lodge:
        return "Lodge";
      case castle:
        return "Castle";
      case retreat:
        return "Retreat";
      case resort:
        return "Resort";
      case hotel:
        return "Hotel";
      case villa:
        return "Villa";
      case others:
        return "Others";
      default:
        return "";
    }
  }
}

enum PropertyOrderType {
  hostel,
  guestHouse,
  homeStay,
  apartment;

  static String getName(PropertyOrderType type) {
    switch (type) {
      case hostel:
        return "Hostel";
      case guestHouse:
        return "Guest House";
      case homeStay:
        return "Home Stay";
      case apartment:
        return "Apartment";
      default:
        return "";
    }
  }
}
