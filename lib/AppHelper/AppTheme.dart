import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Route/RouteTransition.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:flutter/material.dart';

AppTheme(){
  return ThemeData(
    primaryColor: Themes.Primary_Lite,
    accentColor: Themes.Primary_Accent,
    primaryColorDark: Themes.Primary,
    primaryColorLight: Themes.Primary_Lite,
    scaffoldBackgroundColor: Themes.Background,
    appBarTheme: AppBarTheme(
      color: Themes.Primary
    ),
    textTheme: TextTheme(
        headline1: TextStyle(
            color: Themes.Text_Color,
            fontSize: Dimension.Text_Size_Big,
            fontWeight: FontWeight.w800),
        headline2: TextStyle(
            color: Themes.Text_Color,
            fontSize: Dimension.Text_Size_Big,
            fontWeight: FontWeight.bold
        ),
        bodyText1: TextStyle(
            color: Themes.Text_Color, fontSize: Dimension.Text_Size,fontWeight: FontWeight.normal),
        bodyText2: TextStyle(
            color: Themes.Text_Color,
            fontSize: Dimension.Text_Size_Small,fontWeight: FontWeight.normal),
        headline6: TextStyle(
            color: Themes.Text_Color,
            fontSize: Dimension.Text_Size_Small_Extra,fontWeight: FontWeight.normal)),
      pageTransitionsTheme: PageTransitionsTheme(builders: {
        TargetPlatform.iOS: RouteTransition(),
        TargetPlatform.android: RouteTransition()
      }),
    fontFamily: AppConstant.font_poppins,
  );
}