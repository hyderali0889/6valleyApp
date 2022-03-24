import 'dart:async';
import 'dart:ui';


import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geniouscart/Class/OrderTrack.dart';
import 'package:geniouscart/Packege/Loading_Button/Loading_Button.dart';
import 'package:geniouscart/Providers/OrderTrackingProvider.dart';
import 'package:geniouscart/Widgets/DefaultTextField.dart';
import 'package:geniouscart/Widgets/DividerList.dart';
import 'package:timelines/timelines.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Providers/DemoProvider.dart';
import 'package:geniouscart/Providers/SplashProvider.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/Widgets/BackButton.dart';
import 'package:geniouscart/Widgets/CircularProgress.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/DefaultDialog.dart';
import 'package:geniouscart/Widgets/ImagePlaceHolder.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';



class OrderTracking extends StatefulWidget {
  @override
  _OrderTrackingState createState() => _OrderTrackingState();
}

class _OrderTrackingState extends State<OrderTracking> with TickerProviderStateMixin {
  OrderTrackingProvider provider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OrderTrackingProvider>(
      create: (_) => OrderTrackingProvider()..setView(context),
      child: Consumer<OrderTrackingProvider>(
        builder: (context, model, child) {
          provider = model;
          return Scaffold(
            appBar: DefaultAppbar(context: context,title: language.Order_Tracking),
            body: Form(key: provider.formKey,child: mainView()),
          );
        },
      ),
    );
  }

  Widget mainView() {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding),
      children: [
        Container(
          margin: EdgeInsets.only(top: Dimension.Padding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: DefaultTextField(
                  controller: provider.orderId,
                  label: language.Order_Number,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left:Dimension.Size_10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    LoadingButton(
                      isLoading: provider.Loading,
                      onPressed: (){
                        if(provider.formKey.currentState.validate()){
                          provider.getOrder();
                        }
                      },
                      defaultStyle: true,
                      child: Container(
                        height: Dimension.Size_32,
                        margin: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding),
                        alignment: Alignment.center,
                        child: Text(language.Check,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.White),)
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimension.Size_2),
                          color: Themes.Primary
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Dimension.Size_20,),
        provider.orderTrack!=null ? trackingWidget(provider.orderTrack.data) : Container(
          child : Text(provider.errorMessage ?? "",style: Theme.of(context).textTheme.bodyText1.copyWith(color: Themes.Red),)
        )
      ],
    );
  }

  Widget trackingWidget(List<TrackData> data){
    return FixedTimeline.tileBuilder(
      theme: TimelineThemeData(
        nodePosition: 0,
        color:Themes.Text_Color,
        indicatorTheme: IndicatorThemeData(
          position: 0,
          size: 20.0,
        ),
        connectorTheme: ConnectorThemeData(
          thickness: 2.5,
        ),
      ),
      builder: TimelineTileBuilder.connected(
        connectionDirection: ConnectionDirection.before,
        itemCount: data.length,
        contentsBuilder: (_, index) {
          return Container(
            width: mainWidth,
            padding: EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  data[index].title,
                  style: Theme.of(context).textTheme.headline1,
                ),
                Text(
                  data[index].createdAt,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Padding(
                  padding: EdgeInsets.only(top: Dimension.Size_5,bottom: Dimension.Size_32),
                  child: Text(
                    data[index].text,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
          );
        },
        indicatorBuilder: (_, index) {
            return DotIndicator(
              color: Themes.Primary,
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 12.0,
              ),
            );
        },
        connectorBuilder: (_, index, ___) => SolidLineConnector(
          color:  Themes.Primary
        ),
      ),
    );
  }
}
