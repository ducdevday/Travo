import 'package:my_project/app/common/widgets/card_number_input_field.dart';

class CardModel{
  final String name;
  final String number;
  final String expDate;
  final String cvv;
  final String country;

  const CardModel({
    required this.name,
    required this.number,
    required this.expDate,
    required this.cvv,
    required this.country,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      name: json["name"],
      number: json["number"],
      expDate: json["expDate"],
      cvv: json["cvv"],
      country: json["country"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "number": this.number,
      "expDate": this.expDate,
      "cvv": this.cvv,
      "country": this.country,
    };
  }
}

enum CardType {
  Master,
  Visa,
  Verve,
  Discover,
  AmericanExpress,
  DinersClub,
  Jcb,
  Others,
  Invalid;

  String toJson() => name;

  static CardType fromJson(String json) => values.byName(json);
}