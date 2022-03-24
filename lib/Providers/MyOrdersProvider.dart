import 'dart:async';

import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:geniouscart/Class/MyOrders.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/Api_Client2.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/main.dart';

class MyOrdersProvider with ChangeNotifier{
  BuildContext context;
  bool Loading=true;
  MyOrders orders;


  @override
  void dispose() {
    super.dispose();
  }

  void setView(BuildContext context){
    this.context=context;
    getData();
  }



  Future getData() async {
    Loading=true;
    notifyListeners();
    await ApiClient2.Request(context,
        url: URL.Orders,
        onSuccess: (data){
          orders=MyOrders.fromJson(data);
        },
        onError: (data){
        }
    );
    Loading=false;
    notifyListeners();
  }
}
