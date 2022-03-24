import 'package:flutter/material.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/main.dart';

Widget DefaultBackButton(BuildContext context){
  return Positioned(
    left: 0,
    top: paddingTop,
    child: IconButton(
      onPressed: ()=>Navigator.of(context).pop(),
      icon: Icon(Icons.arrow_back_ios,color: Themes.Icon_Color,),
    ),
  );
}