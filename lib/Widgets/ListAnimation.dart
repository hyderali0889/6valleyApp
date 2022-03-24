import 'package:geniouscart/URL/AppConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

ListAnimation({@required Widget child,@required int index}){
  return AnimationConfiguration.staggeredList(
    position: index,
    duration: Duration(milliseconds: AppConstant.AnimationDelay),
    child: SlideAnimation(
      verticalOffset: 50.0,
      child: FadeInAnimation(
        child: child,
  )));
}