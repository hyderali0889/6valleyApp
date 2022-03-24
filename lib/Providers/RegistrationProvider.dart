import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:geniouscart/Class/Auth.dart';
import 'package:geniouscart/Class/FacebookResponse.dart';
import 'package:geniouscart/Class/User.dart';
import 'package:geniouscart/Providers/MainPageProvider.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/KeyboardHandler.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';
import 'package:geniouscart/main.dart';

class RegistrationProvider with ChangeNotifier{

  bool isHaveAppBar=false;
  BuildContext context;

  MainPageProvider mainPageProvider;

  GlobalKey<FormState> fromKey=GlobalKey();
  GlobalKey<ScaffoldState> scaffoldKey=GlobalKey();

  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController address=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController confirmPassword=TextEditingController();
  bool hidePassword=true,hideConfirmPassword=true;

  Map<String,String> requestBody={};

  bool Loading=false,googleLoading=false,facebookLoading=false;


  void changePasswordState(){
    hidePassword=!hidePassword;
    notifyListeners();
  }
  String makeRequestData(){
    requestBody.clear();
    requestBody={
      AppConstant.email:email.text,
      AppConstant.password:password.text,
      AppConstant.phone:phone.text,
      AppConstant.address:address.text,
      AppConstant.fullname:name.text
    };
    return URL.Register;
  }
  void changeConfirmPasswordState(){
    hideConfirmPassword=!hideConfirmPassword;
    notifyListeners();
  }

  KeyboardActionsConfig configuration() {
    return KeyboardActionsConfig(
      keyboardSeparatorColor: Colors.transparent,
      actions: [
      ],
    );
  }
  bool valid(){
    if(password.text!=confirmPassword.text){
      ErrorMessage(context,message: language.Pass_not_match);
      return false;
    }
    else
      return true;
  }

  
  Future requestAuth()async{
    if(valid()){
      Loading=true;
      notifyListeners();
      getToken(makeRequestData(),body: requestBody);
    }
  }

  Future getToken(String url,{@required Map<String,String>body})async{
    Map<String,dynamic> response=await Api_Client.SimpleRequest(url: url,method: Method.POST,body: body);
    try {
      if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
        auth=Auth.fromJson(response);
        user=auth.data.user;
        userType=user.type;
        isVendor=userType==AppConstant.Type_Vendor;
        prefs.setString(AppConstant.Share_Auth, json.encode(response));
        if(isHaveAppBar){
          Navigator.of(context).pop(true);
        }
        else
          mainPageProvider.Refresh();
      }
      else if(response.containsKey(AppConstant.Error)) {
        try{
          ErrorMessage(context,message: response[AppConstant.Error][AppConstant.message]);
        }
        catch(e){
          ErrorMessage(context,message: response[AppConstant.Error]);
        }
        Loading=false;
        facebookLoading=false;
        googleLoading=false;
      }
    } catch (e) {
      ErrorMessage(context,message: response[AppConstant.Error]);
      Loading=false;
      facebookLoading=false;
      googleLoading=false;
    }
    notifyListeners();
  }

  void setView(BuildContext context) {
    this.context=context;
    Api_Client.config(context);
  }

  void goForSignIn() {
    if(isHaveAppBar){
      Navigator.of(context).pushReplacementNamed(AUTHENTICATION,arguments: isHaveAppBar);
    }else{
      mainPageProvider.changeAuthPage(status: true);
    }
  }

}