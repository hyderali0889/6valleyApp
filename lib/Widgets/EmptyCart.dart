import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/main.dart';
import 'package:flutter/material.dart';

Widget EmptyCart(){
  return Container(
    width: mainWidth,
    height: 300,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset('assets/images/empty-cart.png',),
        Text(language.Your_Cart_is_Empty,style: TextStyle(color: Themes.Text_Color.withAlpha(Dimension.Alpha),fontSize: Dimension.Text_Size_Big,fontWeight: FontWeight.bold),),
      ],
    ),
  );
}