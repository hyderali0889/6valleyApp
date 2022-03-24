import 'package:flutter/material.dart';
import 'package:geniouscart/Class/Ticket.dart';
import 'package:geniouscart/URL/Api_Client2.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';

import '../main.dart';

class TicketPageProvider with ChangeNotifier{
  BuildContext context;
  bool Loading=false;
  TicketData messages;

  TextEditingController message=TextEditingController();


  void setView(BuildContext context){
    this.context=context;
    messages=ModalRoute.of(context).settings.arguments;
  }

  Future sendMessage() async {
    Loading=true;
    notifyListeners();
    var body={
      AppConstant.user_id:user.id.toString(),
      AppConstant.message:message.text,
      AppConstant.conversation_id:messages.id.toString(),
    };

    await ApiClient2.Request(context,
        url: URL.Ticket_Reply_Store,
        method: Method.POST,
        body: body,
        onSuccess: (data){
          messages.messages.add(Messages.fromJson(data[AppConstant.data]));
          message.clear();
          notifyListeners();
        },
        onError: (data){
        }
    );
    Loading=false;
    notifyListeners();
  }
}