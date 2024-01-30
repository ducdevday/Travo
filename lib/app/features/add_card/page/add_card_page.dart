part of add_card;

class AddCardPage extends StatefulWidget {
  final CardModel? card;
  final CheckoutType type;

  const AddCardPage({this.card, Key? key, required this.type})
      : super(key: key);

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  late final FlCountryCodePicker countryPicker;
  CountryCode? countryCode;

  late final TextEditingController nameTextController;
  late final TextEditingController countryTextController;
  late final TextEditingController cardNumberTextController;
  late final TextEditingController expireDateTextController;
  late final TextEditingController cvvTextController;

  late AddCardCubit _cubit;

  @override
  void initState() {
    super.initState();
    countryCode = CountryCode.fromName(
        widget.card != null ? widget.card!.country : 'United States');
    nameTextController = TextEditingController(text: widget.card?.name);
    countryTextController = TextEditingController(text: countryCode!.name);
    cardNumberTextController = TextEditingController(text: widget.card?.number);
    expireDateTextController =
        TextEditingController(text: widget.card?.expDate);
    cvvTextController = TextEditingController(text: widget.card?.cvv);

    _cubit = AddCardCubit();
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

    if (widget.card != null) {
      checkValidAllField();
    }
  }

  void checkValidAllField() {
    _cubit.checkValidField(
        nameTextController.text,
        countryTextController.text,
        cardNumberTextController.text,
        expireDateTextController.text,
        cvvTextController.text);
  }

  @override
  void dispose() {
    nameTextController.dispose();
    countryTextController.dispose();
    cardNumberTextController.dispose();
    expireDateTextController.dispose();
    cvvTextController.dispose();
    super.dispose();
  }

  void handleChooseCountry(CountryCode code) {
    setState(() {
      countryCode = code;
      countryTextController.text = countryCode!.name;
    });
  }

  String? getErrorText(String text, FieldEnum type, [CountryCode? code]) {
    checkValidAllField();

    if (type == FieldEnum.NAME && !ValidateFieldUtil.validateName(text)) {
      return "Name must have >= 2 characters and <= 12 characters, max 2 spaces";
    } else if (type == FieldEnum.COUNTRY &&
        !ValidateFieldUtil.validateCountry(text)) {
      return "Country can't be empty";
    } else if (type == FieldEnum.CARD_NUMBER &&
        !ValidateFieldUtil.validateCardNum(text)) {
      return "Card Number invalid";
    } else if (type == FieldEnum.EXP_DATE &&
        !ValidateFieldUtil.validateDate(text)) {
      return "Exp Date invalid";
    } else if (type == FieldEnum.CVV && !ValidateFieldUtil.validateCVV(text)) {
      return "CVV invalid";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _cubit,
        child: BlocListener<AddCardCubit, AddCardState>(
          listener: (context, state) {
            if (state is AddCardSuccess) {
              if (widget.type == CheckoutType.hotel) {
                context.read<CheckoutBloc>().add(CheckoutAddCard(
                    card: CardModel(
                        name: nameTextController.text,
                        number: cardNumberTextController.text,
                        expDate: expireDateTextController.text,
                        cvv: cvvTextController.text,
                        country: countryTextController.text)));
              } else {
                context.read<CheckoutFlightBloc>().add(CheckoutFlightAddCard(
                    card: CardModel(
                        name: nameTextController.text,
                        number: cardNumberTextController.text,
                        expDate: expireDateTextController.text,
                        cvv: cvvTextController.text,
                        country: countryTextController.text)));
              }
              EasyLoading.showSuccess("Success");
              Navigator.of(context).pop();
            }
          },
          child: Column(
            children: [
              AddCardHeader(
                  title: widget.card == null ? "Add Card" : "Update Card"),
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
                    CountryInputField(
                      controller: countryTextController,
                      countryPicker: countryPicker,
                      chooseCountryCode: (CountryCode code) =>
                          handleChooseCountry(code),
                      countryCode: countryCode,
                      validateField: (String value) =>
                          getErrorText(value, FieldEnum.COUNTRY),
                    ),
                    const SizedBox(
                      height: AppDimen.smallSpacing,
                    ),
                    CardNumberInputField(
                      title: "Card Number",
                      hint: "Enter your card number",
                      controller: cardNumberTextController,
                      validateField: (String value) =>
                          getErrorText(value, FieldEnum.CARD_NUMBER),
                    ),
                    const SizedBox(
                      height: AppDimen.smallSpacing,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ExpireDateInputField(
                            title: "Exp. Date",
                            hint: "MM/YY",
                            controller: expireDateTextController,
                            validateField: (String value) =>
                                getErrorText(value, FieldEnum.EXP_DATE),
                          ),
                        ),
                        SizedBox(
                          width: AppDimen.smallPadding,
                        ),
                        Expanded(
                          child: CvvInputField(
                            title: "CVV",
                            hint: "XXX",
                            controller: cvvTextController,
                            validateField: (String value) =>
                                getErrorText(value, FieldEnum.COUNTRY),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: AppDimen.smallSpacing,
                    ),
                    BlocBuilder<AddCardCubit, AddCardState>(
                      builder: (context, state) {
                        return MyPrimaryButton(
                          text:
                              widget.card == null ? "Add Card" : "Update Card",
                          callback: () {
                            context.read<AddCardCubit>().addCard();
                          },
                          isEnable: state is AddCardReady ? true : false,
                        );
                      },
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
