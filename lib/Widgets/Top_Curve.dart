import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:flutter/material.dart';

import '../main.dart';
class Top_Curve extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimension.curve_height,
      alignment: Alignment.center,
      decoration:  BoxDecoration(
        color: Themes.Curve_Color,
        borderRadius:  BorderRadius.vertical(
            bottom:  Radius.elliptical(
                MediaQuery.of(context).size.width, 100.0)),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: Dimension.Padding*2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset('assets/images/logo_transparent.png',height: 30,width: 40,),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(AppConstant.AppName,style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size_Big),),
            )
          ],
        ),
      ),
    );
  }
}
