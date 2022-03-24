import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/SkeletonBuilder.dart';
import 'package:flutter/material.dart';
import 'package:geniouscart/main.dart';

Widget MyOrderSkeleton({@required BuildContext context}){
  return ListView.builder(
    primary: false,
    itemCount: 10,
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      return ListAnimation(
          index: index,
          child: SkeletonBuilder(
              child: Container(
                margin: EdgeInsets.all(Dimension.Size_10).copyWith(bottom: 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimension.Size_5),
                    border: Border.all()
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      stops: [0.015, 0.015],
                      colors: [
                        Colors.teal,
                        Colors.transparent
                      ],
                    ),
                  ),
                  padding: EdgeInsets.all(Dimension.Size_10).copyWith(left: Dimension.Padding),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  height: Dimension.Size_20,
                                  width: mainWidth*0.25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimension.Size_10),
                                    border: Border.all()
                                  ),
                                ),
                                SizedBox(width: Dimension.Size_10,),
                                Icon(Icons.copy,color: Themes.Primary,)
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: Dimension.Size_16,
                              width: mainWidth*0.25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimension.Size_8),
                                  border: Border.all()
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimension.Size_5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: Dimension.Size_16,
                            width: mainWidth*0.25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimension.Size_8),
                                border: Border.all()
                            ),
                          ),
                          Container(
                            height: Dimension.Size_16,
                            width: mainWidth*0.25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimension.Size_8),
                                border: Border.all()
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
          )
      );
    } ,
  );
}