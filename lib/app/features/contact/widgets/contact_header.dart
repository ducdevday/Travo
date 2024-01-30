part of contact;

class ContactHeader extends StatelessWidget {
  final GuestModel? guest;
  final CheckoutType type;

  const ContactHeader({Key? key, this.guest, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AppPath.imgAppBar,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Column(
          children: [
            const SizedBox(
              height: AppDimen.headerMargin,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimen.screenPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_rounded, size: 20),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                    ),
                  ),
                  Text(
                    guest == null ? "Contact Details" : "Update Contact",
                    style: AppStyle.largeHeaderStyle,
                  ),
                  buildDeleteButton(context, guest, type)
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget buildDeleteButton(
      BuildContext context, GuestModel? guest, CheckoutType type) {
    if (guest != null && type == CheckoutType.hotel) {
      return IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext contextDialog) => MyConfirmDialog(
                  title: "",
                  content: "Delete this contact",
                  callbackOK: () {
                    context
                        .read<CheckoutBloc>()
                        .add(CheckoutDeleteGuest(guest: guest));
                    Navigator.of(context).pop(true);
                  },
                  callbackCancel: () {
                    Navigator.of(context).pop();
                  })).then((value) {
            if (value != null && value == true) {
              Navigator.of(context).pop(true);
            }
          });
        },
        icon: const Icon(Icons.delete_outline_rounded, size: 20),
        style: IconButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
        ),
      );
    } else {
      return SizedBox(
        width: 20,
      );
    }
  }
}
