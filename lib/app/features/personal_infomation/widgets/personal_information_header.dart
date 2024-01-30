part of personal_information;

class PersonalInformationHeader extends StatefulWidget {
  final String? avatar;
  final Function(String imgPath) setAvatar;
  final bool showBackButton;

  const PersonalInformationHeader(
      {Key? key,
      required this.avatar,
      this.showBackButton = true,
      required this.setAvatar})
      : super(key: key);

  @override
  State<PersonalInformationHeader> createState() =>
      _PersonalInformationHeaderState();
}

class _PersonalInformationHeaderState extends State<PersonalInformationHeader> {
  late String? avatar;

  @override
  void initState() {
    super.initState();
    avatar = widget.avatar;
  }

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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  buildBackButton(context),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Update Profile",
                      style: AppStyle.largeHeaderStyle,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: AppDimen.spacing,
            ),
            Stack(
              children: [
                MyAvatar(
                  imgPath: avatar,
                  size: AppDimen.largeAvatarSize,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.secondaryColor,
                      ),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) =>
                                  MyConfirmDialog(
                                    title: "Upload Your Avatar",
                                    content: "Choose From",
                                    cancelText: "Gallery",
                                    confirmText: "Camera",
                                    callbackOK: () async {
                                      Navigator.of(dialogContext).pop();
                                      String? path = await context
                                          .read<PersonalInformationCubit>()
                                          .uploadAvatarUserFromCamera();
                                      if (path != null) {
                                        setState(() {
                                          avatar = path;
                                          widget.setAvatar(path);
                                        });
                                      }
                                    },
                                    callbackCancel: () async {
                                      Navigator.of(dialogContext).pop();
                                      String? path = await context
                                          .read<PersonalInformationCubit>()
                                          .uploadAvatarUserFromGallery();
                                      if (path != null) {
                                        setState(() {
                                          avatar = path;
                                          widget.setAvatar(path);
                                        });
                                      }
                                    },
                                  ));
                        },
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: AppDimen.smallSize,
                          color: AppColor.primaryColor,
                        ),
                      )),
                )
              ],
            )
          ],
        )
      ],
    );
  }

  Widget buildBackButton(BuildContext context) {
    if (widget.showBackButton) {
      return Align(
        alignment: Alignment.centerLeft,
        child: IconButton(
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
      );
    }
    return SizedBox();
  }
}
