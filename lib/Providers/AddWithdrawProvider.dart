import 'dart:async';

import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:geniouscart/Class/Gateways.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/Api_Client2.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/main.dart';

class AddWithdrawProvider with ChangeNotifier{
  BuildContext context;
  bool Loading=true;
  GatewayData selectedGateway;
  List<TextEditingController> fields=List();

  Gateways gateways;

  GlobalKey<FormState> formKey=GlobalKey();

  bool submitLoading=false;
  bool isVendor;


  @override
  void dispose() {
    super.dispose();
  }

  void setView(BuildContext context){
    this.context=context;
    isVendor=ModalRoute.of(context).settings.arguments;
    getData();
  }



  Future getData() async {
    Loading=true;
    notifyListeners();
    await ApiClient2.Request(context,
        url: URL.PaymentGateways,
        onSuccess: (data){
            gateways=Gateways.fromJson(data);
        },
        onError: (data){
        }
    );
    Loading=false;
    notifyListeners();
  }

  void setGateway(GatewayData newValue) {
    fields.clear();
    selectedGateway=newValue;
    selectedGateway.data.map((e) => fields.add(TextEditingController())).toList();
    notifyListeners();
  }

  Future submitWithdraw()async{
    submitLoading=true;
    notifyListeners();
    var body={};
    body[AppConstant.methods]=selectedGateway.name;
    for(int i=0;i<selectedGateway.data.length;i++){
      body[selectedGateway.data[i].key]=fields[i].text??'';
    }

    await ApiClient2.Request(context,
        url: isVendor ? URL.VendorWithdraw_Store : URL.Withdraw_Store,
        method: Method.POST,
        body: body,
        onSuccess: (data){
          Navigator.of(context).pop(data[AppConstant.data]);
        },
        onError: (data){
        }
    );
    submitLoading=false;
    notifyListeners();
  }
}
