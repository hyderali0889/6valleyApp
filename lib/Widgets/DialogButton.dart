import 'package:flutter/material.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';

Widget DialogButton({String negativeButton,String positiveButton,Function onTap}){
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      FlatButton(
        child: Text(negativeButton,style: TextStyle(color: Themes.Primary,fontSize: Dimension.Text_Size_Small_Extra,fontWeight: Dimension.textBold),),
        onPressed: ()=>onTap(false),
      ),
      FlatButton(
        child: Text(positiveButton,style: TextStyle(color: Themes.Green,fontSize: Dimension.Text_Size_Small_Extra,fontWeight: Dimension.textBold),),
        onPressed: ()=>onTap(true),
      ),
    ],
  );
}