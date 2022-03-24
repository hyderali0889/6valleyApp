import 'dart:convert';
import 'dart:io';

import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:geniouscart/Class/User.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/GetImage.dart';
import 'package:geniouscart/Widgets/KeyboardHandler.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';
import 'package:geniouscart/main.dart';

class ProfileUpdateProvider with ChangeNotifier{
  BuildContext context;
  GlobalKey<FormState>fromKey=GlobalKey();
  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController phone=TextEditingController();
  FocusNode phoneFocus=FocusNode();
  TextEditingController fax=TextEditingController();
  FocusNode faxFocus=FocusNode();
  TextEditingController address=TextEditingController();
  TextEditingController zip=TextEditingController();
  FocusNode zipFocus=FocusNode();
  TextEditingController country=TextEditingController();
  TextEditingController city=TextEditingController();
  File image;
  bool Loading=false;


  ProfileUpdateProvider(){
    name.text=user.fullName;
    email.text=user.email;
    phone.text=user.phone;
    fax.text=user.fax;
    address.text=user.address;
    zip.text=user.zipCode;
    country.text=user.country;
    city.text=user.city;
  }

  void setView(BuildContext context)=>this.context=context;

  KeyboardActionsConfig configuration() {
    return KeyboardActionsConfig(
      keyboardSeparatorColor: Colors.transparent,
      actions: [
        TextFieldAction(focusNode: phoneFocus),
        TextFieldAction(focusNode: faxFocus),
        TextFieldAction(focusNode: zipFocus),
      ],
    );
  }

  void getProfileImage()async{
    var data=await getImage(context);
    if(data!=null){
      image=data;
      notifyListeners();
    }
  }

  void openCountryPickerDialog() => showDialog(
    context: context,
    builder: (context) => Theme(
        data: Theme.of(context).copyWith(primaryColor: Themes.Primary),
        child: CountryPickerDialog(
            titlePadding: EdgeInsets.all(8.0),
            searchCursorColor: Themes.Primary,
            searchInputDecoration: InputDecoration(hintText: language.Search),
            isSearchable: true,
            title: Text(language.Select_your_country,style: Theme.of(context).textTheme.headline1,),
            onValuePicked: (Country value){
              country.text=value.name;
            },
            itemBuilder: DropdownItem)),
  );
  Widget DropdownItem(Country country) => Container(
    child: Row(
      children: <Widget>[
        CountryPickerUtils.getDefaultFlagImage(country),
        SizedBox(
          width: 8.0,
        ),
        Text(country.name),
      ],
    ),
  );

  Future requestUpdate()async{
    Loading=true;
    notifyListeners();
    Map<String,String> body={
      AppConstant.fax:fax.text,
      AppConstant.city:city.text,
      AppConstant.country:country.text,
      AppConstant.zip:zip.text,
      AppConstant.address:address.text,
      AppConstant.name:name.text,
      AppConstant.email:email.text,
      AppConstant.phone:phone.text,
    };
    List<String> fileKey=List();
    List<File> files=List();
    if(image!=null){
      fileKey.add(AppConstant.photo);
      files.add(image);
    }
    Map<String,dynamic> response = await Api_Client.RequestWithFile(url: URL.Profile_Update,method: Method.POST,body: body,fileKey: fileKey,files: files);
    try {
      if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
          user=User.fromJson(response[AppConstant.data]);
          prefs.setString(AppConstant.Share_User, json.encode(user.toJson()));
          SuccessMessage(context,message: language.Change_Profile_Successful);
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