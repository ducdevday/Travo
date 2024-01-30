part of checkout;

class ConfirmStep extends StatelessWidget {
  final RoomModel room;

  const ConfirmStep({Key? key, required this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (context, state) {
        return Expanded(
          child: ListView(
            padding: const EdgeInsets.only(
                left: AppDimen.screenPadding,
                right: AppDimen.screenPadding,
                bottom: AppDimen.smallPadding),
            children: [
              RoomItemConfirm(room: room, bookingDates: state.bookingDates),
              const SizedBox(
                height: AppDimen.smallPadding,
              ),
              TotalPriceInformation(roomPrice: room.price),
              const SizedBox(
                height: AppDimen.smallPadding,
              ),
              const PaymentInformation(),
              const SizedBox(
                height: AppDimen.smallPadding,
              ),
              BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  if (state is UserLoadSuccess) {
                    return MyPrimaryButton(
                        text: "Pay Now",
                        callback: () {
                          context
                              .read<CheckoutBloc>()
                              .add(CheckoutPayNow(email: state.user.email));
                        });
                  } else {
                    return const SizedBox();
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }
}
