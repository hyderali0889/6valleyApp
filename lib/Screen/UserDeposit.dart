import 'dart:async';
import 'dart:ui';


import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:geniouscart/AppHelper/Helper.dart';
import 'package:geniouscart/Class/Deposit.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Packege/Expandable/Expandable.dart';
import 'package:geniouscart/Providers/DemoProvider.dart';
import 'package:geniouscart/Providers/SplashProvider.dart';
import 'package:geniouscart/Providers/UserDepositProvider.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/Api_Client2.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/BackButton.dart';
import 'package:geniouscart/Widgets/CircularProgress.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/DefaultDialog.dart';
import 'package:geniouscart/Widgets/DefaultTextField.dart';
import 'package:geniouscart/Widgets/DividerList.dart';
import 'package:geniouscart/Widgets/EmptyView.dart';
import 'package:geniouscart/Widgets/ImagePlaceHolder.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/SwipeRefresh.dart';
import 'package:geniouscart/Widgets/WithdrawSkeleton.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';

class UserDeposit extends StatefulWidget {
  @override
  _UserDepositState createState() => _UserDepositState();
}

class _UserDepositState extends State<UserDeposit> with TickerProviderStateMixin {
  UserDepositProvider provider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserDepositProvider>(
      create: (_) => UserDepositProvider()..setView(context),
      child: Consumer<UserDepositProvider>(
        builder: (context, model, child) {
          provider = model;
          return Scaffold(
            appBar: DefaultAppbar(context: context,title: language.Deposit),
            body: mainView(),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: (){
                  //Navigator.of(context).pushNamed(PAYMENT_GATEWAY);
                  submitDeposit();
                },
                label: Text(language.Deposit,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.White),),
              icon: Icon(Icons.add_circle_outline_outlined,color: Themes.White,),
              backgroundColor: Themes.Primary,
            ),
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
          provider.deposit!=null ? provider.deposit.data.isNotEmpty ? ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: provider.deposit.data.length,
            padding: EdgeInsets.all(0),
            itemBuilder: (context, index) {
              return ListAnimation(
                  index: index,
                  child: withdrawList(provider.deposit.data[index],index)
              );
            } ,
          ) : EmptyView():EmptyView(),
          Padding(
              padding: EdgeInsets.only(bottom:Dimension.Padding)
          )
        ]
    );
  }

  withdrawList(DepositData data, int index) {
    return Card(
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
    );
  }

  Color getStatusColor(int status){
    if(status==0)
      return Colors.amberAccent;
    else if(status==1)
      return Colors.teal;
    else
      return Colors.redAccent;
  }

  Widget listHeader(DepositData data) {
    return Container(
      padding: EdgeInsets.all(10).copyWith(left: Dimension.Padding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            stops: [0.015, 0.015], colors: [getStatusColor(int.parse(data.status)), Colors.white]),
      ),
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
          Text('${data.currencyCode} ${double.parse(data.amount).toStringAsFixed(2)}',style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: Dimension.textMedium),),
          Visibility(
            visible: data.paymentUrl!=null,
            child: InkWell(
              onTap: ()async{
                var response = await Navigator.of(context).pushNamed(PAYMENT_PAGE, arguments: {
                  AppConstant.url:data.paymentUrl,
                });
                if(response!=null)if(response==true) {
                  provider.getData();
                }
              },
              child: Container(
                padding: EdgeInsets.all(Dimension.Size_5).copyWith(left: Dimension.Size_10,right: Dimension.Size_10),
                margin: EdgeInsets.only(left: Dimension.Size_10),
                decoration: BoxDecoration(
                  color: Themes.Green,
                  borderRadius: BorderRadius.circular(Dimension.Size_5)
                ),
                child: Text(language.Pay_Now,style: Theme.of(context).textTheme.bodyText1.copyWith(color: Themes.White),),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget listBody(DepositData data) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          singleRow(language.Transaction_Id, data.txnid??''),
          singleRow(language.Currency, data.currencyCode,showDivider: false),
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

  void submitDeposit()async{
    var data = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
        return DefaultDialog(
          title: language.Deposit,
          child: AddDeposit(),
        );
        }
    );
    if(data!=null)
      provider.getData();
  }

}

class AddDeposit extends StatefulWidget {
  @override
  _AddDepositState createState() => _AddDepositState();
}

class _AddDepositState extends State<AddDeposit> {

  bool Loading=false;
  GlobalKey<FormState> formKey=GlobalKey();
  TextEditingController amount=TextEditingController();

  changeState(){
    if(mounted)
      setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: Loading,
      child: Form(
        key: formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(0),
          children: [
            Padding(
              padding: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding),
              child: DefaultTextField(
                controller: amount,
                label: language.Amount,
                textInputType: TextInputType.number
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FlatButton(
                  child: Text(language.Close,style: TextStyle(color: Themes.Primary,fontSize: Dimension.Text_Size_Small_Extra,fontWeight: Dimension.textBold),),
                  onPressed: ()=>Navigator.pop(context),
                ),
                Loading ? Padding(
                  padding: EdgeInsets.only(right: Dimension.Padding),
                  child: CircularProgress(size: 20),
                ) : FlatButton(
                  child: Text(language.Submit,style: TextStyle(color: Themes.Green,fontSize: Dimension.Text_Size_Small_Extra,fontWeight: Dimension.textBold),),
                  onPressed: (){
                    if(formKey.currentState.validate()){
                        storeDeposit();
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future storeDeposit() async {
    Loading=true;
    changeState();
    await ApiClient2.Request(context,
        url: URL.Deposit_Store,
        body: {
          AppConstant.amount:amount.text,
          AppConstant.currency_code:appCurrency.name
        },
        method: Method.POST,
        onSuccess: (data)async{
          var response = await Navigator.of(context).pushNamed(PAYMENT_PAGE, arguments: {
            AppConstant.url:data[AppConstant.data],
          });
          if(response!=null)if(response==true) {
            Navigator.of(context).pop(response);
          }
          else{
            Navigator.of(context).pop(true);
          }
        },
        onError: (data){
        }
    );
    Loading=false;
    changeState();
  }

}
