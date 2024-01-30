part of checkout;

class BookingAndReviewStep extends StatelessWidget {
  final RoomModel room;

  const BookingAndReviewStep({
    super.key,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.only(
            left: AppDimen.screenPadding,
            right: AppDimen.screenPadding,
            bottom: AppDimen.smallPadding),
        children: [
          RoomItemBooking(
            room: room,
          ),
          const SizedBox(
            height: AppDimen.smallPadding,
          ),
          ContactInformation(
            maxGuest: room.maxGuest,
          ),
          const SizedBox(
            height: AppDimen.smallPadding,
          ),
          const PromoInformation(),
          const SizedBox(
            height: AppDimen.smallPadding,
          ),
          const BookingDateInformation(),
          const SizedBox(
            height: AppDimen.smallPadding,
          ),
          const GoToPaymentButton(
            type: CheckoutType.hotel,
          )
        ],
      ),
    );
  }
}