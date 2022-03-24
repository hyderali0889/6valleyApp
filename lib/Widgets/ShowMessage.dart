import 'package:flutter/cupertino.dart';
import 'package:geniouscart/Packege/FlushBar/flushbar.dart';
import 'package:geniouscart/Packege/FlushBar/flushbar_helper.dart';
import 'package:geniouscart/main.dart';

void SuccessMessage(BuildContext context,{String message=''}){
    FlushbarHelper.createSuccess(
    message: message.runtimeType == String ? message : language.Something_went_wrong, position: FlushbarPosition.TOP)
    ..show(context);
}
void ErrorMessage(BuildContext context,{var message=''}){
  FlushbarHelper.createError(
      message: message.runtimeType == String ? message : language.Something_went_wrong, position: FlushbarPosition.TOP)
    ..show(context);
}