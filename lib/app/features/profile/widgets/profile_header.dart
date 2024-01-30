part of profile;

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoadSuccess) {
          return Stack(
            children: [
              Image.asset(AppPath.imgAppBar),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimen.screenPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${state.user.name}",
                              style: AppStyle.largeHeaderStyle,
                            ),
                            SizedBox(
                              height: AppDimen.spacing,
                            ),
                            const Text(
                              "Check your profile",
                              style: AppStyle.smallTextWhiteStyle,
                            )
                          ],
                        ),
                        MyAvatar(imgPath: state.user.avatar)
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
