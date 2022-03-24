import 'dart:async';
import 'dart:ui';


import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:geniouscart/AppHelper/Helper.dart';
import 'package:geniouscart/Class/Deposit.dart';
import 'package:geniouscart/Class/Transactions.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Packege/Expandable/Expandable.dart';
import 'package:geniouscart/Providers/DemoProvider.dart';
import 'package:geniouscart/Providers/SplashProvider.dart';
import 'package:geniouscart/Providers/UserDepositProvider.dart';
import 'package:geniouscart/Providers/UserTransactionsProvider.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/Widgets/BackButton.dart';
import 'package:geniouscart/Widgets/CircularProgress.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/DefaultDialog.dart';
import 'package:geniouscart/Widgets/DividerList.dart';
import 'package:geniouscart/Widgets/EmptyView.dart';
import 'package:geniouscart/Widgets/ImagePlaceHolder.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/SwipeRefresh.dart';
import 'package:geniouscart/Widgets/WithdrawSkeleton.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> with TickerProviderStateMixin {
  UserTransactionsProvider provider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserTransactionsProvider>(
      create: (_) => UserTransactionsProvider()..setView(context),
      child: Consumer<UserTransactionsProvider>(
        builder: (context, model, child) {
          provider = model;
          return Scaffold(
            appBar: DefaultAppbar(context: context,title: language.Transaction),
            body: mainView(),
          );
        },
      ),
    );
  }

  Widget mainView() {
    return SwipeRefresh(
        controller: provider.controller,
        onRefresh: provider.refreshData,
        children: [
          provider.Loading ? WithdrawSkeleton(context: context,count: 10) :
          provider.transactions!=null ? provider.transactions.data.isNotEmpty ? ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: provider.transactions.data.length,
            padding: EdgeInsets.all(0),
            itemBuilder: (context, index) {
              return ListAnimation(
                  index: index,
                  child: transactionList(provider.transactions.data[index],index)
              );
            } ,
          ) : EmptyView():EmptyView(),
          Padding(
              padding: EdgeInsets.only(bottom:Dimension.Padding)
          )
        ]
    );
  }

  transactionList(TransactionData data, int index) {
    return GestureDetector(
      onTap: (){

      },
      child: Card(
        margin: EdgeInsets.all(10).copyWith(bottom: 0),
        clipBehavior: Clip.antiAlias,
        elevation: Dimension.card_elevation,
        child: Container(
          child: ExpandablePanel(
            tapBodyToCollapse: true,
            header: listHeader(data),
            expanded: listBody(data),
            tapHeaderToExpand: true,
            hasIcon: true,
            iconColor: Themes.Text_Color,
            //controller: itemExpandController[index],
          ),
        ),
      ),
    );
  }

  Widget listHeader(TransactionData data) {
    return Container(
      padding: EdgeInsets.all(10).copyWith(left: Dimension.Padding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Helper.getDateTime(data.createdAt,withYear: true),style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: Dimension.textMedium),),
                Text(data.method??'',style: Theme.of(context).textTheme.bodyText1.copyWith(fontStyle: FontStyle.italic),)
              ],
            ),
          ),
          Text('${getType(data.type)}${data.currencyCode} ${double.parse(data.amount).toStringAsFixed(1)}',style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: Dimension.textMedium,color: getTypeColor(data.type)),),
        ],
      ),
    );
  }

  String getType(String type){
    if(type=='plus')
      return '+';
    else
      return '-';
  }
  Color getTypeColor(String type){
    if(type=='plus')
      return Themes.Green;
    else
      return Themes.Red;
  }

  Widget listBody(TransactionData data) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          singleRow(language.Transaction_Number, data.txnNumber),
          singleRow(language.Payment_Via, data.method??''),
          singleRow(language.Transaction_Id, data.txnid??''),
          singleRow(language.Currency, data.currencyCode),
          singleRow(language.Details, data.details,showDivider: false),
        ],
      ),
    );
  }

  Widget singleRow(String key,String value,{bool showDivider=true}){
    return DividerList(
      showDivider: showDivider,
      child: Padding(
        padding: EdgeInsets.only(top: 5,bottom: 5,left: Dimension.Padding,right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text('$key : ',style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: Dimension.textBold),),
            ),
            Expanded(
              child: Text(value,style: Theme.of(context).textTheme.bodyText2,textAlign: TextAlign.right,),
            ),
          ],
        ),
      ),
    );
  }

}
