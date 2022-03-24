import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/SkeletonBuilder.dart';
import 'package:geniouscart/main.dart';
import 'package:flutter/material.dart';

Widget UpcommingRequestSkeleton({@required BuildContext context,int count=5}){
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
              margin: EdgeInsets.only(top: Dimension.Padding,left: Dimension.Padding,right: Dimension.Padding),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 50,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.all(Radius.circular(25))
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(right: Dimension.Padding,left: 5),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              height: 15,
                            width: mainWidth*0.2,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.all(Radius.circular(7.5))
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 7),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,color: Themes.Icon_Color,
                                  size: Dimension.Text_Size_Small+2,
                                ),
                                Container(
                                  height: 10,
                                  width: mainWidth*0.3,
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.all(Radius.circular(5))
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 10,
                            width: mainWidth*0.1,
                            margin: EdgeInsets.only(top: 7),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: Dimension.Padding,left: 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(language.Order_Time,style: TextStyle(color: Themes.Text_Color.withAlpha(Dimension.Alpha,),fontSize: Dimension.Text_Size_Small)),
                        Container(
                          height: 10,
                          width: mainWidth*0.15,
                          margin: EdgeInsets.only(top: 5),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                        ),
                      ],
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