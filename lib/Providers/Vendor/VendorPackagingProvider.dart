import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geniouscart/Class/Packaging.dart';
import 'package:geniouscart/Class/Services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';

class VendorPackagingProvider with ChangeNotifier{
  BuildContext context;
  Packaging packages;
  bool Loading=true;
  List<bool> packageLoading=List();
  RefreshController controller=RefreshController();

  VendorPackagingProvider(){
      getPackages();
  }

  void setView(BuildContext context)=> this.context=context;

  void getPackages()async{
    Map<String,dynamic> response = await Api_Client.Request(url: URL.VendorPackaging);
    try {
      if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
        packages= Packaging.fromJson(response);
        packageLoading.clear();
        for(int i=0;i<packages.data.length;i++){
          packageLoading.add(false);
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
  void removePackaging(int index)async{
    packageLoading[index]=true;
    notifyListeners();
    Map<String,dynamic> response = await Api_Client.Request(url: URL.VendorDeletePackaging+"${packages.data[index].id}");
    try {
      if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
        packageLoading.removeAt(index);
        packages.data.removeAt(index);
      } else if (response.containsKey(AppConstant.Error)) {
        ErrorMessage(context,message: response[AppConstant.Error]);
      }
    } catch (e) {
      ErrorMessage(context,message: response[AppConstant.Error]);
    }
    packageLoading[index]=false;
    notifyListeners();
  }


  void refreshData(){
    Loading=true;
    notifyListeners();
    getPackages();
  }

  void addPackage(PackagingData data, {bool isUpdate=false,int index}) {
    if(isUpdate)
      packages.data[index]=data;
    else {
      packageLoading.add(false);
      packages.data.add(data);
    }
    notifyListeners();
  }
}