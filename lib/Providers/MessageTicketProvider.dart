import 'package:flutter/material.dart';
import 'package:geniouscart/Class/Blog.dart';
import 'package:geniouscart/Class/FaqModel.dart';
import 'package:geniouscart/Class/UserMessages.dart';
import 'package:geniouscart/URL/Api_Client2.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';

class MessageTicketProvider with ChangeNotifier{

   BuildContext context;
   RefreshController refreshController=RefreshController();
   bool Loading=true;
   UserMessages userMessages;


   void setView(BuildContext context){
     this.context=context;
     getData();
   }

   void refreshPage(){
     Loading=true;
     notifyListeners();
     userMessages=null;
     getData();
   }
   Future getData()async{
     await ApiClient2.Request(context,
         url: URL.User_Messages,
         onSuccess: (data){
           userMessages=UserMessages.fromJson(data);
         },
         onError: (data){
         }
     );
     refreshController.refreshCompleted();
     Loading=false;
     notifyListeners();
   }

   Future deleteMessage(int index)async{
     TicketData ticket = userMessages.data[index];
     userMessages.data.removeAt(index);
     notifyListeners();
     await ApiClient2.Request(context,
         url: URL.Delete_Ticket.replaceAll('#', ticket.id.toString()),
         onSuccess: (data){
         },
         onError: (data){
            userMessages.data.add(ticket);
         }
     );
     notifyListeners();
   }
}