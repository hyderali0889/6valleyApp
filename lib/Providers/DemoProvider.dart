import 'dart:async';

import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/Api_Client2.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/main.dart';

class DemoProvider with ChangeNotifier{
  BuildContext context;
  bool Loading=true;


  @override
  void dispose() {
    super.dispose();
  }

  void setView(BuildContext context){
    this.context=context;
  }



  Future getData() async {
    Loading=true;
    notifyListeners();
    await ApiClient2.Request(context,
        url: URL.GetUser,
        onSuccess: (data){

        },
        onError: (data){
        }
    );
    Loading=false;
    notifyListeners();
  }
}
