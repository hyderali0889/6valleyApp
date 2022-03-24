import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/SkeletonBuilder.dart';
import 'package:flutter/material.dart';

Widget BlogSkeleton({@required BuildContext context,int count=5}){
  return ListView.builder(
      shrinkWrap: true,
      itemCount: count,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(0),
      itemBuilder: (context,index){
        return ListAnimation(
          index: index,
          child: SkeletonBuilder(
            child: Container(
              margin: EdgeInsets.only(top: Dimension.Padding,left: Dimension.Padding,right: Dimension.Padding),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Themes.White,width: 2)
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Themes.White,width: 2)
                        ),
                      ),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Themes.White,width: 2)
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 30,
                    margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Themes.White,width: 2)
                    ),
                  ),
                  Container(
                    height: 60,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Themes.White,width: 2)
                    ),
                  ),
                ],
              ),
            )
          ),
        );
      }
  );
}