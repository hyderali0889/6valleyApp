import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/Widgets/GridAnimation.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/SkeletonBuilder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

Widget HomeFeaturedProductSkeleton({@required BuildContext context,int count=5,double height}){

  return Container(
    height: 200,
    child: ListView.builder(
      primary: false,
      itemCount: count,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return ListAnimation(
            index: index,
            child: SkeletonBuilder(
                child: Container(
                  height: 180,
                  width: 160,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 10,top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Themes.White
                  ),
                )
            )
        );
      } ,
    ),
  );

}