enum HotelSortType {
  highestPrice,
  lowestPrice,
  highestRating;

  static String getName(HotelSortType type) {
    switch (type) {
      case highestPrice:
        return "Highest Price";
      case lowestPrice:
        return "Lowest Price";
      case highestRating:
        return "Highest Rating";
      default:
        return "";
    }
  }
}
