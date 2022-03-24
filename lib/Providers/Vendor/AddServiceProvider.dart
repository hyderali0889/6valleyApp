import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geniouscart/Class/Services.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';
import 'package:geniouscart/main.dart';

class AddServiceProvider with ChangeNotifier{
  GlobalKey<FormState> fromKey=GlobalKey();

  TextEditingController title=TextEditingController();
  TextEditingController details=TextEditingController();
  bool isUpdate=false;
  ServicesData service;
  File image;
  BuildContext context;
  bool Loading=false;

  void setView(BuildContext context,{bool isUpdate=false,ServicesData data}){
    this.isUpdate=isUpdate;
    this.context=context;
    service=data;
    if(isUpdate){
      title.text=data.title;
      details.text=data.details;
    }
  }

  void addService()async{
    if(image==null && !isUpdate){
      ErrorMessage(context,message: language.Image_Upload);
    }
    else{
      Loading=true;
      notifyListeners();
      Map<String,String> body={
        AppConstant.title : title.text,
        AppConstant.details : details.text
      };
      List<String>fileKey=List();
      List<File>files=List();
      if(image!=null){
        files.add(image);
        fileKey.add(AppConstant.photo);
      }

      Map<String,dynamic> response = await Api_Client.RequestWithFile(url: isUpdate ? URL.VendorUpdateService+service.id.toString() : URL.VendorAddService,method: Method.POST,body: body,files: files,fileKey: fileKey);
      try {
        if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
          title.text='';
          details.text='';
          image=null;
          Navigator.of(context).pop(ServicesData.fromJson(response[AppConstant.data]));
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

  void ChangeState() {
    notifyListeners();
  }
}