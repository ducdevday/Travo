part of checkout;

class BookingDateInformation extends StatelessWidget {
  const BookingDateInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Booking Date",
          style: AppStyle.normalTextBlackStyle,
        ),
        SizedBox(
          height: AppDimen.smallPadding,
        ),
        BlocSelector<CheckoutBloc, CheckoutState, List<DateTime?>>(
          selector: (state) {
            return state.bookingDates;
          },
          builder: (context, bookingDates) {
            return bookingDates.isEmpty
                ? AddButton(
                    title: "Add BookingDate",
                    callback: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                                value: context.read<CheckoutBloc>(),
                                child: BookingDatePage(),
                              )));
                    })
                : BookingDateItem(bookingDates: bookingDates,);
          },
        )
      ],
    ));
  }
}

class BookingDateItem extends StatelessWidget {
  final List<DateTime?> bookingDates;
  const BookingDateItem({
    super.key,
    required this.bookingDates
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<CheckoutBloc>(),
                    child: BookingDatePage(dates: bookingDates),
                  )));
            },
            child: Row(
              children: [
                SvgPicture.asset(AppPath.icCheckIn,
                    width: AppDimen.mediumSize),
                SizedBox(width: AppDimen.spacing),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Check-in",
                      style: AppStyle.smallTextBlackStyle
                          .copyWith(color: AppColor.headingColor),
                    ),
                    SizedBox(height: AppDimen.smallSpacing),
                    Text(
                      StringFormatUtil.formatShortDate(bookingDates[0]!),
                      style: AppStyle.normalTextBlackStyle,
                    ),
                  ],
                )
              ],
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<CheckoutBloc>(),
                    child: BookingDatePage(dates: bookingDates),
                  )));
            },
            child: Row(
              children: [
                SvgPicture.asset(AppPath.icCheckOut,
                    width: AppDimen.mediumSize),
                SizedBox(width: AppDimen.spacing),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Check-out",
                      style: AppStyle.smallTextBlackStyle
                          .copyWith(color: AppColor.headingColor),
                    ),
                    SizedBox(height: AppDimen.smallSpacing),
                    Text(
                      StringFormatUtil.formatShortDate(bookingDates[1]!),
                      style: AppStyle.normalTextBlackStyle,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      );
  }
}
