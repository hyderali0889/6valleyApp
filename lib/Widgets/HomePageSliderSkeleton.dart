import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/Widgets/GridAnimation.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/SkeletonBuilder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:geniouscart/main.dart';

Widget HomePageSliderSkeleton({@required BuildContext context,double height}){

  return ListAnimation(
      index: 0,
      child: SkeletonBuilder(
          child: Center(
            child: Container(
              alignment: Alignment.center,
              height: height,
              width: mainWidth*0.8,
              margin: EdgeInsets.all(Dimension.Padding),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                color: Themes.White
              ),
            ),
          )
      )
  );

}