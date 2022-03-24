import 'package:flutter/material.dart';
import 'package:geniouscart/Class/Blog.dart';
import 'package:geniouscart/Class/FaqModel.dart';
import 'package:geniouscart/Class/Ticket.dart';
import 'package:geniouscart/URL/Api_Client2.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';

class UserTicketProvider with ChangeNotifier{

   BuildContext context;
   RefreshController refreshController=RefreshController();
   bool Loading=true;
   Ticket userMessages;
   bool isDisputes=false;


   void setView(BuildContext context){
     this.context=context;
     isDisputes=ModalRoute.of(context).settings.arguments=='Disputes' ? true : false;
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
         url: isDisputes ? URL.User_Disputes : URL.User_Ticket,
         onSuccess: (data){
           userMessages=Ticket.fromJson(data);
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
         url: URL.Delete_User_Ticket.replaceAll('#', ticket.id.toString()),
         onSuccess: (data){
         },
         onError: (data){
            userMessages.data.add(ticket);
         }
     );
     notifyListeners();
   }
}