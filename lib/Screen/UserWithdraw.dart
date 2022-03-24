import 'package:flutter/material.dart';
import 'package:geniouscart/AppHelper/Helper.dart';
import 'package:geniouscart/Class/Shipping.dart';
import 'package:geniouscart/Class/Withdraw.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Packege/Expandable/Expandable.dart';
import 'package:geniouscart/Providers/Vendor/VendorWithdrawProvider.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/DividerList.dart';
import 'package:geniouscart/Widgets/EmptyView.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/PackagingSkeleton.dart';
import 'package:geniouscart/Widgets/SwipeRefresh.dart';
import 'package:geniouscart/Widgets/WithdrawSkeleton.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';

class UserWithdraw extends StatefulWidget {
  @override
  _UserWithdrawState createState() => _UserWithdrawState();
}

class _UserWithdrawState extends State<UserWithdraw> {

  UserWithdrawProvider provider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserWithdrawProvider>(
      create: (_)=>UserWithdrawProvider()..setView(context),
      child: Consumer<UserWithdrawProvider>(
        builder: (context,model,child){
          provider=model;
          return Scaffold(
            appBar: DefaultAppbar(context: context,title: language.Withdraw),
            body: SwipeRefresh(
                controller: provider.controller,
                onRefresh: provider.refreshData,
                children: [
                  provider.Loading ? WithdrawSkeleton(context: context,count: 10) :
                  provider.withdraws!=null ? provider.withdraws.data.isNotEmpty ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: provider.withdraws.data.length,
                    padding: EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      return ListAnimation(
                          index: index,
                          child: withdrawList(provider.withdraws.data[index],index)
                      );
                    } ,
                  ) : EmptyView():EmptyView(),
                  Padding(
                      padding: EdgeInsets.only(bottom:Dimension.Padding)
                  )
                ]
            ),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: ()async{
                    var data = await Navigator.of(context).pushNamed(ADD_WITHDRAW,arguments: provider.isVendor);
                    if(data!=null){
                      provider.addNewWithdraw(data);
                    }
                },
                backgroundColor: Themes.Primary,
                label: Text(language.Add_Withdraw),
                icon: Icon(Icons.add_circle_outline),
            ),
          );
        },
      ),
    );
  }

  Widget withdrawList(WithdrawData data,int index){
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

  Color getStatusColor(String status){
    if(status==AppConstant.Pending)
      return Colors.amberAccent;
    else if(status==AppConstant.Success)
      return Colors.teal;
    else
      return Colors.redAccent;
  }

  Widget listHeader(WithdrawData data) {
    return Container(
      padding: EdgeInsets.all(10).copyWith(left: Dimension.Padding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            stops: [0.015, 0.015], colors: [getStatusColor(data.status), Colors.white]),
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
                RichText(
                  text: TextSpan(
                    text: data.method,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(fontStyle: FontStyle.italic),
                    children: [
                      TextSpan(
                        text: '  (${data.status})',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(fontStyle: FontStyle.normal,color: Themes.Grey),
                      )
                    ]
                  ),
                ),
              ],
            ),
          ),
          Text('${AppConstant.currencySymbol} ${data.amount}',style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: Dimension.textMedium),),
        ],
      ),
    );
  }

  Widget listBody(WithdrawData data) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          data.accEmail!=null ? singleRow(language.Account, data.accEmail) : Container(),
          data.fee!=null ? singleRow(language.Fee, '${AppConstant.currencySymbol} ${data.fee.toStringAsFixed(1)}') : Container(),
          data.iban!=null ? singleRow(language.iBan, data.iban??'') : Container(),
          data.country!=null ? singleRow(language.Country, data.country??'') : Container(),
          data.accName!=null ? singleRow(language.Account_Name, data.accName??'') : Container(),
          data.address!=null ? singleRow(language.Address, data.address??'') : Container(),
          data.swift!=null ? singleRow(language.Swift, data.swift??'') : Container(),
          data.reference!=null ? singleRow(language.Reference, data.reference,showDivider: false) : Container(),
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
