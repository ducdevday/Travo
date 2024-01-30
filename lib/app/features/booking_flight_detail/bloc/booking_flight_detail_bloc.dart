import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_project/data/model/booking_flight_detail_model.dart';
import 'package:my_project/data/repositories/booking_flight/booking_flight_repository.dart';

part 'booking_flight_detail_event.dart';
part 'booking_flight_detail_state.dart';

class BookingFlightDetailBloc
    extends Bloc<BookingFlightDetailEvent, BookingFlightDetailState> {
  final BookingFlightRepository bookingFlightRepository;

  BookingFlightDetailBloc({required this.bookingFlightRepository})
      : super(BookingFlightDetailInitial()) {
    on<BookingFlightDetailLoadById>(_onBookingFlightDetailLoadById);
  }

  FutureOr<void> _onBookingFlightDetailLoadById(
      BookingFlightDetailLoadById event,
      Emitter<BookingFlightDetailState> emit) async {
    emit(BookingFlightDetailLoadInProcess());
    try {
      final bookingFlightDetail =
          await bookingFlightRepository.getBookingFlightById(event.id);
      await Future.delayed(Duration(seconds: 1));
      emit(BookingFlightDetailLoadSuccess(
          bookingFlightDetail: bookingFlightDetail));
    } catch (e) {
      print(e);
      emit(BookingFlightDetailLoadFailure());
    }
  }
}
