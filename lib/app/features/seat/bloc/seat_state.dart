part of seat;

abstract class SeatState extends Equatable {
  const SeatState();
}

class SeatInitial extends SeatState {
  @override
  List<Object> get props => [];
}

class SeatLoadChosenSuccess extends SeatState {
  final SeatType? chosenSeatType;
  final int? chosenRowIndex;
  final int? chosenSeatIndex;

  const SeatLoadChosenSuccess({required this.chosenSeatType,
    required this.chosenRowIndex,
    required this.chosenSeatIndex});

  @override
  List<Object?> get props => [chosenSeatType, chosenRowIndex, chosenSeatIndex];
}

class SeatProcessSuccess extends SeatState {
  @override
  List<Object> get props => [];
}