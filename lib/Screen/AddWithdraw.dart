import 'dart:async';
import 'dart:ui';


import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:geniouscart/Class/Gateways.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Packege/Loading_Button/Loading_Button.dart';
import 'package:geniouscart/Providers/AccountProvider.dart';
import 'package:geniouscart/Providers/DemoProvider.dart';
import 'package:geniouscart/Providers/AddWithdrawProvider.dart';
import 'package:geniouscart/Providers/SplashProvider.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/Widgets/BackButton.dart';
import 'package:geniouscart/Widgets/CircularProgress.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/DefaultDialog.dart';
import 'package:geniouscart/Widgets/DefaultTextField.dart';
import 'package:geniouscart/Widgets/ImagePlaceHolder.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';



class AddWithdraw extends StatefulWidget {
  @override
  _AddWithdrawState createState() => _AddWithdrawState();
}

class _AddWithdrawState extends State<AddWithdraw> with TickerProviderStateMixin {
  AddWithdrawProvider provider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddWithdrawProvider>(
      create: (_) => AddWithdrawProvider()..setView(context),
      child: Consumer<AddWithdrawProvider>(
        builder: (context, model, child) {
          provider = model;
          return Scaffold(
            appBar: DefaultAppbar(context: context,title: language.Add_Withdraw),
            body: Form(
                key: provider.formKey,
                child: mainView()),
          );
        },
      ),
    );
  }

  Widget mainView() {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.only(left: Dimension.Size_10,right: Dimension.Size_10),
      children: [
          Container(
            padding: EdgeInsets.all(Dimension.Size_10).copyWith(left: 0,right: 0),
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.headline1,
                text: '${language.Current_Amount} : ',
                children: [
                  TextSpan(
                    style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.Green),
                    text: '${/*isVendor ? userDashboard.data.user.affilateIncome :*/ userDashboard.data.affilateIncome}'
                  )
                ]
              ),
            ),
          ),
        Container(
          padding: EdgeInsets.all(Dimension.Size_10).copyWith(top: 0,bottom: 0),
          margin: EdgeInsets.only(bottom: Dimension.Size_10),
          height: Dimension.Size_50,
          decoration: BoxDecoration(
            color: Themes.Background,
            borderRadius: BorderRadius.circular(Dimension.Size_30),
            border: Border.all(width: 2,color: Themes.TexftFieldBorder)
          ),
          child: provider.gateways!=null ? DropdownButton<GatewayData>(
            value: provider.selectedGateway,
            isExpanded: true,
            style: Theme.of(context).textTheme.bodyText1,
            underline: Container(),
            onChanged: (GatewayData newValue)=>provider.setGateway(newValue),
            hint: Text(language.Select_an_option,style: Theme.of(context).textTheme.bodyText1.copyWith(color: Themes.Grey),),
            items: provider.gateways.data
                .map<DropdownMenuItem<GatewayData>>((GatewayData value) {
              return DropdownMenuItem<GatewayData>(
                value: value,
                child: Text(value.name),
              );
            }).toList(),
          ) : CircularProgress(),
        ),
        provider.selectedGateway!=null ? ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: provider.selectedGateway.data.length,
          itemBuilder: (context,index){
            return ListAnimation(
              index: index,
              child: Container(
                margin: EdgeInsets.only(bottom: Dimension.Size_10),
                child: DefaultTextField(
                  controller: provider.fields[index],
                  label: provider.selectedGateway.data[index].label,
                  textInputType: getTextInputType(provider.selectedGateway.data[index].type),
                  enableValidation: !provider.selectedGateway.data[index].label.toLowerCase().contains('optional')
                ),
              ),
            );
          },
        ) : Container(),
        Visibility(
          visible: provider.selectedGateway!=null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadingButton(
                isLoading: provider.submitLoading,
                onPressed: (){
                  if(provider.formKey.currentState.validate()){
                    provider.submitWithdraw();
                  }
                },
                defaultStyle: true,
                backgroundColor: Themes.Primary,
                child: Container(
                  width: mainWidth*0.4,
                  alignment: Alignment.center,
                  child: Text(language.Withdraw,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.White),),
                ),
              )
            ],
          )
        ),
        SizedBox(height: mainHeight*0.1,)
      ],
    );
  }

  TextInputType getTextInputType(String type) {
    switch(type){
      case 'text' :
      case 'textarea' :
        return TextInputType.text;
        break;
      case 'number':
        return TextInputType.number;
        break;
      default :
        return TextInputType.text;
    }
  }

}
