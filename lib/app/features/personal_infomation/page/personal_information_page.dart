part of personal_information;

class PersonalInformationPage extends StatefulWidget {
  static const String routeName = "/personal_information";
  final UserModel user;

  const PersonalInformationPage({Key? key, required this.user})
      : super(key: key);

  @override
  State<PersonalInformationPage> createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  late final FlCountryCodePicker countryPicker;
  CountryCode? countryCode;
  String? avatar;
  late final TextEditingController nameTextController;
  late final TextEditingController emailTextController;
  late final TextEditingController phoneTextController;
  late final TextEditingController countryTextController;

  late PersonalInformationCubit _cubit;

  @override
  void initState() {
    super.initState();
    countryCode = CountryCode.fromName(widget.user.country);
    avatar = widget.user.avatar;
    nameTextController = TextEditingController(text: widget.user.name);
    countryTextController = TextEditingController(text: countryCode?.name);
    phoneTextController = TextEditingController(text: widget.user.phoneNumber);
    emailTextController = TextEditingController(text: widget.user.email);
    _cubit = PersonalInformationCubit(
        userRepository: context.read<UserRepository>());
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

    checkAllValidField();
  }

  @override
  void dispose() {
    nameTextController.dispose();
    countryTextController.dispose();
    phoneTextController.dispose();
    emailTextController.dispose();
    super.dispose();
  }

  void handleChooseCountry(CountryCode code) {
    setState(() {
      countryCode = code;
      countryTextController.text = code.name;
    });
  }

  void setAvatar(String imgPath) {
    avatar = imgPath;
    // checkAllValidField();
  }

  void checkAllValidField() {
    _cubit.checkValidField(nameTextController.text, emailTextController.text,
        countryTextController.text, phoneTextController.text, countryCode!);
  }

  String? getErrorText(String text, FieldEnum type, [CountryCode? code]) {
    checkAllValidField();
    if (type == FieldEnum.NAME && !ValidateFieldUtil.validateName(text)) {
      return "Name must have >= 2 characters and <= 12 characters, max 2 spaces";
    } else if (type == FieldEnum.EMAIL &&
        !ValidateFieldUtil.validateEmail(text)) {
      return "Email is not valid";
    } else if (type == FieldEnum.COUNTRY &&
        !ValidateFieldUtil.validateCountry(text)) {
      return "Country can't be empty";
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
      resizeToAvoidBottomInset: true,
      body: BlocProvider(
        create: (context) => _cubit,
        child: BlocListener<PersonalInformationCubit, PersonalInformationState>(
          listener: (context, state) {
            checkAllValidField();
            switch (state) {
              case PersonalInformationLoadInProcess():
                EasyLoading.show(maskType: EasyLoadingMaskType.black);
              case PersonalInformationUploadImageSuccess():
                EasyLoading.dismiss();
              case PersonalInformationLoadFailure():
                EasyLoading.dismiss();
                EasyLoading.showError(
                    state.message ?? "Something went wrong! Please try again");
              case PersonalInformationUpdateSuccess():
                context.read<UserCubit>().updateUser(UserModel(
                    avatar: avatar,
                    name: nameTextController.text,
                    email: emailTextController.text,
                    country: countryTextController.text,
                    phoneNumber: phoneTextController.text));
                EasyLoading.dismiss();
                EasyLoading.showSuccess("Update Profile Success");
                Navigator.of(context).pop();
            }
          },
          child: Column(
            children: [
              PersonalInformationHeader(avatar: avatar, setAvatar: setAvatar),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppDimen.screenPadding),
                  child: ListView(
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
                      DefaultInputField(
                        isEnable: false,
                        title: "Email",
                        hint: "Enter your email",
                        controller: emailTextController,
                        validateField: (String value) =>
                            getErrorText(value, FieldEnum.EMAIL),
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
                      BlocBuilder<PersonalInformationCubit,
                          PersonalInformationState>(
                        builder: (context, state) {
                          return MyPrimaryButton(
                            text: "Update",
                            isEnable: state is PersonalInformationReady
                                ? true
                                : false,
                            callback: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext dialogContext) =>
                                      MyConfirmDialog(
                                        title: "Update Profile",
                                        content: "Are you sure to update",
                                        callbackOK: () {
                                          Navigator.of(context).pop(true);
                                        },
                                        callbackCancel: () {
                                          Navigator.of(context).pop();
                                        },
                                      )).then((value) {
                                if (value != null && value == true) {
                                  context
                                      .read<PersonalInformationCubit>()
                                      .updateUser(
                                          SharedService.getUserId()!,
                                          UserModel(
                                              avatar: avatar,
                                              name: nameTextController.text,
                                              email: emailTextController.text,
                                              country:
                                                  countryTextController.text,
                                              phoneNumber:
                                                  phoneTextController.text));
                                }
                              });
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: AppDimen.smallSpacing,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
