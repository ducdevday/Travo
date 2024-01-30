part of booking_date;

class BookingDatePage extends StatefulWidget {
  final List<DateTime?>? dates;

  const BookingDatePage({Key? key, this.dates}) : super(key: key);

  @override
  State<BookingDatePage> createState() => _BookingDatePageState();
}

class _BookingDatePageState extends State<BookingDatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => BookingDateCubit()..initBookings(widget.dates),
        child: BlocListener<BookingDateCubit, BookingDateState>(
          listener: (context, state) {
            if (state.status == BookingDateStatus.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(content: Text(widget.dates == null ? "Added Booking Dates":  "Updated Booking Dates")));
              context
                  .read<CheckoutBloc>()
                  .add(CheckoutAddBookingTimes(dates: state.bookingTimes));
              Navigator.of(context).pop();
            }
          },
          child: Column(
            children: [
              BookingDateHeader(title: widget.dates == null ? "Select Date" : "Update Date"),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(AppDimen.screenPadding),
                      child: BlocBuilder<BookingDateCubit, BookingDateState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              CalendarDatePicker2(
                                  config: CalendarDatePicker2Config(
                                    calendarType: CalendarDatePicker2Type.range,
                                    centerAlignModePicker: true,
                                    selectedRangeHighlightColor:
                                        AppColor.selectedRangeColor,
                                    selectedDayHighlightColor:
                                        AppColor.selectedDayColor,
                                    dayBorderRadius: BorderRadius.all(
                                        Radius.circular(AppDimen.smallRadius)),
                                  ),
                                  value: state.bookingTimes,
                                  onValueChanged: (dates) {
                                    context
                                        .read<BookingDateCubit>()
                                        .chooseBookings(dates);
                                  }),
                              MyPrimaryButton(
                                text: "Select",
                                callback: () {
                                  context.read<BookingDateCubit>().selectBookings();
                                },
                                width: double.maxFinite,
                                isEnable:
                                    state.status == BookingDateStatus.ready,
                              ),
                              SizedBox(
                                height: AppDimen.spacing,
                              ),
                              MySecondaryButton(
                                  text: "Cancel",
                                  callback: () {
                                    Navigator.of(context).pop();
                                  },
                                  width: double.maxFinite)
                            ],
                          );
                        },
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
