import 'dart:async';
import 'dart:ui';


import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:geniouscart/AppHelper/Helper.dart';
import 'package:geniouscart/Class/MyOrders.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Providers/DemoProvider.dart';
import 'package:geniouscart/Providers/MyOrdersProvider.dart';
import 'package:geniouscart/Providers/SplashProvider.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/Widgets/BackButton.dart';
import 'package:geniouscart/Widgets/CircularProgress.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/DefaultDialog.dart';
import 'package:geniouscart/Widgets/EmptyView.dart';
import 'package:geniouscart/Widgets/ImagePlaceHolder.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/MyOrderSkeleton.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';



class MyOrderPage extends StatefulWidget {
  @override
  _MyOrderPageState createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> with TickerProviderStateMixin {
  MyOrdersProvider provider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyOrdersProvider>(
      create: (_) => MyOrdersProvider()..setView(context),
      child: Consumer<MyOrdersProvider>(
        builder: (context, model, child) {
          provider = model;
          return Scaffold(
            appBar: DefaultAppbar(context: context,title: language.Order),
            body: mainView(),
          );
        },
      ),
    );
  }

  Widget mainView() {
    return provider.Loading ? MyOrderSkeleton(context: context)
        : provider.orders!=null  ? provider.orders.data.length >0 ?
    ListView(
      padding: EdgeInsets.all(0),
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(0),
          itemCount: provider.orders.data.length,
          itemBuilder: (context,index){
            return ListAnimation(
                child: orderItem(provider.orders.data[index],index),
                index: index
            );
          }
        ),
        SizedBox(height: Dimension.Padding,)
      ],
    ): EmptyView(image :'assets/images/empty-cart.png',message: Text(language.You_have_no_Orders,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.Grey),)):
    EmptyView(image :'assets/images/empty-cart.png',message: Text(language.You_have_no_Orders,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.Grey)));
  }

  Widget orderItem(MyOrderData data, int index) {
    return InkWell(
        onTap: (){
          Navigator.of(context).pushNamed(ORDER_DETAILS,arguments: {
            AppConstant.details:data.details,
            AppConstant.payment_url:data.paymentUrl
          });
        },
        child: Card(
          elevation: Dimension.card_elevation,
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.all(Dimension.Size_10).copyWith(bottom: 0),
          color: Themes.White,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                stops: [0.015, 0.015],
                colors: [
                  getStatusColor(data.status),
                  Colors.white
                ],
              ),
            ),
            padding: EdgeInsets.all(Dimension.Size_10).copyWith(left: Dimension.Padding),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Text(data.number,style: Theme.of(context).textTheme.headline1,),
                          SizedBox(width: Dimension.Size_10,),
                          InkWell(
                            onTap: ()=>Helper.copyText(context: context, text: data.number),
                            child: Icon(Icons.copy,color: Themes.Primary,),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(data.total,style: Theme.of(context).textTheme.bodyText1.copyWith(color: Themes.Primary),textAlign: TextAlign.end,),
                    ),
                  ],
                ),
                SizedBox(height: Dimension.Size_5,),
                Row(
                  children: [
                    Expanded(
                      child: Text(data.status.toUpperCase(),style: Theme.of(context).textTheme.bodyText1,),
                    ),
                    Expanded(
                      child: Text(Helper.getDateTime(data.createdAt,withYear: true),style: Theme.of(context).textTheme.bodyText1,textAlign: TextAlign.end,),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }

  Color getStatusColor(String status) {
    switch(status){
      case 'pending' :
        return Colors.yellow;
        break;
      case 'processing' :
        return Colors.blue;
        break;
      case 'on delivery' :
        return Colors.orange;
        break;
      case 'completed' :
        return Colors.teal;
        break;
      case 'declined' :
        return Colors.red;
        break;
      default :
        return Colors.yellow;
    }
  }

}
