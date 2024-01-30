part of booking_date;

class BookingDateCubit extends Cubit<BookingDateState> {
  BookingDateCubit() : super(BookingDateState());

  void initBookings(List<DateTime?>? dates) {
    if (dates != null) {
      emit(
          state.copyWith(status: BookingDateStatus.ready, bookingTimes: dates));
    }
  }

  void chooseBookings(List<DateTime?> dates) {
    if (dates.length == 2) {
      emit(
          state.copyWith(status: BookingDateStatus.ready, bookingTimes: dates));
    } else {
      emit(state.copyWith(
          status: BookingDateStatus.initial, bookingTimes: dates));
    }
  }

  void selectBookings() {
    if (state.status == BookingDateStatus.ready) {
      emit(state.copyWith(status: BookingDateStatus.success));
    }
  }
}
