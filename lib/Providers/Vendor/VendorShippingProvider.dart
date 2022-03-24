import 'package:flutter/material.dart';
import 'package:geniouscart/Class/Shipping.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';

class VendorShippingProvider with ChangeNotifier{
  BuildContext context;
  Shipping shippings;
  bool Loading=true;
  List<bool> shippingLoading=List();
  RefreshController controller=RefreshController();

  VendorShippingProvider(){
      getShipping();
  }

  void setView(BuildContext context)=> this.context=context;

  void getShipping()async{
    Map<String,dynamic> response = await Api_Client.Request(url: URL.VendorShipping);
    try {
      if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
        shippings= Shipping.fromJson(response);
        shippingLoading.clear();
        for(int i=0;i<shippings.data.length;i++){
          shippingLoading.add(false);
        }
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
  void removeShipping(int index)async{
    shippingLoading[index]=true;
    notifyListeners();
    Map<String,dynamic> response = await Api_Client.Request(url: URL.VendorDeleteShipping+"${shippings.data[index].id}");
    try {
      if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
        shippingLoading.removeAt(index);
        shippings.data.removeAt(index);
      } else if (response.containsKey(AppConstant.Error)) {
        ErrorMessage(context,message: response[AppConstant.Error]);
      }
    } catch (e) {
      ErrorMessage(context,message: response[AppConstant.Error]);
    }
    shippingLoading[index]=false;
    notifyListeners();
  }


  void refreshData(){
    Loading=true;
    notifyListeners();
    getShipping();
  }

  void addPackage(ShippingData data, {bool isUpdate=false,int index}) {
    if(isUpdate)
      shippings.data[index]=data;
    else {
      shippingLoading.add(false);
      shippings.data.add(data);
    }
    notifyListeners();
  }
}