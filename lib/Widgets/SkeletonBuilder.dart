import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Packege/Skeleton/Skeleton.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:flutter/material.dart';

Widget SkeletonBuilder({Widget child}){
  return Skeleton.fromColors(
    baseColor: Themes.White,
    highlightColor: Themes.White.withAlpha(50),
    child: child,
  );
}