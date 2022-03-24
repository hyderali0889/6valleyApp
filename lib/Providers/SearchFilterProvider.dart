import 'package:flutter/material.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';
import 'package:geniouscart/main.dart';

class SearchFilterProvider with ChangeNotifier{
  String selectedSort;
  //var selectedRange = RangeValues(0.0, 1000000);
  TextEditingController minAmount=TextEditingController(text: '0');
  TextEditingController maxAmount=TextEditingController(text: '1000000');
  bool isValidData=true;



  void changeRange(RangeValues val){
    //selectedRange=val;
    minAmount.text=val.start.toStringAsFixed(0);
    maxAmount.text=val.end.toStringAsFixed(0);
    notifyListeners();
  }

  void selectSort(String value){
    selectedSort=value;
    notifyListeners();
  }

  void setData(double min, double max, String selectedSort) {
    //selectedRange=RangeValues(min, max);
    this.selectedSort=selectedSort;
    minAmount=TextEditingController(text: min.toStringAsFixed(0));
    maxAmount=TextEditingController(text: max.toStringAsFixed(0));
    minAmount.addListener(changeAmount);
    maxAmount.addListener(changeAmount);
    notifyListeners();
  }

  void changeAmount() {
    try {
      if(double.parse(minAmount.text)<=double.parse(maxAmount.text)/* && double.parse(maxAmount.text)<=1000000 && double.parse(minAmount.text)>=0*/) {
        isValidData=true;
        //selectedRange = RangeValues(double.parse(minAmount.text), double.parse(maxAmount.text));
      }
      else{
        isValidData=false;
        //ErrorMessage(context,message: language.Please_enter_valid_Amount);
      }
    }catch(e){
      isValidData=false;
      //ErrorMessage(context,message: language.Please_enter_valid_Amount);
    }
    notifyListeners();
  }
}