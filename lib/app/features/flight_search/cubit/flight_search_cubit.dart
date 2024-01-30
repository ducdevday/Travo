part of flight_search;

class FlightSearchCubit extends Cubit<FlightSearchState> {
  FlightSearchCubit() : super(FlightSearchInitial());

  void checkValidField(
    String flightFrom,
    String flightTo,
    List<DateTime?> dates,
    SeatType? seatType,
  ) {
    if (ValidateFieldUtil.validateFlightPlace(flightFrom) &&
        ValidateFieldUtil.validateFlightPlace(flightTo) &&
        dates.isNotEmpty &&
        seatType != null) {
      emit(FlightSearchReady());
    } else {
      emit(FlightSearchInitial());
    }
  }
}
