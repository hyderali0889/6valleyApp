import 'package:flutter/material.dart';
import 'package:geniouscart/Class/DetailsProduct.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';
import 'package:geniouscart/main.dart';

class DeleteFavoriteShopProvider with ChangeNotifier{
  BuildContext context;
  bool Loading=false;

  void setView(BuildContext context){
    this.context=context;
    Api_Client.config(context);
  }

  Future deleteShop(int id)async{
    Loading=true;
    notifyListeners();
    Map<String,dynamic> response = await Api_Client.Request(url: URL.Remove_Favorite_Sellers+id.toString());
    try {
      if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
        Navigator.of(context).pop(true);
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