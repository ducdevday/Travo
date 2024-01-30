import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_project/app/common/widgets/my_skeleton_rectangle.dart';
import 'package:my_project/app/config/app_color.dart';
import 'package:my_project/app/config/app_dimen.dart';
import 'package:my_project/app/config/app_path.dart';

class MyAvatar extends StatelessWidget {
  final String? imgPath;
  final double? size;

  const MyAvatar({Key? key, required this.imgPath, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? AppDimen.smallAvatarSize,
      width: size ?? AppDimen.smallAvatarSize,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: CachedNetworkImage(
          imageUrl: imgPath ?? AppPath.defaultAvatar,
          fit: BoxFit.cover,
          height: size ?? AppDimen.smallAvatarSize,
          width: size ?? AppDimen.smallAvatarSize,
          placeholder: (context, url) => MySkeletonRectangle(
              width: size ?? AppDimen.smallAvatarSize,
              height: size ?? AppDimen.smallAvatarSize),
          errorWidget: (_, __, ___) => Container(
              color: AppColor.unLikedColor,
              child: Icon(
                Icons.error_outline_rounded,
                color: Colors.red,
                size: AppDimen.largeSize,
              )),
        ),
      ),
    );
  }
}
