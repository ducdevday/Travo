import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_project/app/common/widgets/my_skeleton.dart';

class MySkeletonRectangle extends MySkeleton {
  final double? radius;
  const MySkeletonRectangle(
      {super.key, required super.width, required super.height, this.radius = 12});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(
          Radius.circular(radius!),
        ),
      ),
    );
  }
}
