import 'package:flutter/material.dart';
import 'package:geniouscart/AppHelper/Helper.dart';
import 'package:geniouscart/Class/UserPackages.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Packege/Skeleton/Skeleton.dart';
import 'package:geniouscart/Packege/flutter_html/flutter_html.dart';
import 'package:geniouscart/Packege/flutter_html/style.dart';
import 'package:geniouscart/Providers/VendorPackagesProvider.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/EmptyView.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/PackagesSkeleton.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';

class VendorPackages extends StatefulWidget {
  @override
  _VendorPackagesState createState() => _VendorPackagesState();
}

class _VendorPackagesState extends State<VendorPackages> {

  VendorPackagesProvider provider;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VendorPackagesProvider>(
      create: (_)=>VendorPackagesProvider()..setView(context),
      child: Consumer<VendorPackagesProvider>(
        builder: (context,model,child){
          provider=model;
          return Scaffold(
            appBar: DefaultAppbar(context: context,title: language.Packages),
            body: Container(
              child: ListView(
                padding: EdgeInsets.all(0),
                children: [
                  provider.Loading ? PackagesSkeleton(context) :
                  provider.userPackages!=null ? provider.userPackages.data.subs.isNotEmpty ? ListView.builder(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: provider.userPackages.data.subs.length,
                    itemBuilder: (context,index){
                      return ListAnimation(
                          child: packageItem(provider.userPackages.data.subs[index],index),
                          index: index
                      );
                    }
                  ) : EmptyView():EmptyView(),
                  Padding(
                      padding: EdgeInsets.only(bottom:Dimension.Padding)
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget packageItem(Subs sub, int index) {
    return Card(
      clipBehavior: Clip.antiAlias,
        elevation: Dimension.card_elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        ),
        margin: EdgeInsets.only(top: Dimension.Padding,left: Dimension.Padding,right: Dimension.Padding),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Themes.Grey),
            color: Themes.White
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: Dimension.Padding,bottom: Dimension.Padding),
                child: Text(sub.title,style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 24),),
              ),
              Container(
                height: 120,
                width: 120,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Themes.Primary
                ),
                child: RichText(
                  text: TextSpan(
                    text: sub.price=='0' ? '' : '${sub.currency} ',
                    style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.White),
                    children: <TextSpan>[
                      TextSpan(
                        text: sub.price=='0' ? language.Free : sub.price,
                        style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 32,color: Themes.White)
                      ),
                      TextSpan(
                        text: '\n${sub.days} ${language.Days}',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(color: Themes.White)
                      )
                    ]
                  ),
                ),
              ),
              Html(
                  data: sub.details,
                  style: {
                    "html": Style(
                      backgroundColor: Themes.White,
                      padding: EdgeInsets.all(Dimension.Padding),
                      color: Themes.Text_Color,
                      fontSize: FontSize(Dimension.Text_Size),
                      textAlign: TextAlign.center,
                    )
                  },
                  onLinkTap: (url) {
                    Helper.goBrowser(url);
                  }
              ),
              Padding(
                padding: EdgeInsets.only(bottom:Dimension.Padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    enterButton(sub),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }

  Widget enterButton(Subs subs){
    if(provider.userPackages.data.currentPackage!=null){
      if(provider.userPackages.data.currentPackage.subscriptionId==subs.id.toString()){
        return Column(
          children: [
            Container(
                width: 140,
                alignment: Alignment.center,
                height: 40,
                decoration: BoxDecoration(
                  color: Themes.Green,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Text(language.Current_Plan,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.White),)
            ),
            SizedBox(height: Dimension.Size_10,),
            Text(provider.userPackages.data.currentPackage.endDate,style: Theme.of(context).textTheme.bodyText1,)
          ],
        );
      }
      else
        return getStartedButton(subs);
    }
    else
      return getStartedButton(subs);
  }

  Widget getStartedButton(Subs subs){
    return RaisedButton(
      onPressed: (){

      },
      child: Container(
          width: 120,
          alignment: Alignment.center,
          height: 40,
          child: Text(language.Get_Started,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.White),)
      ),
      color: Themes.Primary,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
      ),
    );
  }
}
