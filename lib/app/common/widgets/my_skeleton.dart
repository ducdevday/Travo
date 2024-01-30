import 'package:flutter/material.dart';

abstract class MySkeleton extends StatelessWidget {
  final double width;
  final double height;

  const MySkeleton(
      {Key? key,
        required this.width,
        required this.height})
      : super(key: key);
}