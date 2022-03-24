import 'package:flutter/material.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';

import '../main.dart';

class ResetPasswordProvider with ChangeNotifier{
  BuildContext context;
  GlobalKey<FormState>fromKey=GlobalKey();
  TextEditingController currentPassword=TextEditingController();
  TextEditingController newPassword=TextEditingController();
  TextEditingController reNewPassword=TextEditingController();

  bool Loading=false;
  bool hideCurrent=true,hideNew=true,hideReNew=true;

  GlobalKey<FormState> formKey=GlobalKey();



  void setView(BuildContext context)=>this.context=context;

  void visibleCurrent(){
    hideCurrent=!hideCurrent;
    notifyListeners();
  }
  void visibleNew(){
    hideNew=!hideNew;
    notifyListeners();
  }
  void visibleReNew(){
    hideReNew=!hideReNew;
    notifyListeners();
  }


  Future requestUpdate()async{
    Loading=true;
    notifyListeners();
    Map<String,String> body={
      AppConstant.current_password:currentPassword.text,
      AppConstant.new_password:newPassword.text,
      AppConstant.renew_password:reNewPassword.text,
    };
    Map<String,dynamic> response = await Api_Client.Request(url: URL.ResetPassword,method: Method.POST,body: body);
    try {
      if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
        currentPassword.text='';
        newPassword.text='';
        reNewPassword.text='';
        SuccessMessage(context,message: language.Change_Password_Successful);
      }
      else{
        Map<String,dynamic>errors=response[AppConstant.Error];
        if(errors.containsKey(AppConstant.photo))
          ErrorMessage(context,message: errors[AppConstant.photo][0]);
        else
          ErrorMessage(context,message: response[AppConstant.Error]);
      }
    } catch (e) {
      ErrorMessage(context,message: response[AppConstant.Error]);
    }
    Loading=false;
    notifyListeners();
  }
}