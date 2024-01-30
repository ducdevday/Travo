class PlaceModel {
  final String id;
  final String name;
  final double rating;
  final String image;
  final bool isLiked;

  const PlaceModel({
    required this.id,
    required this.name,
    required this.rating,
    required this.image,
    this.isLiked = false,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json["id"],
      name: json["name"],
      rating: json["rating"] as double,
      image: json["image"],
      isLiked: json["isLiked"] != null
          ? json["isLiked"].toLowerCase() == 'true'
          : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "rating": this.rating,
      "image": this.image,
      "isLiked": this.isLiked,
    };
  }

  PlaceModel copyWith({
    String? id,
    String? name,
    double? rating,
    String? image,
    bool? isLiked,
  }) {
    return PlaceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      rating: rating ?? this.rating,
      image: image ?? this.image,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
