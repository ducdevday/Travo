part of booking_detail;

class BookingDetailBloc extends Bloc<BookingDetailEvent, BookingDetailState> {
  final BookingRepository bookingRepository;

  BookingDetailBloc({required this.bookingRepository})
      : super(BookingDetailInitial()) {
    on<BookingDetailLoadById>(_onBookingDetailLoadById);
  }

  FutureOr<void> _onBookingDetailLoadById(
      BookingDetailLoadById event, Emitter<BookingDetailState> emit) async {
    emit(BookingDetailLoadInProcess());
    try {
      final bookingDetail =
          await bookingRepository.getBookingDetail(event.bookingId);
      await Future.delayed(Duration(seconds: 1));
      emit(BookingDetailLoadSuccess(bookingDetail: bookingDetail));
    } catch (e) {
      print(e);
      emit(BookingDetailLoadFailure());
    }
  }
}
