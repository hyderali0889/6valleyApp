import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/AppConstant.dart';
Widget SwipeRefresh({@required RefreshController controller,@required VoidCallback onRefresh,@required List<Widget> children}){
  return SmartRefresher(
    child:ListView(
      padding: EdgeInsets.all(0),
      children: children,
    ),
    onRefresh: onRefresh,
    //header: AppConstant.swipeIndicator,
    header: WaterDropMaterialHeader(backgroundColor: Themes.Primary),
    enablePullDown: true,
    enablePullUp: false,
    controller: controller,
  );
}