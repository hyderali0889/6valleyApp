import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geniouscart/Theme/Themes.dart';

Widget DividerList({Widget child,bool showDivider=true,Color color}){
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      child,
      Visibility(visible:showDivider,child: Divider(height: 1,thickness: 1,color: color ?? Themes.Grey.withAlpha(50),))
    ],
  );
}