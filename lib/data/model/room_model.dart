import 'service_model.dart';

class RoomModel {
  final String id;
  final String hotel;
  final String image;
  final num maxGuest;
  final String name;
  final num price;
  final List<String> services;
  final num total;
  final String typePrice;

  const RoomModel({
    required this.id,
    required this.hotel,
    required this.image,
    required this.maxGuest,
    required this.name,
    required this.price,
    required this.services,
    required this.total,
    required this.typePrice,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json["id"],
      hotel: json["hotel"],
      image: json["image"],
      maxGuest: json["max_guest"] as num,
      name: json["name"],
      price: json["price"] as num,
      services: List.of(json["services"])
          .map((i) => i as String)
          .toList(),
      total: json["total"] as num,
      typePrice: json["type_price"],
    );
  }
}

class RoomModelExtended extends RoomModel {
  final List<ServiceModel> serviceModels;

  RoomModelExtended(this.serviceModels, {required super.id, required super.hotel, required super.image, required super.maxGuest, required super.name, required super.price, required super.services, required super.total, required super.typePrice});
}
