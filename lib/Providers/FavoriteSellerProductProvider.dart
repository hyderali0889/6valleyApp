import 'package:flutter/material.dart';
import 'package:geniouscart/Class/Blog.dart';
import 'package:geniouscart/Class/CategoryModel.dart';
import 'package:geniouscart/Class/FaqModel.dart';
import 'package:geniouscart/Class/SellerProducts.dart';
import 'package:geniouscart/Class/WishProduct.dart';
import 'package:geniouscart/URL/Api_Client2.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';

class FavoriteSellerProductProvider with ChangeNotifier{
   BuildContext context;
   bool Loading=false;

   SellerProducts products;
   String id;

   void setView(BuildContext context){
     this.context=context;
     id=ModalRoute.of(context).settings.arguments.toString();
     getData();
   }

   Future getData() async {
     Loading=true;
     notifyListeners();
     await ApiClient2.Request(context,
         url: URL.SellerProduct+id,
         onSuccess: (data){
            products=SellerProducts.fromJson(data);
         },
         onError: (data){
         }
     );
     Loading=false;
     notifyListeners();
   }
}