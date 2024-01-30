part of flight;

abstract class FlightEvent extends Equatable {
  const FlightEvent();
}

class FlightLoadAll extends FlightEvent {
  final String fromPlace;
  final String toPlace;
  final DateTime departureDate;

  const FlightLoadAll(
      {required this.fromPlace,
      required this.toPlace,
      required this.departureDate});

  @override
  List<Object> get props => [fromPlace, toPlace, departureDate];
}

class FlightApplyFilter extends FlightEvent {
  final String fromPlace;
  final String toPlace;
  final DateTime departureDate;
  final num duration;
  final num budgetFrom;
  final num budgetTo;
  final FlightSortType? sortType;
  const FlightApplyFilter({
    required this.fromPlace,
    required this.toPlace,
    required this.departureDate,
    required this.duration,
    required this.budgetFrom,
    required this.budgetTo,
    required this.sortType
  });

  @override
  List<Object> get props => [
        fromPlace,
        toPlace,
        duration,
        budgetFrom,
        budgetTo,
      ];
}
