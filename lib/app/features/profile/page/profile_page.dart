part of profile;

class ProfilePage extends StatelessWidget {
  static const page = 3;

  const ProfilePage({super.key});

  void sendEmail() async {
    const String email = "travo@gmail.com";
    final String subject = "Travo Report";
    final String message = "";
    final url =
        "mailto:$email?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}";

    if (await canLaunch(url)) {
      await launch(
        url,
        enableJavaScript: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ProfileHeader(),
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoadSuccess) {
                return Expanded(
                    child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppDimen.screenPadding),
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Account",
                            style: AppStyle.mediumTextBlackStyle,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          MyCard(
                            padding: AppDimen.spacing,
                            child: Column(
                              children: [
                                SettingItem(
                                  iconData: Icons.account_circle_outlined,
                                  content: "Personal Information",
                                  callback: () {
                                    Navigator.of(context).pushNamed(
                                        PersonalInformationPage.routeName,
                                        arguments: state.user);
                                  },
                                ),
                                const Divider(
                                  height: 1,
                                  indent: 8,
                                ),
                                SettingItem(
                                  iconData: Icons.vpn_key_outlined,
                                  content: "Change Password",
                                  callback: () {
                                    Navigator.of(context).pushNamed(
                                        ForgotPasswordPage.routeName,
                                        arguments: state.user.email);
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                      Text(
                        "General Information",
                        style: AppStyle.mediumTextBlackStyle,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      MyCard(
                        padding: AppDimen.spacing,
                        child: Column(
                          children: [
                            SettingItem(
                              iconData: Icons.local_police_outlined,
                              content: "Policies",
                              callback: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => MyDeveloping()));
                              },
                            ),
                            const Divider(
                              height: 1,
                              indent: 8,
                            ),
                            SettingItem(
                              iconData: Icons.info_outline_rounded,
                              content: "App Version",
                              callback: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => MyDeveloping()));
                              },
                            ),
                            const Divider(
                              height: 1,
                              indent: 8,
                            ),
                            SettingItem(
                              iconData: Icons.help_outline_rounded,
                              content: "About us",
                              callback: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => MyDeveloping()));
                              },
                            ),
                            const Divider(
                              height: 1,
                              indent: 8,
                            ),
                            SettingItem(
                              iconData: Icons.email_outlined,
                              content: "Report & Support",
                              callback: () {
                                sendEmail();
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: MyPrimaryButton(
                            text: "Log out",
                            callback: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext dialogContext) =>
                                      MyConfirmDialog(
                                        title: "Confirm",
                                        content: "Are you sure to Log out",
                                        callbackOK: () {
                                          context.read<UserCubit>().logout();
                                          Navigator.of(context).pop();
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  LoginPage.routeName,
                                                  (route) => false);
                                        },
                                        callbackCancel: () {
                                          Navigator.of(context).pop();
                                        },
                                        confirmText: "Log out",
                                      ));
                            },
                          ))
                    ],
                  ),
                ));
              } else {
                return SizedBox();
              }
            },
          )
        ],
      ),
    );
  }
}
