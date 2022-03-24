import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/SkeletonBuilder.dart';
import 'package:flutter/material.dart';

import '../main.dart';

Widget OrderSkeleton({@required BuildContext context,int count=5}){
  return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: count,
      padding: EdgeInsets.all(0),
      itemBuilder: (context,index){
        return ListAnimation(
          index: index,
          child: SkeletonBuilder(
            child: Container(
              margin: EdgeInsets.only(
                  top: Dimension.Padding,
                  left: Dimension.Padding,
                  right: Dimension.Padding),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: mainWidth * 0.2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            height: 10,
                            width: (mainWidth*0.2)/2,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                          ),
                          Container(
                            height: 10,
                            margin: EdgeInsets.only(top: 5),
                            width: (mainWidth*0.2)*0.75,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(color: Colors.white,width: 1,height: 70,),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                            right: Dimension.Padding, left: 10,),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 12,
                              width: mainWidth*0.25,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.all(Radius.circular(6))
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  color: Themes.Icon_Color,
                                  size: Dimension.Text_Size_Small + 2,
                                ),
                                Container(
                                  height: 10,
                                  width: mainWidth*0.25,
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.all(Radius.circular(5))
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(language.Payment_Via,
                                  style: Theme.of(context).textTheme.bodyText2),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          right: Dimension.Padding, left: 5, top: 10, bottom: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(language.Price,
                              style: TextStyle(
                                  color: Themes.Text_Color,
                                  fontSize: Dimension.Text_Size_Small)),
                          Container(
                            height: 10,
                            margin: EdgeInsets.only(top: 5),
                            width: (mainWidth*0.2)/2,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                          ),
                          Container(
                            height: 10,
                            margin: EdgeInsets.only(top: 5),
                            width: (mainWidth*0.2)/2,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ),
        );
      }
  );
}