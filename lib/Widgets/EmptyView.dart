import 'package:websafe_svg/websafe_svg.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/main.dart';
import 'package:flutter/material.dart';

Widget EmptyView({String image='assets/images/empty.gif',Widget message,bool isSVG=false}){
  return Container(
    width: mainWidth,
    height: 300,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        isSVG ? WebsafeSvg.asset(image,height: 200,) :Image.asset(image,height: 200,),
        message==null ? Text(language.No_data_here,style: TextStyle(color: Themes.Grey,fontSize: Dimension.Text_Size_Big,fontWeight: FontWeight.bold),) : message,
      ],
    ),
  );
}