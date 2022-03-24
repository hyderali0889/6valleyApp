import 'package:flutter/material.dart';
import 'package:geniouscart/Class/VendorDashboard.dart';
import 'package:geniouscart/Providers/AccountProvider.dart';
import 'package:geniouscart/URL/Api_Client2.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';

import '../../main.dart';

class VendorSocialLinksProvider with ChangeNotifier{
  BuildContext context;
  bool Loading=false;

  TextEditingController facebook=TextEditingController();
  TextEditingController google=TextEditingController();
  TextEditingController twitter=TextEditingController();
  TextEditingController linkedIn=TextEditingController();

  VendorDashboard dashboard=userDashboard;

  List<bool> linkStatus;

  VendorSocialLinksProvider(){
    facebook.text=dashboard.data.user.fUrl;
    google.text=dashboard.data.user.gUrl;
    twitter.text=dashboard.data.user.tUrl;
    linkedIn.text=dashboard.data.user.lUrl;
  }

  void setView(BuildContext context) {
    this.context = context;
    linkStatus=[
      dashboard.data.user.fCheck=="1",
      dashboard.data.user.gCheck=="1",
      dashboard.data.user.tCheck=="1",
      dashboard.data.user.lCheck=="1",
    ];
  }

  void updateData()async{
    var body={
      AppConstant.f_check: linkStatus[0] ? "1" : "0",
      AppConstant.g_check: linkStatus[1] ? "1" : "0",
      AppConstant.t_check: linkStatus[2] ? "1" : "0",
      AppConstant.l_check: linkStatus[3] ? "1" : "0",
      AppConstant.facebook: facebook.text.isEmpty ? '' : facebook.text,
      AppConstant.google: google.text.isEmpty ? '' : google.text,
      AppConstant.twitter: twitter.text.isEmpty ? '' : twitter.text,
      AppConstant.linkedin: linkedIn.text.isEmpty ? '' : linkedIn.text,
    };

    Loading=true;
    notifyListeners();
    await ApiClient2.Request(context,
        url: URL.Update_Social_Link,
        method: Method.POST,
        body: body,
        onSuccess: (data){
          dashboard.data.user.fCheck=linkStatus[0] ? "1" : "0";
          dashboard.data.user.gCheck=linkStatus[1] ? "1" : "0";
          dashboard.data.user.tCheck=linkStatus[2] ? "1" : "0";
          dashboard.data.user.lCheck=linkStatus[3] ? "1" : "0";
          dashboard.data.user.fUrl=facebook.text.isEmpty ? '' : facebook.text;
          dashboard.data.user.gUrl=google.text.isEmpty ? '' : google.text;
          dashboard.data.user.tUrl=twitter.text.isEmpty ? '' : twitter.text;
          dashboard.data.user.lUrl=linkedIn.text.isEmpty ? '' : twitter.text;
          userDashboard=dashboard;
          notifyListeners();
        },
        onError: (data){
        }
    );
    Loading=false;
    notifyListeners();
  }

  void changeLinkStatus({bool status,int index}){
    linkStatus[index]=status;
    notifyListeners();
  }

}