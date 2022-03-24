import 'package:flutter/material.dart';
import 'package:geniouscart/Class/Withdraw.dart';
import 'package:geniouscart/Providers/AccountProvider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';

class UserWithdrawProvider with ChangeNotifier{
  BuildContext context;
  Withdraw withdraws;
  bool Loading=true;
  RefreshController controller=RefreshController();
  AccountProvider accountProvider;
  bool isVendor;


  void setView(BuildContext context){
    this.context=context;
    accountProvider=Provider.of<AccountProvider>(context);
    isVendor=ModalRoute.of(context).settings.arguments!=null;
    getWithdraw();
  }

  void getWithdraw()async{
    Map<String,dynamic> response = await Api_Client.Request(url: isVendor ? URL.VendorWithdraw : URL.Withdraw);
    try {
      if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
        withdraws= Withdraw.fromJson(response);
      } else if (response.containsKey(AppConstant.Error)) {
        ErrorMessage(context,message: response[AppConstant.Error]);
      }
    } catch (e) {
      ErrorMessage(context,message: response[AppConstant.Error]);
    }
    controller.refreshCompleted();
    Loading=false;
    notifyListeners();
  }

  void refreshData(){
    Loading=true;
    notifyListeners();
    getWithdraw();
  }

  void addNewWithdraw(var data) {
    try{
      withdraws.data.add(WithdrawData.fromJson(data));
    }catch(e){}
    notifyListeners();
    accountProvider.requestUser();
    getWithdraw();
  }
}