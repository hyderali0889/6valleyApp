import 'package:flutter/material.dart';
import 'package:geniouscart/Class/DetailsProduct.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';
import 'package:geniouscart/main.dart';

class AddReviewProvider with ChangeNotifier{
  TextEditingController review=TextEditingController();
  GlobalKey<FormState> fromKey=GlobalKey();

  DetailsProduct detailsProduct;
  String errorMessage;

  BuildContext context;
  double rating=5.0;
  bool Loading=false;

  void setView(BuildContext context,DetailsProduct details){
    this.context=context;
    Api_Client.config(context);
    detailsProduct=details;
    print('user = ${user.id} / product = ${detailsProduct.data.id}');
  }

  void setRating(double value)=>rating=value;

  Future submitReview()async{
    Loading=true;
    errorMessage=null;
    notifyListeners();
    Map<String,String>  body={
      AppConstant.user_id:user.id.toString(),
      AppConstant.product_id:detailsProduct.data.id.toString(),
      AppConstant.rating:rating.toString(),
      AppConstant.comment:review.text
    };
    Map<String,dynamic> response = await Api_Client.Request(url: URL.Submit_Review,method: Method.POST,body: body);
    try {
      if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
        Navigator.of(context).pop(response);
      } else if (response.containsKey(AppConstant.Error)) {
        errorMessage=response[AppConstant.Error][AppConstant.message];
      }
    } catch (e) {
      ErrorMessage(context,message: response[AppConstant.Error]);
    }
    Loading=false;
    notifyListeners();
  }
}