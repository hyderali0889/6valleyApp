import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:geniouscart/Class/CategoryModel.dart';
import 'package:geniouscart/Class/Currencies.dart';
import 'package:geniouscart/Language/AppLocalizations.dart';
import 'package:geniouscart/Packege/Expandable/Expandable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:geniouscart/Providers/CartProvider.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';

class MainPageProvider with ChangeNotifier{
  GlobalKey<InnerDrawerState> innerDrawerKey =GlobalKey<InnerDrawerState>();

  int currentIndex = 0;
  Animation animation;
  TabController tabController;
  BuildContext context;
  bool logoutLoading=false;

  bool isLogin=true;

  CartProvider cartProvider;

  double dragUpdate=0;

  AnimationController animationController;

  bool is_open_drawer = false;

  ///Category
  RefreshController categoryRefreshController=RefreshController();
  bool categoryLoading=true;
  CategoryModel categoryModel;
  List<ExpandableController> categoryClickController=List();

  AppProvider appProvider;




  MainPageProvider(){
    context=Api_Client.context;
    cartProvider=Provider.of<CartProvider>(context);
    getCategories();
  }

  void onTabViewChange() {
    currentIndex = tabController.index;
    notifyListeners();
  }

  void changeTab(int index){
    print(index);
    tabController.index=index;
    //notifyListeners();
  }

  void navigationDrawerButton(){
    notifyListeners();
  }

  void updateNavigationDrawer(var val){
    dragUpdate=val;
    notifyListeners();
  }
  
  void getAgainCategory(){
    categoryLoading=true;
    categoryModel=null;
    categoryClickController.clear();
    notifyListeners();
    getCategories();
  }

  Future getCategories()async{
    Map<String,dynamic> response = await Api_Client.SimpleRequest(url: URL.Category);
    try {
      if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
        categoryModel=CategoryModel.fromJson(response);
        for(int i=0;i<categoryModel.data.length;i++){
          categoryClickController.add(ExpandableController());
        }
      } else if (response.containsKey(AppConstant.Error)) {
        ErrorMessage(context,message: response[AppConstant.Error]);
      }
    } catch (e) {
      ErrorMessage(context,message: response[AppConstant.Error]);
    }
    categoryRefreshController.refreshCompleted();
    categoryLoading=false;
    notifyListeners();
  }

  void changeCurrency(String currency){
    for(int i=0; i<currencies.data.length;i++) {
      if (currencies.data[i].name == currency){
        appCurrency = currencies.data[i];
        break;
      }
    }
    prefs.setString(AppConstant.Share_Currency, json.encode(appCurrency));
    appProvider.refreshApp();
    notifyListeners();
  }


  void Refresh(){
    notifyListeners();
  }

  void changeAuthPage({bool status}){
    isLogin=status;
    notifyListeners();
  }

}