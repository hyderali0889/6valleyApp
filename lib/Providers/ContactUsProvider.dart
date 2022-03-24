import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/KeyboardHandler.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';

import '../main.dart';

class ContactUsProvider with ChangeNotifier{
  BuildContext context;
  TextEditingController name=TextEditingController();
  TextEditingController phone=TextEditingController();
  FocusNode phoneFocusNode=FocusNode();
  TextEditingController email=TextEditingController();
  TextEditingController message=TextEditingController();
  GlobalKey<FormState>fromKey=GlobalKey();

  bool Loading=false;


  ContactUsProvider(){
    if(user!=null){
      name.text=user.fullName;
      email.text=user.email;
      phone.text=user.phone;
    }
  }

  void setView(BuildContext context)=>this.context=context;

  KeyboardActionsConfig configuration() {
    return KeyboardActionsConfig(
      keyboardSeparatorColor: Colors.transparent,
      actions: [
        TextFieldAction(focusNode: phoneFocusNode),
      ],
    );
  }

  Future requestSubmitMessage()async{
    Loading=true;
    notifyListeners();
    Map<String,String> body={
      AppConstant.name:name.text,
      AppConstant.email:email.text,
      AppConstant.phone:phone.text,
      AppConstant.message:message.text,
    };
    Map<String,dynamic> response = await Api_Client.SimpleRequest(url: URL.Contact_Admin,method: Method.POST,body: body);
    try {
      if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
        if(user==null){
          name.text='';
          email.text='';
          phone.text='';
        }
        message.text='';
        SuccessMessage(context,message: language.Email_Send_Success);
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