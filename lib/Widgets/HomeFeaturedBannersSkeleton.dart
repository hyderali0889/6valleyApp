import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/Widgets/GridAnimation.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/SkeletonBuilder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

Widget HomeFeaturedBannersSkeleton({@required BuildContext context,int count=5,int column=2}){

  return StaggeredGridView.countBuilder(
    primary: false,
    itemCount: count,
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    padding: EdgeInsets.only(left: 10,right: 10,top: 10),
    crossAxisCount: 4,
    mainAxisSpacing: 10.0,
    crossAxisSpacing: 10.0,
    itemBuilder: (context, index) {
      return GridAnimation(
          index: index,
          column: column,
          child: SkeletonBuilder(
              child: Container(
                height: 100,
                alignment: Alignment.center,
                padding: EdgeInsets.all(Dimension.Padding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Themes.White
                ),
              )
          )
      );
    } ,
    staggeredTileBuilder: (index) =>  StaggeredTile.fit(2),
  );

}