import 'dart:io';

import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:geniouscart/Class/Shipping.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/KeyboardHandler.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';
import 'package:geniouscart/main.dart';

class AddShippingProvider with ChangeNotifier{
  GlobalKey<FormState> fromKey=GlobalKey();

  TextEditingController title=TextEditingController();
  TextEditingController subtitle=TextEditingController();
  TextEditingController price=TextEditingController();
  FocusNode priceFocus=FocusNode();
  bool isUpdate=false;
  ShippingData shipping;
  BuildContext context;
  bool Loading=false;

  void setView(BuildContext context,{bool isUpdate=false,ShippingData data}){
    this.isUpdate=isUpdate;
    this.context=context;
    shipping=data;
    if(isUpdate){
      title.text=data.title;
      subtitle.text=data.subtitle;
      price.text=data.price;
    }
  }

  KeyboardActionsConfig configuration() {
    return KeyboardActionsConfig(
      keyboardSeparatorColor: Colors.transparent,
      actions: [
        TextFieldAction(focusNode: priceFocus),
      ],
    );
  }

  void addPackaging()async{
      Loading=true;
      notifyListeners();
      Map<String,String> body={
        AppConstant.title : title.text,
        AppConstant.subtitle : subtitle.text,
        AppConstant.price : price.text
      };

      Map<String,dynamic> response = await Api_Client.Request(url: isUpdate ? URL.VendorUpdateShipping+shipping.id.toString() : URL.VendorAddShipping,method: Method.POST,body: body);
      try {
        if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
          title.text='';
          subtitle.text='';
          price.text='';
          Navigator.of(context).pop(ShippingData.fromJson(response[AppConstant.data]));
        } else if (response.containsKey(AppConstant.Error)) {
          ErrorMessage(context,message: response[AppConstant.Error]);
        }
      } catch (e) {
        ErrorMessage(context,message: response[AppConstant.Error]);
      }
      Loading=false;
      notifyListeners();

  }

  void ChangeState() {
    notifyListeners();
  }
}