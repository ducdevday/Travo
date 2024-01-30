import 'package:my_project/data/model/booking_detail_model.dart';
import 'package:my_project/data/model/booking_model.dart';

abstract class BookingRepositoryBase{
  Future<String> createBooking(BookingModel booking);
  Future<BookingDetailModel> getBookingDetail(String bookingId);
  Future<List<BookingDetailModel>> getAllBookings(String userEmail);

}