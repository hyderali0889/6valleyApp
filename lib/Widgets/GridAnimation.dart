import 'package:geniouscart/URL/AppConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

GridAnimation({@required Widget child,@required int index,int column=2}){
  return AnimationConfiguration.staggeredGrid(
    position: index,
    duration: Duration(milliseconds: AppConstant.AnimationDelay),
    columnCount: column,
    child: ScaleAnimation(
      child: FadeInAnimation(
        child: child,
      ),
    ),
  );
}