part of flight;

class FlightBloc extends Bloc<FlightEvent, FlightState> {
  final FlightRepository flightRepository;

  FlightBloc({required this.flightRepository}) : super(FlightInitial()) {
    on<FlightLoadAll>(_onFlightLoadAll);
    on<FlightApplyFilter>(_onFlightApplyFilter);
  }

  FutureOr<void> _onFlightLoadAll(
      FlightLoadAll event, Emitter<FlightState> emit) async {
    emit(FlightLoadInProcess());
    try {
      final flights = await flightRepository.getAllFlights(
          event.fromPlace, event.toPlace, event.departureDate);
      emit(FlightLoadSuccess(flights: flights));
    } catch (e) {
      print(e);
      emit(FlightLoadFailure());
    }
  }

  FutureOr<void> _onFlightApplyFilter(
      FlightApplyFilter event, Emitter<FlightState> emit) async {
    // add(FlightLoadAll(fromPlace: event.fromPlace, toPlace: event.toPlace));
    if (state is FlightLoadSuccess) {
      final currentState = state as FlightLoadSuccess;
      final flights = await flightRepository.getAllFlights(
          event.fromPlace, event.toPlace, event.departureDate);
      var filteredFlights = List<FlightModel>.from(flights);
      filteredFlights = filteredFlights.where((flight) {
        final duration =
            flight.arriveTime!.difference(flight.departureTime!).inHours;
        return duration <= event.duration &&
            flight.price! >= event.budgetFrom &&
            flight.price! <= event.budgetTo;
      }).toList();
      filteredFlights = sortFlight(filteredFlights, event.sortType);
      filteredFlights;
      emit(currentState.copyWith(
          flights: filteredFlights,
          duration: event.duration,
          budgetFrom: event.budgetFrom,
          budgetTo: event.budgetTo,
          sortType: event.sortType
      ));
    }
  }

  List<FlightModel> sortFlight(
      List<FlightModel> list, FlightSortType? sortType) {
    if(sortType == null) {
      return list;
    }
    switch (sortType) {
      case FlightSortType.earliestDeparture:
        list.sort((a, b) => a.departureTime!.compareTo(b.departureTime!));
      case FlightSortType.latestDeparture:
        list.sort((a, b) => b.departureTime!.compareTo(a.departureTime!));
      case FlightSortType.earliestArrive:
        list.sort((a, b) => a.arriveTime!.compareTo(b.arriveTime!));
      case FlightSortType.latestArrive:
        list.sort((a, b) => b.arriveTime!.compareTo(a.arriveTime!));
      case FlightSortType.shortestDuration:
        list.sort((a, b) {
          final aDuration = a.arriveTime!.difference(a.departureTime!).inHours;
          final bDuration = b.arriveTime!.difference(b.departureTime!).inHours;
          return aDuration.compareTo(bDuration);
        });
      case FlightSortType.lowestPrice:
        list.sort((a, b) => a.price!.compareTo(b.price!));
      // case FlightSortType.highestPopularity:
    }
    return list;
  }
}
