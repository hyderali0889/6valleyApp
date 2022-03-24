import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geniouscart/AppHelper/Helper.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Providers/AccountProvider.dart';
import 'package:geniouscart/Providers/MainPageProvider.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/Widgets/CircleButton.dart';
import 'package:geniouscart/Widgets/CircularProgress.dart';
import 'package:geniouscart/Widgets/DividerList.dart';
import 'package:geniouscart/Widgets/ImagePlaceHolder.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/SwipeRefresh.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';
import 'package:geniouscart/CustomIcon/my_flutter_app_icons.dart' as CustomIcon;

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> with AutomaticKeepAliveClientMixin{
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  AccountProvider accountProvider;


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AccountProvider>(
      create: (_)=>AccountProvider()..setView(context),
      child: Consumer<AccountProvider>(
        builder: (context,model,child){
          accountProvider=model;
          return Scaffold(
            body: Container(
              child: SwipeRefresh(
                controller: accountProvider.controller,
                onRefresh: accountProvider.refresh,
                children: [
                  Card(
                    margin: EdgeInsets.all(Dimension.Padding),
                    clipBehavior: Clip.antiAlias,
                    color: Themes.White,
                    elevation: Dimension.card_elevation,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: user.propic??'',
                              fit: BoxFit.cover,
                              width: 80,
                              height: 80,
                              progressIndicatorBuilder: (context, url, downloadProgress) =>ImagePlaceHolder(height: 80),
                              errorWidget: (context, url, error) => ImagePlaceHolder(isError: true,height: 80),
                            ),
                          ),
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(user.fullName??'',style: Theme.of(context).textTheme.headline1,),
                                    Text(user.email,style: Theme.of(context).textTheme.bodyText2,),
                                  ],
                                )
                            ),
                          ),
                          IconButton(
                            onPressed: ()=>accountProvider.goEditProfile(),
                            icon: accountProvider.Loading ? CircularProgress() : Icon(CustomIcon.MyFlutterApp.edit_profile,color: Themes.Primary,),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(Dimension.Padding).copyWith(top: 0),
                    clipBehavior: Clip.antiAlias,
                    color: Themes.White,
                    elevation: Dimension.card_elevation,
                    child: Container(
                      padding: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding,top: Dimension.Size_10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          user.balance!=null ? singleRow(language.Balance, double.parse(user.balance).toStringAsFixed(1)) : Container(),
                          user.affilateIncome!=null ? singleRow(language.Affilate_Income, double.parse(user.affilateIncome).toStringAsFixed(1)) : Container(),
                          Visibility(visible:user.affilateLink!=null,child: Text('${language.Affilate_Link} : ',style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: Dimension.textBold))),
                          Visibility(
                            visible: user.affilateLink!=null,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: Dimension.Size_10),
                              child: Row(
                                children: [
                                  Expanded(child: Text(user.affilateLink??'',style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.blue),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                  InkWell(
                                    onTap: ()async{
                                        Helper.copyText(context: context, text: user.affilateLink);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(Dimension.Size_5).copyWith(left: Dimension.Size_10,right: Dimension.Size_10),
                                      margin: EdgeInsets.only(left: Dimension.Size_10),
                                      decoration: BoxDecoration(
                                          color: Themes.Primary,
                                          borderRadius: BorderRadius.circular(Dimension.Size_5)
                                      ),
                                      child: Text(language.Copy,style: Theme.of(context).textTheme.bodyText1.copyWith(color: Themes.White),),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ),
                  ),
                  ListView.builder(
                      padding: EdgeInsets.all(0),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: accountProvider.sections.length,
                      itemBuilder: (context,index){
                        return ListAnimation(
                            child: sectionItem(accountProvider.sections[index],index),
                            index: index
                        );
                      }
                  ),

//TODO start selling comment
/*                  Padding(
                    padding: EdgeInsets.all(Dimension.Padding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                          onPressed: ()=>Navigator.of(context).pushNamed(VENDOR_PACKAGES),
                          child: Container(
                              width: 120,
                              alignment: Alignment.center,
                              height: 40,
                              child: Text(language.Start_Selling,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.White),)
                          ),
                          color: Themes.Primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),
                        ),
                      ],
                    ),
                  )*/
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  Widget singleRow(String key,String value,{bool showDivider=false}){
    return DividerList(
      showDivider: showDivider,
      child: Padding(
        padding: EdgeInsets.only(bottom: Dimension.Size_10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text('$key : ',style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: Dimension.textBold),),
            ),
            Expanded(
              child: Text('${AppConstant.currencySymbol}$value',style: Theme.of(context).textTheme.bodyText2.copyWith(color: Themes.Green),textAlign: TextAlign.right,),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionItem(Section section, int index) {
    return DividerList(
      child: ListTile(
        onTap: (){
          if(section.name==language.Account_Sections[10]){
            accountProvider.logoutUser();
          }
          else{
            try{
              Navigator.of(context).pushNamed(section.route,arguments: language.Account_Sections[11]==section.name ? null : section.name);
            }catch(e){}
          }
        },
        title: Text(section.name,style: Theme.of(context).textTheme.bodyText1,),
        trailing: section.name==language.Account_Sections[10] ? CircleButton(
            onTap: ()=>accountProvider.logoutUser(),
            child: Icon(section.icon,color: Themes.Primary,),
            loading: accountProvider.logoutLoading
        ): Icon(section.icon,color: Themes.Primary,),
      )
    );
  }

}
