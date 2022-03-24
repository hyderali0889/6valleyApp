import 'package:flutter/material.dart';
import 'package:geniouscart/Class/Blog.dart';
import 'package:geniouscart/Class/FaqModel.dart';
import 'package:geniouscart/Class/WishProduct.dart';
import 'package:geniouscart/main.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';

class WishListProvider with ChangeNotifier{
   WishProduct product;
   BuildContext context;
   RefreshController refreshController=RefreshController();
   bool Loading=true;


   WishListProvider(){
     getData();
   }

   void setView(BuildContext context)=>this.context=context;

   void refreshPage(){
     Loading=true;
     notifyListeners();
     product=null;
     getData();
   }
   Future getData()async{
     Map<String,dynamic> response = await Api_Client.Request(url: URL.Get_Favorite_Product);
     try {
       if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
         product=WishProduct.fromJson(response);
       } else if (response.containsKey(AppConstant.Error)) {
         ErrorMessage(context,message: response[AppConstant.Error]);
       }
     } catch (e) {
       ErrorMessage(context,message: response[AppConstant.Error]);
     }
     refreshController.refreshCompleted();
     Loading=false;
     notifyListeners();
   }
   Future deleteProduct(int index)async{
     product.data[index].Loading=true;
     notifyListeners();
     Map<String,dynamic> response = await Api_Client.Request(url:'${URL.Delete_Favorite_Product}${product.data[index].id}');
     try {
       if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
         product.data.removeAt(index);
         SuccessMessage(context,message: response[AppConstant.data][AppConstant.message]);
       } else if (response.containsKey(AppConstant.Error)) {
         product.data[index].Loading=false;
         ErrorMessage(context,message: response[AppConstant.Error][AppConstant.message]);
       }
     } catch (e) {
       product.data[index].Loading=false;
       ErrorMessage(context,message: response[AppConstant.Error]);
     }
     notifyListeners();
   }
}