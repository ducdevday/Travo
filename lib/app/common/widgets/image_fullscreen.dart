import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_project/app/common/widgets/my_skeleton_rectangle.dart';
import 'package:my_project/app/config/app_color.dart';
import 'package:my_project/app/config/app_dimen.dart';

class ImageFullScreen extends StatelessWidget {
  final String imgPath;

  const ImageFullScreen({
    required this.imgPath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(children: [
          Center(
            child: CachedNetworkImage(
              imageUrl: imgPath,
              placeholder: (context, url) => MySkeletonRectangle(
                  width: double.infinity, height: double.infinity),
              errorWidget: (_, __, ___) => Container(
                  color: AppColor.unLikedColor,
                  child: Icon(
                    Icons.error_outline_rounded,
                    color: Colors.red,
                    size: AppDimen.largeSize,
                  )),
            ),
          ),
          Positioned(
            top: AppDimen.headerMargin,
            left: AppDimen.screenPadding,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close, size: 20),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
