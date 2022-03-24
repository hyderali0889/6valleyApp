import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geniouscart/Class/User.dart';
import 'package:geniouscart/Class/UserDashboard.dart';
import 'package:geniouscart/Class/VendorDashboard.dart';
import 'package:geniouscart/CustomIcon/my_flutter_app_icons.dart' as CustomIcon;
import 'package:geniouscart/URL/Api_Client2.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'MainPageProvider.dart';
var userDashboard;
class AccountProvider with ChangeNotifier{
  MainPageProvider mainPageProvider;
  RefreshController controller=RefreshController();
  bool Loading=true;
  bool addVendorSection=false;
  List<Section> sections=[
    /*Section(
      name: language.Account_Sections[0],
      icon: CustomIcon.MyFlutterApp.dashboard,
      route: DASHBOARD
    ),
    Section(
      name: language.Account_Sections[1],
      icon: CustomIcon.MyFlutterApp.purchased_items,
      route: PURCHASED_ITEMS
    ),
    Section(
        name: language.Account_Sections[2],
        icon: CustomIcon.MyFlutterApp.diposit2,
        route: DEPOSIT
    ),*/
    Section(
        name: language.Account_Sections[11],
        icon: CustomIcon.MyFlutterApp.withdraws,
        route: USER_WITHDRAW
    ),
    Section(
        name: language.Account_Sections[3],
        icon: CustomIcon.MyFlutterApp.transactions,
        route: TRANSACTIONS
    ),
    Section(
        name: language.Account_Sections[4],
        icon: CustomIcon.MyFlutterApp.order_tracking,
        route: ORDERS
    ),
    Section(
        name: language.Account_Sections[5],
        icon: CustomIcon.MyFlutterApp.fevorite_sellers,
        route: FAVORITE_SELLERS
    ),
    Section(
        name: language.Account_Sections[6],
        icon: CustomIcon.MyFlutterApp.messages,
        route: ALL_TICKET
    ),
    Section(
        name: language.Account_Sections[7],
        icon: CustomIcon.MyFlutterApp.tickets,
        route: TICKETS
    ),
    Section(
        name: language.Account_Sections[8],
        icon: CustomIcon.MyFlutterApp.disputes,
        route: TICKETS
    ),
    Section(
        name: language.Account_Sections[9],
        icon: CustomIcon.MyFlutterApp.password,
        route: RESET_PASSWORD
    ),
    Section(
        name: language.Account_Sections[10],
        icon: CustomIcon.MyFlutterApp.logout,
        route: ''
    ),
  ];

  bool logoutLoading=false;
  BuildContext context;

  void setView(BuildContext context) {
    this.context = context;
    mainPageProvider=Provider.of<MainPageProvider>(context);
    requestUser();
  }

  void setVendorData(){
    Section temp=sections[1];
    sections[1]=Section(
      name: language.Vendor_Panel,
      icon: CustomIcon.MyFlutterApp.vendor,
      route: VENDOR_PANEL
    );
    for(int i=2;i<sections.length;i++){
      Section sc=sections[i];
      sections[i]=temp;
      temp=sc;
    }
    sections.add(temp);
    addVendorSection=true;
    notifyListeners();
  }

  Future logoutUser()async{
    logoutLoading=true;
    notifyListeners();
    await ApiClient2.Request(context,
        url: URL.Logout,
        method: Method.POST,
        body: {},
        enableShowError: false,
        onSuccess: (data){

        },
        onError: (data){
          //ErrorMessage(context,message: data[AppConstant.Error]);
        }
    );
    SuccessMessage(context,message: language.Log_out_message);
    prefs.clear();
    user=null;
    auth=null;
    logoutLoading=false;
    mainPageProvider.Refresh();
    logoutLoading=false;
    notifyListeners();
  }
  Future getDashBoard()async{
    await ApiClient2.Request(context,
        url: /*isVendor ? URL.Vendor_Dashboard :*/ URL.User_Dashboard,
        onSuccess: (data){
          userDashboard= /*isVendor ? VendorDashboard.fromJson(data) :*/ UserDashboard.fromJson(data);
        },
        onError: (data){
        }
    );
    Loading=false;
    controller.refreshCompleted();
    notifyListeners();
  }

  Future requestUser()async{
    Loading=true;
    notifyListeners();
    await ApiClient2.Request(context,
        url: /*isVendor ? URL.VendorDetails :*/ URL.GetUser,
        onSuccess: (data){
          String code =user.affilateLink;
          user=User.fromJson(data[AppConstant.data]);
          user.affilateLink=code;
          auth.data.user=user;
          user.type=userType;
          prefs.setString(AppConstant.Share_Auth, json.encode(auth));
          /*if(isVendor && !addVendorSection){
            setVendorData();
          }*///TODO desable vendor option
          getDashBoard();
        },
        onError: (data){
          if(data[AppConstant.Error].runtimeType!=String) {
            ErrorMessage(context, message: data[AppConstant.Error][AppConstant.message]);
            userType = AppConstant.Type_User;
            isVendor = false;
            requestUser();
          }else if(data[AppConstant.Error]==AppConstant.Unauthorized){
            ErrorMessage(context, message: data[AppConstant.error]);
            prefs.remove(AppConstant.Share_Auth);
            auth=null;
            user=null;
            mainPageProvider.Refresh();
          }
        }
    );
  }

  void refresh(){
    Loading=true;
    notifyListeners();
    requestUser();
  }

  void goEditProfile() async{
    await Navigator.of(context).pushNamed(EDIT_PROFILE);
    notifyListeners();
  }
}

class Section{
  String name,route;
  IconData icon;

  Section({this.name, this.route, this.icon});
}