import 'package:flutter/material.dart';
import 'package:geniouscart/Class/Blog.dart';
import 'package:geniouscart/Class/FaqModel.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';

class FaqPageProvider with ChangeNotifier{
   FaqModel faqs;
   BuildContext context;
   RefreshController refreshController=RefreshController();
   bool Loading=true;


   FaqPageProvider(){
     getBlogs();
   }

   void setView(BuildContext context)=>this.context=context;

   void refreshPage(){
     Loading=true;
     notifyListeners();
     faqs=null;
     getBlogs();
   }
   Future getBlogs()async{
     Map<String,dynamic> response = await Api_Client.SimpleRequest(url: URL.Faqs);
     try {
       if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
         faqs=FaqModel.fromJson(response);
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
}