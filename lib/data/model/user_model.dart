class UserModel {
  final String name;
  final String email;
  final String country;
  final String phoneNumber;
  final String? avatar;

  const UserModel({
    required this.name,
    required this.email,
    required this.country,
    required this.phoneNumber,
    this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json["name"],
      email: json["email"],
      country: json["country"],
      phoneNumber: json["phoneNumber"],
      avatar: json["avatar"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "email": this.email,
      "country": this.country,
      "phoneNumber": this.phoneNumber,
      "avatar": this.avatar,
    };
  }
}