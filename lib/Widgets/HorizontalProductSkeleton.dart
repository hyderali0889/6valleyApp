import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/Widgets/GridAnimation.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/SkeletonBuilder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:geniouscart/main.dart';

Widget HorizontalProductSkeleton({@required BuildContext context,int count=5,double height}){

  return Container(
    child: ListView.builder(
      primary: false,
      itemCount: count,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ListAnimation(
            index: index,
            child: SkeletonBuilder(
                child: Container(
                  height: mainHeight*0.15,
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(Dimension.Size_10).copyWith(bottom: 0),
                  padding: EdgeInsets.all(Dimension.Size_10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.transparent,
                      border: Border.all(width: 2)
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: mainHeight*0.125,
                        width: mainHeight*0.125,
                        margin: EdgeInsets.only(right: Dimension.Size_10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Themes.White,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: Dimension.Padding,
                                  width: mainHeight*0.05,
                                  margin: EdgeInsets.only(right: Dimension.Size_10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(Dimension.Padding/2)),
                                    color: Themes.White,
                                  ),
                                ),
                                Container(
                                  height: Dimension.Padding,
                                  width: mainHeight*0.05,
                                  margin: EdgeInsets.only(right: Dimension.Size_10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(Dimension.Padding/2)),
                                    color: Themes.White,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: Dimension.Size_3,),
                            Row(
                              children: [0,1,2,3,4].map((e) => Icon(Icons.star,size: Dimension.Padding,)).toList(),
                            ),
                            Container(
                              height: Dimension.Size_30,
                              width: mainHeight*0.5,
                              margin: EdgeInsets.only(right: Dimension.Size_10,top: Dimension.Size_3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                color: Themes.White,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
            )
        );
      } ,
    ),
  );

}