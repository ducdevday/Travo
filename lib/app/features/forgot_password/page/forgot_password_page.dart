part of forgot_password;

class ForgotPasswordPage extends StatefulWidget {
  static const String routeName = '/forgot_password';

  final String? email;

  const ForgotPasswordPage({Key? key, this.email}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late final TextEditingController emailTextController;
  late ForgotPasswordCubit _cubit;

  @override
  void initState() {
    super.initState();
    emailTextController = TextEditingController(text: widget.email);
    _cubit =
        ForgotPasswordCubit(authRepository: context.read<AuthRepository>());

    checkValidAllField();
  }

  void checkValidAllField() {
    _cubit.checkValidField(emailTextController.text);
  }

  String? getErrorText(
    String text,
    FieldEnum type,
  ) {
    checkValidAllField();
    if (type == FieldEnum.EMAIL && !ValidateFieldUtil.validateEmail(text)) {
      return "Email is not valid";
    }
    return null;
  }

  @override
  void dispose() {
    emailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocProvider(
        create: (context) => _cubit,
        child: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {
            if (state is ForgotPasswordInProgress) {
              EasyLoading.show(maskType: EasyLoadingMaskType.black);
            } else if (state is ForgotPasswordSuccess) {
              EasyLoading.dismiss();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                      "Password reset link have already send to your email!")));
              Navigator.of(context).pop();
            } else if (state is ForgotPasswordFailure) {
              EasyLoading.dismiss();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content:
                      Text(state.message ?? "Send Fail. Please try again")));
            }
          },
          child: Column(
            children: [
              const AuthHeader(
                  title: "Forgot Password",
                  content: "You’ll get messages soon on your e-mail address"),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimen.screenPadding),
                  child: Column(
                    children: [
                      DefaultInputField(
                        isEnable: widget.email == null,
                        title: "Email",
                        hint: "Enter your email",
                        controller: emailTextController,
                        validateField: (String value) =>
                            getErrorText(value, FieldEnum.EMAIL),
                      ),
                      const SizedBox(
                        height: AppDimen.spacing,
                      ),
                      BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                        builder: (context, state) {
                          return MyPrimaryButton(
                            width: double.infinity,
                            text: "Send",
                            isEnable: state is ForgotPasswordReady ? true : false,
                            callback: () {
                              showDialog(
                                  context: context,
                                  builder:
                                      (BuildContext dialogContext) =>
                                      MyConfirmDialog(
                                        title: "",
                                        content:
                                        "We will send reset link into your email",
                                        callbackOK: () {
                                          Navigator.of(context)
                                              .pop(true);
                                        },
                                        callbackCancel: () {
                                          Navigator.of(context)
                                              .pop();
                                        },
                                      )).then((value) {
                                if (value != null && value == true) {
                                  context
                                      .read<ForgotPasswordCubit>()
                                      .sendLinkResetPassword(
                                      emailTextController.text);
                                }
                              });
                            },
                          );
                        },
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
