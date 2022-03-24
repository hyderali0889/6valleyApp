import 'dart:async';
import 'dart:ffi';
import 'dart:ui';


import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Packege/Loading_Button/Loading_Button.dart';
import 'package:geniouscart/Providers/PlaceOrderProvider.dart';
import 'package:geniouscart/Providers/SplashProvider.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/Screen/Checkout/OrderInfo.dart';
import 'package:geniouscart/Screen/Checkout/PaymentDetails.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/Widgets/BackButton.dart';
import 'package:geniouscart/Widgets/CircularProgress.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/DefaultDialog.dart';
import 'package:geniouscart/Widgets/ImagePlaceHolder.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/OrderStep.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';

import 'Products.dart';



class PlaceOrder extends StatefulWidget {
  @override
  _PlaceOrderState createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> with TickerProviderStateMixin {
  PlaceOrderProvider provider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<PlaceOrderProvider>(
        create: (_)=>PlaceOrderProvider()..setView(context),
        child: Consumer<PlaceOrderProvider>(
        builder: (context,model,child){
          provider=model;
          return Scaffold(
            appBar: DefaultAppbar(context: context,title: language.Checkout),
            body: Form(
                key: provider.formKey,
                child: mainView()
            ),
          );
        },
      ),
    );

  }

  Widget mainView() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: Container(
            padding: EdgeInsets.only(top: Dimension.Size_66,bottom: Dimension.Size_70),
            child: PageView(
              controller: provider.pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                OrderInfo(),
                Products(),
                PaymentDetails(),
              ],
              onPageChanged: provider.onPageChange,
            ),
          ),
        ),
        Positioned(
          top: 0,
          child: Container(
            height: Dimension.Size_66,
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children:provider.tabs.asMap().map((index,e) => MapEntry(
                  index,
                  Container(
                    height: Dimension.Size_50,
                    width: mainWidth*0.32,
                    child: OrderStep(
                      image: e.image,
                      title: e.title,
                      isSelected: e.isSelected,
                      index: "${index+1}",
                    ),
                  )
              )).values.toList(),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: mainWidth,
            height: Dimension.Size_70,
            padding: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding,top: Dimension.Size_10,bottom: Dimension.Size_10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Visibility(
                  visible: provider.currentPage>0,
                  child: LoadingButton(
                    isLoading: false,
                    onPressed: ()=>provider.changeTab(-1),
                    defaultStyle: true,
                    backgroundColor: Themes.Primary,
                    child: Container(
                      width: mainWidth*0.3,
                      alignment: Alignment.center,
                      child: Text(language.Previous,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.White),),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                LoadingButton(
                  isLoading: provider.placeOrderLoading,
                  onPressed: (){
                    if(provider.formKey.currentState.validate()){
                      provider.changeTab(1);
                    }
                  },
                  defaultStyle: true,
                  backgroundColor: Themes.Primary,
                  child: Container(
                    width: mainWidth*0.3,
                    alignment: Alignment.center,
                    child: Text(provider.currentPage<2 ? language.Next : language.Confirm ,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.White),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
