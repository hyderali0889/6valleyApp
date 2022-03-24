import 'package:flutter/cupertino.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/main.dart';

Widget LoadingView(){
  return Container(
      height: mainHeight,width: mainWidth,
      decoration: BoxDecoration(
        color: Themes.White
      ),
      child: Image.asset('assets/images/loading.gif',height: 120,width: 120,)
  );
}