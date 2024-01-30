part of home;

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

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
                              "Hi, ${state.user.name}",
                              style: AppStyle.largeHeaderStyle,
                            ),
                            SizedBox(
                              height: AppDimen.spacing,
                            ),
                            const Text(
                              "Where are you going next?",
                              style: AppStyle.smallTextWhiteStyle,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Stack(
                              children: [
                                SvgPicture.asset(
                                  AppPath.icNotification,
                                  width: 24,
                                  height: 24,
                                )
                              ],
                            ),
                            const SizedBox(
                              width: AppDimen.spacing * 2,
                            ),
                            InkWell(
                                onTap: () {
                                  context.read<MyBottomNavBarCubit>().selectPage(ProfilePage.page);
                                },
                                child: MyAvatar(imgPath: state.user.avatar))
                          ],
                        )
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
