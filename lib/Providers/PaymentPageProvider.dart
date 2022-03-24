import 'dart:async';

import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/Api_Client2.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPageProvider with ChangeNotifier{
  BuildContext context;
  bool Loading=true;
  final Completer<WebViewController> controller =
  Completer<WebViewController>();

  WebViewController webViewController;

  String webUrl='';
  Map<String,dynamic> data;



  @override
  void dispose() {
    super.dispose();
  }

  void setView(BuildContext context){
    this.context=context;
    data=ModalRoute.of(context).settings.arguments;
    webUrl=data[AppConstant.url];
  }

  void finishLoading(){
    Loading=false;
    notifyListeners();
  }
  void startLoading(){
    Loading=true;
    notifyListeners();
  }


}
