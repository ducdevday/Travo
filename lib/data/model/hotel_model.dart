class HotelModel{
  String? id;
  String? image;
  String? information;
  String? location;
  String? locationDescription;
  String? name;
  num? price;
  num? rating;
  num? totalReview;
  bool? isLiked;

  HotelModel({
     this.id,
     this.image,
     this.information,
     this.location,
     this.locationDescription,
     this.name,
     this.price,
     this.rating,
     this.totalReview,
    this.isLiked = false,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      id: json['id'] as String?,
      image: json['image'] as String?,
      information: json['information'] as String?,
      location: json['location'] as String?,
      locationDescription: json['location_description'] as String?,
      name: json['name'] as String?,
      price: json["price"] as num?,
      rating: json["rating"] as num?,
      totalReview: json["total_review"] as num?,
      isLiked: json["isLiked"] != null ? json["isLiked"].toLowerCase() == 'true' : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "image": this.image,
      "information": this.information,
      "location": this.location,
      "location_description": this.locationDescription,
      "name": this.name,
      "price": this.price,
      "rating": this.rating,
      "total_review": this.totalReview,
      "isLiked": this.isLiked,
    };
  }

  HotelModel copyWith({
    String? id,
    String? image,
    String? information,
    String? location,
    String? locationDescription,
    String? name,
    num? price,
    num? rating,
    num? totalReview,
    bool? isLiked,
  }) {
    return HotelModel(
      id: id ?? this.id,
      image: image ?? this.image,
      information: information ?? this.information,
      location: location ?? this.location,
      locationDescription: locationDescription ?? this.locationDescription,
      name: name ?? this.name,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      totalReview: totalReview ?? this.totalReview,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'image': this.image,
      'information': this.information,
      'location': this.location,
      'locationDescription': this.locationDescription,
      'name': this.name,
      'price': this.price,
      'rating': this.rating,
      'totalReview': this.totalReview,
      'isLiked': this.isLiked,
    };
  }
}