import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/Widgets/GridAnimation.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/SkeletonBuilder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:geniouscart/main.dart';

Widget ServiceSkeleton({@required BuildContext context,int count=5}){

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
                height: 65,
                margin: EdgeInsets.only(bottom: Dimension.Padding),
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Themes.White,width: 2)
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(color: Themes.White,width: 2)
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(7.5),
                                border: Border.all(color: Themes.White,width: 2)
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
          )
      );
    } ,
  );

}