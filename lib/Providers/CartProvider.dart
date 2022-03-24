import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geniouscart/Class/Product.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/main.dart';
import 'package:geniouscart/Class/DetailsProduct.dart';
import 'package:geniouscart/Class/Product.dart';
import 'package:provider/provider.dart';

import 'MainPageProvider.dart';

class CartProvider with ChangeNotifier{
  List<ProductData> addToCart=[];

  void cartUpdate(int index,{quantity=1}){
    if(quantity!=0)
      addToCart[index].quantity=quantity;
    else
      addToCart.removeAt(index);
    var js=json.encode(addToCart);
    prefs.setString(AppConstant.Share_Product, js);
    notifyListeners();
  }

  addedToCart(DetailsProduct product,{int quantity=1,String selectedColor='',String selectedSize='', String sizePrice=''}){
    //print('$quantity/$selectedColor/$selectedSize/$sizePrice');
    ProductData data=ProductData.fromJson(product.data.toJson());
    int index;
    bool isHave=false;
    for(int i=0;i<addToCart.length;i++){
      if(addToCart[i].id==data.id){
        isHave=true;
        index=i;
        data.quantity+=addToCart[i].quantity;
        break;
      }
    }
    data.quantity=quantity;
    data.selectedSize=selectedSize;
    data.selectedColor=selectedColor;
    data.sizePrice=sizePrice;
    bool needAdd=false;
    if(isHave) {
      if (addToCart[index].selectedSize!=selectedSize)
        needAdd=true;
      if(addToCart[index].selectedColor!=selectedColor)
        needAdd=true;
    }

    if(!isHave)
      addToCart.add(data);
    else{
      if(needAdd)
        addToCart.add(data);
      else
        addToCart[index]=data;
    }

    var js=json.encode(addToCart);
    prefs.setString(AppConstant.Share_Product, js);
    notifyListeners();
  }


  String getProductCalculatedPrice(int index,{bool withQuantity=false}){
    double price=0;
    if(addToCart[index].attributes!=null){
      for(int i=0;i<addToCart[index].attributes.attribute.length;i++){
        price+=double.parse(addToCart[index].attributes.attribute[i].prices[addToCart[index].attributes.attribute[i].selected.indexOf(true)]);
      }
    }
    if(addToCart[index].sizePrice.isNotEmpty){
      price+=double.parse(addToCart[index].sizePrice);
    }
    return ((double.parse(addToCart[index].currentPrice)+price)*(withQuantity ? addToCart[index].quantity : 1)).toStringAsFixed(2);
  }

  int getHaveAddedToCart(int id){
    int index=-1;
    for(int i=0;i<addToCart.length;i++){
      if(addToCart[i].id==id){
        index=i;
        break;
      }
    }
    return index;
  }

  void clearCart() {
    addToCart.clear();
    prefs.setString(AppConstant.Share_Product, '[]');
  }

  Map<String,String> getSutotalPrice(int index) {
    double productPrice =double.parse(getProductCalculatedPrice(index));
    double discount=0;
    for(int i=0;i<addToCart[index].wholeSellQuantity.length;i++){
      if(addToCart[index].quantity>=int.parse(addToCart[index].wholeSellQuantity[i])){
        discount=double.parse(addToCart[index].wholeSellDiscount[i]);
      }
    }
    return {
      AppConstant.total : discount<=0 ? '${(productPrice*addToCart[index].quantity)}' : '${((productPrice*addToCart[index].quantity)/100)*(100-discount)}',
      AppConstant.item_discount : discount.toString()
    };
  }

}