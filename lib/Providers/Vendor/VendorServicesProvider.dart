import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geniouscart/Class/Services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';

class VendorServicesProvider with ChangeNotifier{
  BuildContext context;
  Services services;
  bool Loading=true;
  List<bool> serviceLoading=List();
  RefreshController controller=RefreshController();

  VendorServicesProvider(){
      getServices();
  }

  void setView(BuildContext context)=> this.context=context;

  void getServices()async{
    Map<String,dynamic> response = await Api_Client.Request(url: URL.VendorServices);
    try {
      if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
        services= Services.fromJson(response);
        serviceLoading.clear();
        for(int i=0;i<services.data.length;i++){
          serviceLoading.add(false);
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
  void removeServices(int index)async{
    serviceLoading[index]=true;
    notifyListeners();
    Map<String,dynamic> response = await Api_Client.Request(url: URL.VendorDeleteService+"${services.data[index].id}");
    try {
      if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
        serviceLoading.removeAt(index);
        services.data.removeAt(index);
      } else if (response.containsKey(AppConstant.Error)) {
        ErrorMessage(context,message: response[AppConstant.Error]);
      }
    } catch (e) {
      ErrorMessage(context,message: response[AppConstant.Error]);
    }
    serviceLoading[index]=false;
    notifyListeners();
  }


  void refreshData(){
    Loading=true;
    notifyListeners();
    getServices();
  }

  void addService(ServicesData data, {bool isUpdate=false,int index}) {
    if(isUpdate)
      services.data[index]=data;
    else {
      serviceLoading.add(false);
      services.data.add(data);
    }
    notifyListeners();
  }
}