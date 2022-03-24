import 'package:flutter_svg/svg.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/SkeletonBuilder.dart';
import 'package:flutter/material.dart';
import 'package:geniouscart/main.dart';
import 'package:websafe_svg/websafe_svg.dart';

Widget SellerSkeleton({@required BuildContext context,int count=5}){
  return ListView.builder(
      shrinkWrap: true,
      itemCount: count,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(0),
      itemBuilder: (context,index){
        return ListAnimation(
          index: index,
          child: SkeletonBuilder(
            child: Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(top: Dimension.Padding,left: Dimension.Padding,right: Dimension.Padding),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Themes.White,width: 2)
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            WebsafeSvg.asset('assets/images/shop.svg',height: 24,width: 24,),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              height: 25,
                              width: mainWidth*0.3,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(12.5),
                                  border: Border.all(color: Themes.White,width: 2)
                              )
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              WebsafeSvg.asset('assets/images/owner.svg',height: 24,width: 24,),
                              Container(
                                  margin: EdgeInsets.only(left: 10),
                                  height: 20,
                                  width: mainWidth*0.4,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Themes.White,width: 2)
                                  )
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              WebsafeSvg.asset('assets/images/shop-address.svg',height: 24,width: 24,),
                              Container(
                                  margin: EdgeInsets.only(left: 10),
                                  height: 16,
                                  width: mainWidth*0.5,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Themes.White,width: 2)
                                  )
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_outline,color: Themes.Red,),
                  )
                ],
              ),
            )
          ),
        );
      }
  );
}