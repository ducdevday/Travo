import 'package:equatable/equatable.dart';

class GuestModel extends Equatable {
  final String email;
  final String name;
  final String phone;
  final String country;

  const GuestModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.country
  });

  @override
  List<Object> get props => [email, name, phone, country];

  factory GuestModel.fromJson(Map<String, dynamic> json) {
    return GuestModel(
      email: json["email"],
      name: json["name"],
      phone: json["phone"],
      country: json["country"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": this.email,
      "name": this.name,
      "phone": this.phone,
      "country": this.country,
    };
  }
}