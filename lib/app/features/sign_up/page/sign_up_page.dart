part of sign_up;

class SignUpPage extends StatefulWidget {
  static const String routeName = '/signUp';

  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final FlCountryCodePicker countryPicker;
  CountryCode? countryCode;

  late final TextEditingController nameTextController;
  late final TextEditingController emailTextController;
  late final TextEditingController passwordTextController;
  late final TextEditingController phoneTextController;
  late final TextEditingController countryTextController;

  late SignUpCubit _cubit;

  @override
  void initState() {
    super.initState();
    countryCode = CountryCode.fromName('United States');
    nameTextController = TextEditingController();
    countryTextController = TextEditingController(text: countryCode?.name);
    phoneTextController = TextEditingController();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    _cubit = SignUpCubit(authRepository: context.read<AuthRepository>());
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

  void checkValidAllField() {
    _cubit.checkValidField(
        nameTextController.text,
        emailTextController.text,
        passwordTextController.text,
        countryTextController.text,
        phoneTextController.text,
        countryCode!);
  }

  @override
  void dispose() {
    nameTextController.dispose();
    countryTextController.dispose();
    phoneTextController.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  void handleChooseCountry(CountryCode code) {
    setState(() {
      countryCode = code;
      countryTextController.text = code.name;
    });
  }

  String? getErrorText(String text, FieldEnum type, [CountryCode? code]) {
    checkValidAllField();
    if (type == FieldEnum.NAME && !ValidateFieldUtil.validateName(text)) {
      return "Name must have >= 2 characters and <= 12 characters, max 2 spaces";
    } else if (type == FieldEnum.EMAIL &&
        !ValidateFieldUtil.validateEmail(text)) {
      return "Email is not valid";
    } else if (type == FieldEnum.PASSWORD &&
        !ValidateFieldUtil.validatePassword(text)) {
      return "Password must have greater or equal 6 digits";
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
        child: BlocListener<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state is SignUpInProgress) {
              EasyLoading.show(maskType: EasyLoadingMaskType.black);
            } else if (state is SignUpSuccess) {
              EasyLoading.dismiss();
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Sign Up Success")));
              context.read<UserCubit>().loadUser();
              context.read<MyBottomNavBarCubit>().selectPage(HomePage.page);
              Navigator.of(context).pushNamedAndRemoveUntil(
                  DefaultPage.routeName, (route) => false);
            } else if (state is SignUpFailure) {
              EasyLoading.dismiss();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message ?? "Sign Up Fail")));
            }
          },
          child: Column(
            children: [
              const AuthHeader(
                title: "Sign Up",
                content: "Let's create your account",
              ),
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
                        title: "Email",
                        hint: "Enter your email",
                        controller: emailTextController,
                        validateField: (String value) =>
                            getErrorText(value, FieldEnum.EMAIL),
                      ),
                      const SizedBox(
                        height: AppDimen.smallSpacing,
                      ),
                      DefaultInputField(
                        title: "Password",
                        hint: "Enter your password",
                        controller: passwordTextController,
                        validateField: (String value) =>
                            getErrorText(value, FieldEnum.PASSWORD),
                        isPassword: true,
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
                        height: AppDimen.spacing,
                      ),
                      const PolicyText(),
                      const SizedBox(
                        height: AppDimen.spacing,
                      ),
                      BlocBuilder<SignUpCubit, SignUpState>(
                        builder: (context, state) {
                          return MyPrimaryButton(
                            text: "Sign Up",
                            isEnable: state is SignUpReady ? true : false,
                            callback: () {
                              context.read<SignUpCubit>().doSignUp(
                                  nameTextController.text,
                                  countryTextController.text,
                                  phoneTextController.text,
                                  emailTextController.text,
                                  passwordTextController.text);
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: AppDimen.spacing * 2,
                      ),
                      const DividerText(
                        text: "or sign up with",
                      ),
                      const SizedBox(
                        height: AppDimen.spacing * 2,
                      ),
                      SocialWidget(
                        callbackGoogle: () {},
                        callbackFaceBook: () {},
                      ),
                      const SizedBox(
                        height: AppDimen.spacing * 2,
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
