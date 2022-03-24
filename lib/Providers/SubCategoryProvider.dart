import 'package:flutter/material.dart';
import 'package:geniouscart/Class/SubCategoryModel.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';

class SubCategoryProvider with ChangeNotifier{

  BuildContext context;
  String url='';

  bool Loading=true;

  SubCategoryModel subCategoryModel;


  void setViewAndUrl(BuildContext context,String url) {
    this.context=context;
    this.url=url;
    getSubcategory();
  }

  Future getSubcategory()async{
    Map<String,dynamic> response = await Api_Client.SimpleRequest(url: url);
    try {
      if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
        subCategoryModel=SubCategoryModel.fromJson(response);
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