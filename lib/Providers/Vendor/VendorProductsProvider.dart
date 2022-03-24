import 'package:flutter/material.dart';
import 'package:geniouscart/Class/VendorProductModel.dart';
import 'package:geniouscart/URL/Api_Client2.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';

class VendorProductsProvider with ChangeNotifier{
  BuildContext context;
  VendorProductModel product;
  bool Loading=true;
  RefreshController controller=RefreshController();

  VendorProductsProvider(){
      getProduct();
  }

  void setView(BuildContext context)=> this.context=context;

  void getProduct()async{
    Map<String,dynamic> response = await Api_Client.Request(url: URL.VendorProducts);
    try {
      if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
        product= VendorProductModel.fromJson(response);
      } else if (response.containsKey(AppConstant.Error)) {
        ErrorMessage(context,message: response[AppConstant.Error]);
      }
    } catch (e) {
      ErrorMessage(context,message: response[AppConstant.Error]);
    }
    controller.refreshCompleted();
    Loading=false;
    notifyListeners();
    return null;
  }

  Future deleteProduct(int index) async {
    VendorProductData pro=product.data[index];
    product.data.removeAt(index);
    await ApiClient2.Request(context,
        url: URL.Delete_Product+pro.id.toString(),
        onSuccess: (data){

        },
        onError: (data){
            product.data.add(pro);
        }
    );
    notifyListeners();
  }

  void refreshData(){
    Loading=true;
    notifyListeners();
    getProduct();
  }
}