part of seat;

abstract class SeatEvent extends Equatable {
  const SeatEvent();
}

class SeatChoosePressed extends SeatEvent {
  final SeatType? chosenSeatType;
  final int? chosenRowIndex;
  final int? chosenSeatIndex;

  const SeatChoosePressed(
      {required this.chosenSeatType, required this.chosenRowIndex, required this.chosenSeatIndex});

  @override
  List<Object?> get props => [chosenSeatType, chosenRowIndex, chosenSeatIndex];
}

class SeatProcessPressed extends SeatEvent {
  @override
  List<Object> get props => [];
}
