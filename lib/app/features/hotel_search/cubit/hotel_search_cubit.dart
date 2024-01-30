part of hotel_search;

class HotelSearchCubit extends Cubit<HotelSearchState> {
  final HotelRepository hotelRepository;

  HotelSearchCubit({required this.hotelRepository})
      : super(HotelSearchInitial());

  void doSearch(String text) async {
    if (text.isEmpty) {
      emit(HotelSearchInitial());
      return;
    }
    emit(HotelSearchInProcess());
    try {
      final hotels = await hotelRepository.searchHotel(text);
      if (hotels.isNotEmpty) {
        emit(HotelSearchHaveResult(hotels: hotels));
      } else {
        emit(HotelSearchNoResult());
      }
    } catch (e) {
      print(e);
      emit(HotelSearchError());
    }
  }
}
