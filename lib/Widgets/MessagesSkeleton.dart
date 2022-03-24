import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/SkeletonBuilder.dart';
import 'package:geniouscart/main.dart';
import 'package:flutter/material.dart';

Widget MessaheSkeleton({@required BuildContext context,int count=10}){
  return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: count,
      padding: EdgeInsets.all(0),
      itemBuilder: (context,index){
        return Align(
          alignment: index%2==0 ? Alignment.bottomRight : Alignment.bottomLeft,
          child: SkeletonBuilder(
            child: Container(
              height: 40,
              width: mainWidth*0.4,
              margin: EdgeInsets.only(top: Dimension.Padding),
              decoration: BoxDecoration(
                  border: Border.all(color: Themes.White,width: 2),
                  borderRadius: index%2==0 ? BorderRadius.only(bottomLeft: Radius.circular(20),topLeft: Radius.circular(20),topRight: Radius.circular(20)) :
                  BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20),topLeft: Radius.circular(20))
              ),
            ),
          ),
        );
      }
  );
}