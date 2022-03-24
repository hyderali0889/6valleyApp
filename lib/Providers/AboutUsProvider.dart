import 'package:flutter/material.dart';
import 'package:geniouscart/Class/AllDetails.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';

class AboutUsProvider with ChangeNotifier{

  BuildContext context;

  bool Loading=true;

  AllDetails allDetails;


  AboutUsProvider(){
    getDetails();
  }

  void setView(BuildContext context)=>this.context=context;

  Future getDetails()async{
    Map<String,dynamic> response = await Api_Client.SimpleRequest(url: URL.All_Details);
    try {
      if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
        allDetails=AllDetails.fromJson(response);
      } else if (response.containsKey(AppConstant.Error)) {
        ErrorMessage(context,message: response[AppConstant.Error]);
      }
    } catch (e) {
      ErrorMessage(context,message: response[AppConstant.Error]);
    }
    Loading=false;
    notifyListeners();
  }

}