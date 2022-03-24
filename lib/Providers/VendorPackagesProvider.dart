import 'package:flutter/material.dart';
import 'package:geniouscart/Class/UserPackages.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';

class VendorPackagesProvider with ChangeNotifier{
  BuildContext context;
  bool Loading=true;
  UserPackages userPackages;


  VendorPackagesProvider(){
    getPackages();
  }

  void setView(BuildContext context)=>this.context=context;

  Future getPackages()async{
    Map<String,dynamic> response = await Api_Client.Request(url: URL.VendorPackages);
    try {
      if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
        userPackages=UserPackages.fromJson(response);
      }
      else {
        ErrorMessage(context,message: response[AppConstant.Error]);
      }
    } catch (e) {
      ErrorMessage(context,message: response[AppConstant.Error]);
    }
    Loading=false;
    notifyListeners();
  }
}