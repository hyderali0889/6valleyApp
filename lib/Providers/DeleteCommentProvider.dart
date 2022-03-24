import 'package:flutter/material.dart';
import 'package:geniouscart/Class/DetailsProduct.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';
import 'package:geniouscart/main.dart';

class DeleteCommentProvider with ChangeNotifier{
  BuildContext context;
  bool Loading=false;

  bool isReply;
  int replyIndex;
  Comments comment;

  void setView(BuildContext context,{bool isReply=false,int replyIndex,Comments comment}){
    this.context=context;
    Api_Client.config(context);
    this.isReply=isReply;
    this.replyIndex=replyIndex;
    this.comment=comment;
  }

  Future deleteComment()async{
    Loading=true;
    notifyListeners();
    String url=isReply ? URL.Delete_Reply : URL.Delete_Comment;
    Map<String,dynamic> response = await Api_Client.Request(url: url.replaceAll(AppConstant.id, isReply ? comment.replies[replyIndex].id.toString() : comment.id.toString() ));
    try {
      if(response.containsKey(AppConstant.data)) {
        Navigator.of(context).pop(true);
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