import 'package:flutter/material.dart';
import 'package:geniouscart/AppHelper/Helper.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';

import '../main.dart';

Widget SocialView(){
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: ()=>Helper.goBrowser(socialSetting.data.facebook),
        child: Container(
          height: mainWidth*0.15,
          width: mainWidth*0.15,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Themes.getColorFromColorCode('#3B5999'),
              shape: BoxShape.circle
          ),
          child: Image.asset('assets/images/facebook.png',color: Colors.white,),
        ),
      ),
      GestureDetector(
        onTap: ()=>Helper.goBrowser(socialSetting.data.gplus),
        child: Container(
          height: mainWidth*0.15,
          width: mainWidth*0.15,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle
          ),
          child: Image.asset('assets/images/google.png'),
        ),
      ),
      GestureDetector(
        onTap: ()=>Helper.goBrowser(socialSetting.data.twitter),
        child: Container(
          height: mainWidth*0.15,
          width: mainWidth*0.15,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              color: Themes.getColorFromColorCode('#55ACEE'),
              shape: BoxShape.circle
          ),
          child: Image.asset('assets/images/twitter.png',color: Colors.white,),
        ),
      ),
      GestureDetector(
        onTap: ()=>Helper.goBrowser(socialSetting.data.linkedin),
        child: Container(
          height: mainWidth*0.15,
          width: mainWidth*0.15,
          padding: EdgeInsets.all(Dimension.Padding),
          margin: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              color: Themes.getColorFromColorCode('#2977B4'),
              shape: BoxShape.circle
          ),
          child: Image.asset('assets/images/linkedin.png',color: Colors.white,),
        ),
      ),
      GestureDetector(
        onTap: ()=>Helper.goBrowser(socialSetting.data.dribble),
        child: Container(
          height: mainWidth*0.15,
          width: mainWidth*0.15,
          padding: EdgeInsets.all(Dimension.Padding),
          margin: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              color: Themes.getColorFromColorCode('#EA4C89'),
              shape: BoxShape.circle
          ),
          child: Image.asset('assets/images/dribble.png',color: Colors.white,),
        ),
      ),
    ],
  );
}