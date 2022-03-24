import 'package:flutter/material.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/main.dart';

import 'ListAnimation.dart';
import 'SkeletonBuilder.dart';

Widget PackagesSkeleton(BuildContext context,{int itemCount=4}){
  return ListView.builder(
    shrinkWrap: true,
    padding: EdgeInsets.all(0),
    itemCount: itemCount,
    physics: NeverScrollableScrollPhysics(),
    itemBuilder: (context,index){
      return ListAnimation(
        index: index,
        child: SkeletonBuilder(
            child: Container(
              margin: EdgeInsets.only(top: Dimension.Padding,left: Dimension.Padding,right: Dimension.Padding),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Themes.White,width: 2)
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 30,
                    width: mainWidth*0.5,
                    margin: EdgeInsets.only(top: Dimension.Padding,bottom: Dimension.Padding),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Themes.White,width: 2)
                    ),
                  ),
                  Container(
                    height: 120,
                    width: 120,
                    margin: EdgeInsets.only(bottom: Dimension.Padding),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(color: Themes.White,width: 2)
                    ),
                  ),
                  Container(
                    height: 120,
                    width: mainWidth*0.8,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Themes.White,width: 2)
                    ),
                  ),
                  Container(
                    width: 120,
                    margin: EdgeInsets.only(bottom:Dimension.Padding,top: Dimension.Padding),
                    alignment: Alignment.center,
                    height: 40,
                    child: Text(language.Get_Started,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.White),),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Themes.White,width: 2)
                    ),
                  )
                ],
              ),
            )
        ),
      );
    }
  );
}