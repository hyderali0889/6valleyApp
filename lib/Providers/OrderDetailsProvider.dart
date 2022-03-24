import 'dart:async';

import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:geniouscart/Class/SingleOrder.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/Api_Client2.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/main.dart';

class OrderDetailsProvider with ChangeNotifier{
  BuildContext context;
  bool Loading=true;
  String link;
  SingleOrder orderDetails;

  var arg;

  final processes = [
    'Order placed',
    'On review',
    'On delivery',
    'Delivered',
  ];

  final statuses = [
    'pending',
    'processing',
    'on delivery',
    'completed',
    'declined'
  ];
  int processIndex=1;
  Color completeColor = Color(0xff5e6172);
  Color todoColor = Color(0xffd1d2d7);
  bool isCanceled=false;


  @override
  void dispose() {
    super.dispose();
  }

  void setView(BuildContext context){
    this.context=context;
    arg= ModalRoute.of(context).settings.arguments;
    link=arg[AppConstant.details];
    getData();
  }



  Future getData() async {
    Loading=true;
    notifyListeners();
    await ApiClient2.Request(context,
        url: link,
        onSuccess: (data){
          orderDetails=SingleOrder.fromJson(data);
          processIndex=getStatus(orderDetails.data.status);
        },
        onError: (data){
        }
    );
    Loading=false;
    notifyListeners();
  }

  Color getColor(int index) {
    if (index == processIndex) {
      return isCanceled ? Colors.red : Themes.Primary;
    } else if (index < processIndex) {
      return isCanceled ? Colors.red : completeColor;
    } else {
      return isCanceled ? Colors.red : todoColor;
    }
  }

  int getStatus(String status) {
    switch(status){
      case 'pending' :
        return 0;
        break;
      case 'processing' :
        return 1;
        break;
      case 'on delivery' :
        return 2;
        break;
      case 'completed' :
        return 3;
        break;
      case 'declined' :
        isCanceled=true;
        completeColor=Colors.red;
        todoColor=Colors.red;
        return 3;
        break;
      default :
        return 0;
    }
  }
}
