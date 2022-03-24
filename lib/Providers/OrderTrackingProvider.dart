import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geniouscart/Class/OrderTrack.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/Api_Client2.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/main.dart';

class OrderTrackingProvider with ChangeNotifier{
  BuildContext context;
  bool Loading=false;
  OrderTrack orderTrack;
  GlobalKey<FormState> formKey=GlobalKey();
  TextEditingController orderId=TextEditingController();
  String errorMessage;


  @override
  void dispose() {
    super.dispose();
  }

  void setView(BuildContext context){
    this.context=context;
  }



  Future getOrder() async {
    orderTrack=null;
    errorMessage=null;
    Loading=true;
    notifyListeners();
    await ApiClient2.SimpleRequest(context,
        url: URL.Order_Tracking+orderId.text,
        enableShowError: false,
        onSuccess: (data){
          orderTrack=OrderTrack.fromJson(data);
        },
        onError: (data){
          errorMessage = data[AppConstant.error][AppConstant.message];
          //ErrorMessage(context,message: errorMessage);
        }
    );
    Loading=false;
    notifyListeners();
  }

  Color getStatusColor() {
    switch(orderTrack.data[0].title.toLowerCase()){
      case 'pending' :
        return Colors.yellow;
        break;
      case 'processing' :
        return Colors.blue;
        break;
      case 'on delivery' :
        return Colors.orange;
        break;
      case 'completed' :
        return Colors.teal;
        break;
      case 'declined' :
        return Colors.red;
        break;
      default :
        return Colors.yellow;
    }
  }
}
