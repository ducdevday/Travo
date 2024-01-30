import 'package:equatable/equatable.dart';

class PromoModel{
  final String id;
  final String code;
  final String endow;
  final String image;
  final num price;

  const PromoModel({
    required this.id,
    required this.code,
    required this.endow,
    required this.image,
    required this.price,
  });

  factory PromoModel.fromJson(Map<String, dynamic> json) {
    return PromoModel(
      id: json["id"],
      code: json["code"],
      endow: json["endow"],
      image: json["image"],
      price: json["price"] as num,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "code": this.code,
      "endow": this.endow,
      "image": this.image,
      "price": this.price,
    };
  }

  @override
  String toString() {
    return 'PromoModel{id: $id, code: $code, endow: $endow, image: $image, price: $price}';
  }
}

