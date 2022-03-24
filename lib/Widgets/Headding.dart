import 'package:flutter/material.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';

Widget Headding({String title,double width}){
  return Container(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding,top: 10,bottom: 5),
          child: Text(title,style: TextStyle(fontSize: Dimension.Text_Size,fontWeight: FontWeight.bold,color: Themes.Text_Color),),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Divider(thickness: 2,height: 2,),
            Positioned(
              width: width,
              height: 2,
              left: Dimension.Padding,
              child: Container(
                color: Themes.Primary,
              ),
            ),
          ],
        )
      ],
    ),
  );
}