part of flight;

abstract class FlightState extends Equatable {
  const FlightState();

  @override
  List<Object> get props => [];
}

class FlightInitial extends FlightState {}

class FlightLoadInProcess extends FlightState {}

class FlightLoadSuccess extends FlightState {
  final List<FlightModel> flights;
  final num? duration;
  final num? budgetFrom;
  final num? budgetTo;
  final FlightSortType? sortType;

  const FlightLoadSuccess(
      {required this.flights, this.duration, this.budgetFrom, this.budgetTo, this.sortType});

  FlightLoadSuccess copyWith({
    List<FlightModel>? flights,
    num? duration,
    num? budgetFrom,
    num? budgetTo,
    FlightSortType? sortType
  }) {
    return FlightLoadSuccess(
      flights: flights ?? this.flights,
      duration: duration ?? this.duration,
      budgetFrom: budgetFrom ?? this.budgetFrom,
      budgetTo: budgetTo ?? this.budgetTo,
      sortType: sortType ?? this.sortType
    );
  }

  @override
  List<Object> get props => [flights];
}

class FlightLoadFailure extends FlightState {}
