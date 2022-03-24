import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geniouscart/Class/AppSettings.dart';
import 'package:geniouscart/Class/Auth.dart';
import 'package:geniouscart/Class/Currencies.dart';
import 'package:geniouscart/Class/PageSetting.dart';
import 'package:geniouscart/Class/Product.dart';
import 'package:geniouscart/Class/SectionCustomization.dart';
import 'package:geniouscart/Class/SocialSetting.dart';
import 'package:geniouscart/Providers/CartProvider.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/Api_Client2.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class SplashProvider with ChangeNotifier {
  BuildContext context;

  CartProvider cartProvider;

  SplashProvider() {
    context = Api_Client.context;
    cartProvider = Provider.of<CartProvider>(context);
    SharedPreferences.getInstance().then((pr) {
      prefs = pr;
    });
    getSectionCustomization();
    getCurrencies();
    getAppSetting();
    getPageSetting();
    getSocialSetting();
  }
  Future getSectionCustomization() async {
    Map<String, dynamic> response =
        await Api_Client.SimpleRequest(url: URL.Section_Customization);
    try {
      if (response.containsKey(AppConstant.status) &&
          response[AppConstant.status] == true) {
        customization = SectionCustomization.fromJson(response);
        checkSuccess();
      } else if (response.containsKey(AppConstant.Error)) {
        ErrorMessage(context, message: response[AppConstant.Error]);
      }
    } catch (e) {
      ErrorMessage(context, message: response[AppConstant.Error]);
    }
  }
  Future getAppSetting() async {
    Map<String, dynamic> response =
        await Api_Client.SimpleRequest(url: URL.Settings);
    try {
      if (response.containsKey(AppConstant.status) &&
          response[AppConstant.status] == true) {
        appSetting = AppSetting.fromJson(response);
        checkSuccess();
      } else if (response.containsKey(AppConstant.Error)) {
        ErrorMessage(context, message: response[AppConstant.Error]);
      }
    } catch (e) {
      ErrorMessage(context, message: response[AppConstant.Error]);
    }
  }

  Future getPageSetting() async {
    Map<String, dynamic> response =
        await Api_Client.SimpleRequest(url: URL.PageSetting);
    try {
      if (response.containsKey(AppConstant.status) &&
          response[AppConstant.status] == true) {
        pageSetting = PageSetting.fromJson(response);
        checkSuccess();
      } else if (response.containsKey(AppConstant.Error)) {
        ErrorMessage(context, message: response[AppConstant.Error]);
      }
    } catch (e) {
      ErrorMessage(context, message: response[AppConstant.Error]);
    }
  }

  Future getSocialSetting() async {
    Map<String, dynamic> response =
        await Api_Client.SimpleRequest(url: URL.SocialSetting);
    try {
      if (response.containsKey(AppConstant.status) &&
          response[AppConstant.status] == true) {
        socialSetting = SocialSetting.fromJson(response);
        checkSuccess();
      } else if (response.containsKey(AppConstant.Error)) {
        ErrorMessage(context, message: response[AppConstant.Error]);
      }
    } catch (e) {
      ErrorMessage(context, message: response[AppConstant.Error]);
    }
  }

  Future getCurrencies() async {
    await ApiClient2.SimpleRequest(context, url: URL.All_Currencies, onSuccess: (data) {
      currencies = Currencies.fromJson(data);
      for(int i=0; i<currencies.data.length;i++) {
        currencyName.add(currencies.data[i].name);
        if (currencies.data[i].sign == "\$"){
          defaultCurrency = currencies.data[i];
        }
      }
      checkSuccess();
    },onError: (data) {});

  }

  startTime() async {
    Themes.Primary = Themes.getColorFromColorCode(appSetting.data.colors);
    var _duration = Duration(seconds: 1);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    Navigator.of(context).pushReplacementNamed(Main);
  }

  void setAppData() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    //prefs.clear();
    if (!prefs.containsKey(AppConstant.Share_Currency)) {
      for(int i=0; i<currencies.data.length;i++) {
        if (currencies.data[i].isDefault == "1"){
          appCurrency = currencies.data[i];
          break;
        }
      }
      prefs.setString(AppConstant.Share_Currency, json.encode(appCurrency));
    } else {
      Map<String, dynamic> cr = json.decode(prefs.getString(AppConstant.Share_Currency));
      appCurrency = Currency.fromJson(cr);
    }
    if (prefs.containsKey(AppConstant.Share_Auth)) {
      auth =
          Auth.fromJson(json.decode(prefs.getString(AppConstant.Share_Auth)));
      user = auth.data.user;
      userType = user.type;
      isVendor = userType == AppConstant.Type_Vendor;
      startTime();
    }
    if (!prefs.containsKey(AppConstant.Share_Product)) {
      prefs.setString(AppConstant.Share_Product, '[]');
      cartProvider.addToCart = List();
    } else {
      json.decode(prefs.getString(AppConstant.Share_Product)).forEach((v) {
        cartProvider.addToCart.add(ProductData.fromJson(v));
      });
    }
    if (!prefs.containsKey(AppConstant.Share_Auth)) {
      startTime();
    }
  }

  void checkSuccess() {
    if (appSetting != null && socialSetting != null && pageSetting != null && currencies != null && customization != null)
      setAppData();
  }
}
