import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/Widgets/GridAnimation.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/RatingVIew.dart';
import 'package:geniouscart/Widgets/SkeletonBuilder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:geniouscart/main.dart';

Widget VendorProductSkeleton({@required BuildContext context,int count=5}){

  return ListView.builder(
    itemCount: count,
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    padding: EdgeInsets.only(left: 10,right: 10,top: 10),
    itemBuilder: (context, index) {
      return ListAnimation(
          index: index,
          child: SkeletonBuilder(
              child: Container(
                height: 120,
                margin: EdgeInsets.only(bottom: Dimension.Padding),
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Themes.White,width: 2)
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      height: 110,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Themes.White,width: 2)
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 15,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(7.5),
                                    border: Border.all(color: Themes.White,width: 2)
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                height: 15,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(7.5),
                                    border: Border.all(color: Themes.White,width: 2)
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Row(
                              children: [1,2,3,4,5].map((e) => Icon(Icons.star,size: 14,)).toList(),
                            ),
                          ),
                          Container(
                            height: 35,
                            margin: EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(7.5),
                                border: Border.all(color: Themes.White,width: 2)
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
          )
      );
    } ,
  );

}