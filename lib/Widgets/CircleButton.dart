
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:flutter/material.dart';

CircleButton({@required Function onTap,@required Widget child,@required bool loading,Color loadingColor}){
  return GestureDetector(
    onTap:loading ? null : onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
      ),
      child: loading ? SizedBox(
        width: 25,
        height: 25,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(loadingColor==null ? Themes.Primary : loadingColor),
          ),
        ),
      ) : child,
    ),
  );
}