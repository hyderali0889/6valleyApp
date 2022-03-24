import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/SkeletonBuilder.dart';
import 'package:flutter/material.dart';

Widget FaqSkeleton({@required BuildContext context,int count=5}){
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
              height: 60,
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(top: Dimension.Padding,left: Dimension.Padding,right: Dimension.Padding),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Themes.White,width: 2)
              ),
              child: Icon(Icons.keyboard_arrow_down,size: 30,),
            )
          ),
        );
      }
  );
}