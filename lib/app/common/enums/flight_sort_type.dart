enum FlightSortType {
  earliestDeparture,
  latestDeparture,
  earliestArrive,
  latestArrive,
  shortestDuration,
  lowestPrice,
  // highestPopularity
  ;

  static String getName(FlightSortType type) {
    switch (type) {
      case earliestDeparture:
        return "Earliest Departure";
      case latestDeparture:
        return "Latest Departure";
      case earliestArrive:
        return "Earliest Arrive";
      case latestArrive:
        return "Latest Arrive";
      case shortestDuration:
        return "Shortest Duration";
      case lowestPrice:
        return "Lowest Price";
      // case highestPopularity:
      //   return "Highest Popularity";
      default:
        return "";
    }
  }
}
