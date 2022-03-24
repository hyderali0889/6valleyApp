import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geniouscart/Class/Banners.dart';
import 'package:geniouscart/Class/FeaturedBanners.dart';
import 'package:geniouscart/Class/HoleSlider.dart';
import 'package:geniouscart/Class/Partners.dart';
import 'package:geniouscart/Class/Product.dart';
import 'package:geniouscart/Class/Services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:geniouscart/Packege/TabView/src/navigation_bar_item.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:provider/provider.dart';
import 'package:geniouscart/Class/AppSettings.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';

import '../main.dart';

class HomeProvider with ChangeNotifier{
  BuildContext context;
  HomeSlider homeSlider;
  Services services;
  Product products,hotProduct,newProduct,trendingProduct,saleProduct,bestSeller,topRated,bigSave,freshDeal;
  Banners topBanners,middleBanner,bottomBanner;
  Partners partners;
  RefreshController _refreshController =  RefreshController();

  final List<TabViewItem> items = [
    TabViewItem(title: Text(language.Popular_Product_List[0]),backgroundColor: Themes.Background),
    TabViewItem(title: Text(language.Popular_Product_List[1]),backgroundColor: Themes.Background),
    TabViewItem(title: Text(language.Popular_Product_List[2]),backgroundColor: Themes.Background),
    TabViewItem(title: Text(language.Popular_Product_List[3]),backgroundColor: Themes.Background),
  ];

  int popularTabIndex = 0;
  int popularTab() => popularTabIndex;

  bool haveInternetError=false;

  HomeProvider(){
    haveInternetError=false;
    context=Api_Client.context;
    allServerRequest();
  }
  allServerRequest()async{
    getHomeSlider();
    getServices();
    getTrendingProduct();
    topBanners=null;
    topBanners = await getBanner(AppConstant.BannerTypeTopSmall);
    notifyListeners();
    checkEverythingOk();
    hotProduct=null;
    hotProduct=await getPopularProduct(AppConstant.hotHighlight);
    notifyListeners();
    checkEverythingOk();
    newProduct=null;
    newProduct=await getPopularProduct(AppConstant.latestHighlight);
    notifyListeners();
    checkEverythingOk();
    trendingProduct=null;
    trendingProduct=await getPopularProduct(AppConstant.trendingHighlight);
    notifyListeners();
    checkEverythingOk();
    saleProduct=null;
    saleProduct=await getPopularProduct(AppConstant.saleHighlight);
    notifyListeners();
    checkEverythingOk();
    bestSeller=null;
    bestSeller=await getPopularProduct(AppConstant.bestHighlight,type: AppConstant.DigitalType);
    notifyListeners();
    checkEverythingOk();
    middleBanner=null;
    middleBanner = await getBanner(AppConstant.BannerTypeLarge);
    notifyListeners();
    checkEverythingOk();
    topRated=null;
    topRated=await getPopularProduct(AppConstant.topHighlight);
    notifyListeners();
    checkEverythingOk();
    bottomBanner=null;
    bottomBanner = await getBanner(AppConstant.BannerTypeBottomSmall);
    notifyListeners();
    checkEverythingOk();
    bigSave=null;
    bigSave=await getPopularProduct(AppConstant.bigHighlight,type: AppConstant.LicenseType);
    notifyListeners();
    checkEverythingOk();
    freshDeal=null;
    freshDeal=await getPopularProduct(AppConstant.saleHighlight);
    notifyListeners();
    checkEverythingOk();
    getPartners();
  }

  changePopularTab(int index){
    popularTabIndex=index;
    notifyListeners();
  }

  get refreshController => _refreshController;

  Future getHomeSlider()async{
    Map<String,dynamic> response = await Api_Client.SimpleRequest(url: URL.HomePageSlider);
    try {
      if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
        homeSlider = HomeSlider.fromJson(response);
      } else if (response.containsKey(AppConstant.Error)) {
        ErrorMessage(context,message: response[AppConstant.Error]);
      }
    } catch (e) {
      haveInternetError=true;
      ErrorMessage(context,message: response[AppConstant.Error]);
    }
    notifyListeners();
    checkEverythingOk();
  }
  Future getServices()async{
    Map<String,dynamic> response = await Api_Client.SimpleRequest(url: URL.Services);
    try {
      if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
        services = Services.fromJson(response);
      } else if (response.containsKey(AppConstant.Error)) {
        ErrorMessage(context,message: response[AppConstant.Error]);
      }
    } catch (e) {
      haveInternetError=true;
      ErrorMessage(context,message: response[AppConstant.Error]);
    }
    notifyListeners();
    checkEverythingOk();
  }
  Future getPartners()async{
    Map<String,dynamic> response = await Api_Client.SimpleRequest(url: URL.Partners);
    try {
      if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
        partners = Partners.fromJson(response);
      } else if (response.containsKey(AppConstant.Error)) {
        ErrorMessage(context,message: response[AppConstant.Error]);
      }
    } catch (e) {
      haveInternetError=true;
      ErrorMessage(context,message: response[AppConstant.Error]);
    }
    notifyListeners();
    checkEverythingOk();
  }
  Future getTrendingProduct()async{
    String url=Product.makeProductApi(URL.Product,highlight: AppConstant.featuredHighlight,/*type: AppConstant.PhysicalType,productType: AppConstant.normalProductType*/);
    Map<String,dynamic> response = await Api_Client.SimpleRequest(url: url);
    try {
      if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
        products = Product.fromJson(response);
      } else if (response.containsKey(AppConstant.Error)) {
        ErrorMessage(context,message: response[AppConstant.Error]);
      }
    } catch (e) {
      haveInternetError=true;
      ErrorMessage(context,message: response[AppConstant.Error]);
    }
    notifyListeners();
    checkEverythingOk();
  }
  Future<Banners> getBanner(String type)async{
    String url=Banners.makeBannersApi(URL.Banners,type: type);
    Map<String,dynamic> response = await Api_Client.SimpleRequest(url: url);
    try {
      if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
        return Banners.fromJson(response);
      } else if (response.containsKey(AppConstant.Error)) {
        ErrorMessage(context,message: response[AppConstant.Error]);
      }
    } catch (e) {
      haveInternetError=true;
      ErrorMessage(context,message: response[AppConstant.Error]);
    }
    return null;
  }
  Future<Product> getPopularProduct(String highlight,{String type})async{
    String url=Product.makeProductApi(URL.Product,highlight: highlight,/*type: type==null ? AppConstant.PhysicalType : type,productType: AppConstant.normalProductType*/);
    Map<String,dynamic> response = await Api_Client.SimpleRequest(url: url);
    try {
      if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
        notifyListeners();
        return Product.fromJson(response);
      } else if (response.containsKey(AppConstant.Error)) {
        ErrorMessage(context,message: response[AppConstant.Error]);
      }
    } catch (e) {
      haveInternetError=true;
      ErrorMessage(context,message: response[AppConstant.Error]);
    }
    return null;
  }
  void refresh(){
    haveInternetError=false;
    homeSlider=null;
    services=null;
    products=null;
    topBanners=null;
    notifyListeners();
    allServerRequest();
  }

  void checkEverythingOk(){
    if(haveInternetError){
      _refreshController.refreshCompleted();
    }
    else if(homeSlider!=null && services!=null && products!=null && topBanners!=null){
      _refreshController.refreshCompleted();
      notifyListeners();
    }
  }

}