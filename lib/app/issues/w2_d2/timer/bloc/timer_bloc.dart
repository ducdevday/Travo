import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../ticker.dart';

part 'timer_event.dart';

part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  static const int _duration = 60;

  StreamSubscription<int>? _tickerSubscription;

  TimerBloc({required Ticker ticker})
      : _ticker = ticker,
        super(const TimerInitial(_duration)) {
    on<TimerStarted>(_onTimerStarted);
    on<TimerPaused>(_onTimerPaused);
    on<TimerResumed>(_onTimerResumed);
    on<TimerReset>(_onTimerReset);
    on<_TimerTicked>(_onTimerTicked);
  }

  FutureOr<void> _onTimerStarted(TimerStarted event, Emitter<TimerState> emit) {
    emit(TimerRunInProgress(event.duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: event.duration)
        .listen((duration) => add(_TimerTicked(duration: duration)));
  }

  FutureOr<void> _onTimerPaused(TimerPaused event, Emitter<TimerState> emit) {
    if (state is TimerRunInProgress) {
      _tickerSubscription?.pause();
      emit(TimerRunPause(state.duration));
    }
  }
  FutureOr<void> _onTimerResumed(TimerResumed event, Emitter<TimerState> emit) {
    if (state is TimerRunPause) {
      _tickerSubscription?.resume();
      emit(TimerRunInProgress(state.duration));
    }
  }

  FutureOr<void> _onTimerReset(TimerReset event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit(const TimerInitial(_duration));
  }

  FutureOr<void> _onTimerTicked(_TimerTicked event, Emitter<TimerState> emit) {
    emit(
      event.duration > 0
          ? TimerRunInProgress(event.duration)
          : TimerRunComplete(),
    );
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }




}
