import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';
import 'package:geniouscart/main.dart';
import 'package:url_launcher/url_launcher.dart';

enum ServerDateTime { Date, Time}

class Helper{
  static bool newProduct;

  //static PhoneVerificationArguments phoneVerificationArguments;

  
  static String getDateTime(String datetime,{ServerDateTime serverDateTime=ServerDateTime.Date,bool withYear=false}){
    List<String> data=datetime.split(" ");
    if(serverDateTime==ServerDateTime.Date){
        List date=data[0].split("-");
        return '${date[2]} ${language.Months[int.parse(date[1])-1]}${withYear ? ',${date[0]}' : ''}';
    }
    else{
      List time=data[1].split(":");
      int hour=int.parse(time[0]);
      bool isPm=hour>12;
      return '${isPm ? hour-12 : hour}:${time[1]} ${isPm ? 'PM' : "AM"}';
    }
  }

  static goBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static copyText({@required BuildContext context,@required String text,String message}){
    Clipboard.setData(new ClipboardData(text: text));
    SuccessMessage(context,message: message ?? language.Copied_Successfully);
  }
}