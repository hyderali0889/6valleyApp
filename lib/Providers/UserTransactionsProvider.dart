import 'dart:async';

import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:geniouscart/Class/Deposit.dart';
import 'package:geniouscart/Class/Transactions.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/Api_Client2.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/main.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserTransactionsProvider with ChangeNotifier{
  BuildContext context;
  bool Loading=true;
  RefreshController controller=RefreshController();
  Transactions transactions;


  @override
  void dispose() {
    super.dispose();
  }

  void setView(BuildContext context){
    this.context=context;
    getData();
  }

  void refreshData(){
    Loading=true;
    notifyListeners();
    getData();
  }


  Future getData() async {
    await ApiClient2.Request(context,
        url: URL.Transactios,
        onSuccess: (data){
            transactions=Transactions.fromJson(data);
        },
        onError: (data){
        }
    );
    controller.refreshCompleted();
    Loading=false;
    notifyListeners();
  }
}
