import 'package:flutter/material.dart';
import 'package:geniouscart/Class/Sellers.dart';
import 'package:geniouscart/Class/UserMessages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';

class FavoriteSellerProvider with ChangeNotifier{
  BuildContext context;
  bool Loading=true;
  Sellers sellers;
  RefreshController refreshController=RefreshController();


  FavoriteSellerProvider(){
    getSellers();
  }

  void setView(BuildContext context)=>this.context=context;

  void refreshPage(){
    Loading=true;
    notifyListeners();
    sellers=null;
    getSellers();
  }

  Future getSellers()async{
    Map<String,dynamic> response = await Api_Client.Request(url: URL.Favorite_Sellers);
    try {
      if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
        sellers=Sellers.fromJson(response);
      }
      else {
        ErrorMessage(context,message: response[AppConstant.Error]);
      }
    } catch (e) {
      ErrorMessage(context,message: response[AppConstant.Error]);
    }
    refreshController.refreshCompleted();
    Loading=false;
    notifyListeners();
  }
  Future deleteSeller(int index)async{
   sellers.data.removeAt(index);
    notifyListeners();
  }
}