import 'package:flutter/material.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';

Widget DefaultCartIcon({@required String quentity,Function onTap,Color iconColor}){
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 50,
      width: 35,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.shopping_cart,color: iconColor!=null ? iconColor : Themes.Icon_Color ,),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Themes.Red
              ),
              child: Text(quentity,style: TextStyle(color: Themes.White,fontSize: Dimension.Text_Size_Small_Extra,fontWeight: Dimension.textNormal),),
            ),
          ),
        ],
      ),
    ),
  );
}