import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geniouscart/Class/SearchResult.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';

class SearchProductProvider with ChangeNotifier{
  TextEditingController search=TextEditingController();
  String selectedSort,searchQuery='';
  BuildContext context;
  bool searchLoading=false;
  Timer searchActive;

  double min=0,max=1000000;



  SearchResult searchResult;


  SearchProductProvider(){
    search.addListener(searchAction);
    requestSearch('');
  }

  void setView(BuildContext context)=>this.context=context;

  void selectSort(String value){
    selectedSort=value;
    searchLoading=true;
    notifyListeners();
    requestSearch(search.text);
  }
  void setData(double min, double max, String selectedSort) {
    this.min=min;
    this.max=max;
    this.selectedSort=selectedSort;
    notifyListeners();
    requestSearch(search.text);
  }

  void searchAction(){
    if(searchQuery!=search.text){
      searchLoading=true;
      if (searchActive?.isActive ?? false) searchActive.cancel();
      searchActive = Timer( Duration(milliseconds: 500), () {
          requestSearch(search.text);
      });
      notifyListeners();
    }
  }

  void requestSearch(String key)async{
    searchLoading=true;
    notifyListeners();
    var response=await Api_Client.SimpleRequest(url: SearchResult.makeUrl(URL.Search_Product,term: key,sort: selectedSort,max: max.toString(),min: min.toString()));
    try{
      searchResult=SearchResult.fromJson(response);
      searchLoading=false;
      searchQuery=key;
      notifyListeners();
    }catch (e) {
      ErrorMessage(context,message: response[AppConstant.Error]);
    }
    searchLoading=false;
    notifyListeners();
  }


}