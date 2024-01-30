part of checkout;

class RoomItemConfirm extends StatelessWidget {
  final RoomModel room;
  final List<DateTime?> bookingDates;

  const RoomItemConfirm(
      {super.key, required this.room, required this.bookingDates});

  @override
  Widget build(BuildContext context) {
    return RoomItem(
        room: room,
        showService: false,
        bottom: BookingDateItem(bookingDates: bookingDates));
  }
}
