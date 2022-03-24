import 'package:flutter/material.dart';
import 'package:geniouscart/Class/Blog.dart';
import 'package:geniouscart/Class/CategoryModel.dart';
import 'package:geniouscart/Class/FaqModel.dart';
import 'package:geniouscart/Class/WishProduct.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';

class ShowProductProvider with ChangeNotifier{
   BuildContext context;
   bool Loading=false;

   List<Products> products=List();

   void setView(BuildContext context){
     this.context=context;
     products=ModalRoute.of(context).settings.arguments;
   }
}