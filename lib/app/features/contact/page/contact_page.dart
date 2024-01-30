part of contact;

class ContactPage extends StatefulWidget {
  final GuestModel? guest;
  final CheckoutType type;

  const ContactPage({this.guest, Key? key, required this.type})
      : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  late final FlCountryCodePicker countryPicker;
  CountryCode? countryCode;

  late final TextEditingController nameTextController;
  late final TextEditingController emailTextController;
  late final TextEditingController phoneTextController;

  late ContactCubit _cubit;

  void handleDoneButtonPressed() {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) => MyConfirmDialog(
              title: "Add Contact",
              content: "Are you sure to add this contact",
              callbackOK: () {
                Navigator.of(context).pop(true);
              },
              callbackCancel: () {
                Navigator.of(context).pop();
              },
            )).then((value) {
      if (value != null && value == true) {
        if (widget.guest == null) {
          if (widget.type == CheckoutType.hotel) {
            context.read<CheckoutBloc>().add(CheckoutAddGuest(
                guest: GuestModel(
                    name: nameTextController.text,
                    email: emailTextController.text,
                    country: countryCode!.name,
                    phone: phoneTextController.text)));
          } else if (widget.type == CheckoutType.flight) {
            context.read<CheckoutFlightBloc>().add(CheckoutFlightAddGuest(
                guest: GuestModel(
                    name: nameTextController.text,
                    email: emailTextController.text,
                    country: countryCode!.name,
                    phone: phoneTextController.text)));
          }
        } else {
          if (widget.type == CheckoutType.hotel) {
            context.read<CheckoutBloc>().add(CheckoutUpdateGuest(
                oldGuest: widget.guest!,
                newGuest: GuestModel(
                    name: nameTextController.text,
                    email: emailTextController.text,
                    country: countryCode!.name,
                    phone: phoneTextController.text)));
          } else if (widget.type == CheckoutType.flight) {
            context.read<CheckoutFlightBloc>().add(CheckoutFlightAddGuest(
                guest: GuestModel(
                    name: nameTextController.text,
                    email: emailTextController.text,
                    country: countryCode!.name,
                    phone: phoneTextController.text)));
          }
        }
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    countryCode = CountryCode.fromName(
        widget.guest != null ? widget.guest!.country : 'United States');
    nameTextController = TextEditingController(
        text: widget.guest != null ? widget.guest!.name : null);
    phoneTextController = TextEditingController(
        text: widget.guest != null ? widget.guest!.phone : null);
    emailTextController = TextEditingController(
        text: widget.guest != null ? widget.guest!.email : null);
    _cubit = ContactCubit();
    countryPicker = FlCountryCodePicker(
      title: Container(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: const Text(
            "Select your country",
            style: AppStyle.largeTitleStyle,
          )),
      countryTextStyle: AppStyle.mediumTextBlackStyle,
      dialCodeTextStyle:
      AppStyle.mediumTextBlackStyle.copyWith(color: Colors.black),
      searchBarDecoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelStyle: AppStyle.normalTextBlackStyle,
        hintStyle: AppStyle.normalTextBlackStyle,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        hintText: "Enter Country or Country Code",
      ),
    );

  }

  @override
  void dispose() {
    nameTextController.dispose();
    phoneTextController.dispose();
    emailTextController.dispose();
    super.dispose();
  }

  void handleChooseCountry(CountryCode code) {
    setState(() {
      countryCode = code;
    });
  }

  String? getErrorText(String text, FieldEnum type, [CountryCode? code]) {
    _cubit.checkValidField(nameTextController.text, emailTextController.text,
        phoneTextController.text, countryCode!);
    if (type == FieldEnum.NAME && !ValidateFieldUtil.validateName(text)) {
      return "Name must have >= 2 characters and <= 12 characters, max 2 spaces";
    } else if (type == FieldEnum.EMAIL &&
        !ValidateFieldUtil.validateEmail(text)) {
      return "Email is not valid";
    } else if (type == FieldEnum.PHONE &&
        !ValidateFieldUtil.validatePhone(code!, text)) {
      return text.isEmpty
          ? "Phone can't be empty"
          : "Please enter exactly ${code.code == "VN" ? 9 : code.nationalSignificantNumber} digits.";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _cubit,
        child: Column(
          children: [
            ContactHeader(guest: widget.guest, type: widget.type),
            Expanded(
                child: Padding(
              padding: EdgeInsets.all(AppDimen.screenPadding),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DefaultInputField(
                    title: "Name",
                    hint: "Enter your name",
                    controller: nameTextController,
                    validateField: (String value) =>
                        getErrorText(value, FieldEnum.NAME),
                  ),
                  const SizedBox(
                    height: AppDimen.smallSpacing,
                  ),
                  PhoneInputField(
                    controller: phoneTextController,
                    countryPicker: countryPicker,
                    countryCode: countryCode,
                    chooseCountryCode: (CountryCode code) =>
                        handleChooseCountry(code),
                    validateField: (String value) =>
                        getErrorText(value, FieldEnum.PHONE, countryCode),
                  ),
                  const SizedBox(
                    height: AppDimen.smallSpacing,
                  ),
                  DefaultInputField(
                    title: "Email",
                    hint: "Enter your email",
                    controller: emailTextController,
                    validateField: (String value) =>
                        getErrorText(value, FieldEnum.EMAIL),
                  ),
                  Text(
                    "E-ticket will be sent to your E-mail",
                    style: AppStyle.smallTextBlackStyle
                        .copyWith(color: AppColor.headingColor),
                  ),
                  const SizedBox(
                    height: AppDimen.smallSpacing,
                  ),
                  BlocBuilder<ContactCubit, ContactState>(
                    builder: (context, state) {
                      return MyPrimaryButton(
                        text: "Done",
                        isEnable: state is ContactReady ? true : false,
                        callback: () {
                          handleDoneButtonPressed();
                        },
                      );
                    },
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
