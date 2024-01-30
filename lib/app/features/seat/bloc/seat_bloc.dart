part of seat;

class SeatBloc extends Bloc<SeatEvent, SeatState> {
  SeatBloc() : super(SeatInitial()) {
    on<SeatChoosePressed>(_onSeatChoosePressed);
    on<SeatProcessPressed>(_onSeatProcessPressed);
  }

  FutureOr<void> _onSeatChoosePressed(
      SeatChoosePressed event, Emitter<SeatState> emit) {
    if (state is SeatInitial) {
      emit(SeatLoadChosenSuccess(
          chosenSeatType: event.chosenSeatType,
          chosenRowIndex: event.chosenRowIndex,
          chosenSeatIndex: event.chosenSeatIndex));
    } else if (state is SeatLoadChosenSuccess) {
      final currentState = state as SeatLoadChosenSuccess;
      if (currentState.chosenSeatType == event.chosenSeatType &&
          currentState.chosenRowIndex == event.chosenRowIndex &&
          currentState.chosenSeatIndex == event.chosenSeatIndex) {
        emit(const SeatLoadChosenSuccess(
            chosenSeatType: null, chosenRowIndex: null, chosenSeatIndex: null));
      } else {
        emit(SeatLoadChosenSuccess(
            chosenSeatType: event.chosenSeatType,
            chosenRowIndex: event.chosenRowIndex,
            chosenSeatIndex: event.chosenSeatIndex));
      }
    }
  }

  FutureOr<void> _onSeatProcessPressed(
      SeatProcessPressed event, Emitter<SeatState> emit) {
    emit(SeatProcessSuccess());
  }
}
