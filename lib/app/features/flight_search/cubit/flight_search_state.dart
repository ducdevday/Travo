part of flight_search;

abstract class FlightSearchState {
  const FlightSearchState();
}

class FlightSearchInitial extends FlightSearchState {
}

class FlightSearchReady extends FlightSearchState {
}
