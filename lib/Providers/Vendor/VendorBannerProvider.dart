import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geniouscart/Class/Withdraw.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/GetImage.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';

class VendorBannerProvider with ChangeNotifier{
  BuildContext context;
  bool Loading=false;
  File image;

  VendorBannerProvider();

  void setView(BuildContext context)=> this.context=context;

  void getWithdraw()async{
    Loading=true;
    notifyListeners();
    Map<String,dynamic> response = await Api_Client.Request(url: URL.VendorWithdraw);
    try {
      if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {

      } else if (response.containsKey(AppConstant.Error)) {
        ErrorMessage(context,message: response[AppConstant.Error]);
      }
    } catch (e) {
      ErrorMessage(context,message: response[AppConstant.Error]);
    }
    Loading=false;
    notifyListeners();
  }

  void refreshData(){
    Loading=true;
    notifyListeners();
    getWithdraw();
  }

  void setImage()async{
    File img=await getImage(context);
    if(img!=null){
      image=img;
      notifyListeners();
    }
  }
}