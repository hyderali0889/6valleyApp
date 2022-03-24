import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/Widgets/GridAnimation.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/SkeletonBuilder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:geniouscart/main.dart';

Widget WithdrawSkeleton({@required BuildContext context,int count=5}){

  return ListView.builder(
    itemCount: count,
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    padding: EdgeInsets.only(left: 10,right: 10,top: 10),
    itemBuilder: (context, index) {
      return ListAnimation(
          index: index,
          child: SkeletonBuilder(
              child: Container(
                padding: EdgeInsets.all(10).copyWith(left: Dimension.Padding),
                margin: EdgeInsets.only(bottom: Dimension.Padding),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      stops: [0.015, 0.015], colors: [Colors.white, Colors.transparent]),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Themes.White,width: 2)
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 20,
                            width: mainWidth*0.5,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Themes.White,width: 2)
                            ),
                          ),
                          Container(
                            height: 15,
                            margin: EdgeInsets.only(top: 5),
                            width: mainWidth*0.7,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(7.5),
                                border: Border.all(color: Themes.White,width: 2)
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 20,
                      width: mainWidth*0.1,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Themes.White,width: 2)
                      ),
                    )                  ],
                ),
              )
          )
      );
    } ,
  );

}