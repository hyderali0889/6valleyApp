import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/SkeletonBuilder.dart';
import 'package:geniouscart/main.dart';
import 'package:flutter/material.dart';

Widget SubCategorySkeleton({@required BuildContext context,int count=5}){
  return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: count,
      padding: EdgeInsets.all(0),
      itemBuilder: (context,index){
        return ListAnimation(
          index: index,
          child: SkeletonBuilder(
            child: Container(
              margin: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding,top: Dimension.Padding),
              decoration: BoxDecoration(
                  border: Border.all(color: Themes.White,width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 20,
                      margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Themes.White,width: 2),
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            )
          ),
        );
      }
  );
}