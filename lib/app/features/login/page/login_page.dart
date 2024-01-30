part of login;

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController emailTextController;
  late final TextEditingController passwordTextController;
  late LoginCubit _cubit;
  @override
  void initState() {
    super.initState();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    _cubit = LoginCubit(authRepository: context.read<AuthRepository>());
  }

  String? getErrorText(
    String text,
    FieldEnum type,
  ) {
    //Todo: Check All Field validator
    _cubit.checkValidField(emailTextController.text, passwordTextController.text);

    if (type == FieldEnum.EMAIL && !ValidateFieldUtil.validateEmail(text)) {
      return "Email is not valid";
    } else if (type == FieldEnum.PASSWORD &&
        !ValidateFieldUtil.validatePassword(text)) {
      return "Password must have greater or equal 6 digits";
    }
    return null;
  }


  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocProvider(
        create: (context) =>
            _cubit,
        child: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginInProgress) {
              EasyLoading.show(maskType: EasyLoadingMaskType.black);
            } else if (state is LoginSuccess) {
              EasyLoading.dismiss();
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Login Success")));
              context.read<UserCubit>().loadUser();
              context.read<MyBottomNavBarCubit>().selectPage(HomePage.page);
              Navigator.of(context).pushNamedAndRemoveUntil(
                  DefaultPage.routeName, (route) => false);
            } else if (state is LoginFailure) {
              EasyLoading.dismiss();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message ?? "Login Fail")));
            }
          },
          child: Column(
            children: [
              const AuthHeader(title: "Login", content: "Hi, Welcome back!", showBackButton: false,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppDimen.screenPadding),
                  child: ListView(
                    children: [
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
                        height: AppDimen.spacing,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: (){
                              Navigator.of(context).pushNamed(ForgotPasswordPage.routeName);
                            },
                            child: Text(
                              "Forgot password?",
                              style: AppStyle.normalTextParagraphStyle,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: AppDimen.spacing,
                      ),
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          return MyPrimaryButton(
                            text: "Log In",
                            isEnable: state is LoginReady ? true : false,
                            callback: () {
                              context.read<LoginCubit>().doLogin(
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
                        text: "or log in with",
                      ),
                      const SizedBox(
                        height: AppDimen.spacing * 2,
                      ),
                      SocialWidget(
                        callbackGoogle: () {},
                        callbackFaceBook: () {},
                      ),
                      const SizedBox(
                        height: AppDimen.spacing,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            style: AppStyle.normalTextParagraphStyle
                                .copyWith(height: 1.5),
                            children: [
                              const TextSpan(
                                text: "Don't have an account? ",
                              ),
                              TextSpan(
                                  text: "Sign Up",
                                  style: AppStyle.normalTextParagraphStyle
                                      .copyWith(color: AppColor.primaryColor,fontWeight: FontWeight.w500),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context)
                                          .pushNamed(SignUpPage.routeName);
                                    }),
                            ]),
                      )
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
