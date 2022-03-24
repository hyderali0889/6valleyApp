import 'package:flutter/material.dart';
import 'package:geniouscart/Class/FaqModel.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Packege/Expandable/Expandable.dart';
import 'package:geniouscart/Providers/FaqPageProvider.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/EmptyView.dart';
import 'package:geniouscart/Widgets/FaqSkeleton.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/SwipeRefresh.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';

class FaqPage extends StatefulWidget {
  @override
  _FaqPageState createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {

  FaqPageProvider faqPageProvider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FaqPageProvider>(
      create: (_)=>FaqPageProvider()..setView(context),
      child: Consumer<FaqPageProvider>(builder: (context,model,child){
        faqPageProvider=model;
        return Scaffold(
          appBar: DefaultAppbar(context: context,title: language.Faq),
          body: Container(
            child: SwipeRefresh(
                controller: faqPageProvider.refreshController,
                onRefresh: faqPageProvider.refreshPage,
                children: [
                  faqPageProvider.Loading ? FaqSkeleton(context: context) :
                  faqPageProvider.faqs.data.length>0 ? ListView.builder(
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: faqPageProvider.faqs.data.length,
                      itemBuilder: (context,index){
                        return ListAnimation(
                            child: faqItem(faqPageProvider.faqs.data[index],index),
                            index: index
                        );
                      }
                  ) : EmptyView(),
                  Padding(
                    padding: EdgeInsets.only(bottom: 100),
                  )
                ]
            ),
          ),
        );
      },),
    );
  }

  Widget faqItem(FaqData data, int index) {
    return ExpandablePanel(
      tapBodyToCollapse: true,
      header: faqHeader(data),
      expanded: faqBody(data),
      tapHeaderToExpand: true,
      hasIcon: false,
      iconColor: Themes.Icon_Color,
      //controller: itemExpandController[index],
    );
  }
  Widget faqHeader(FaqData data){
    return Card(
      margin: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding,top: Dimension.Padding),
      clipBehavior: Clip.antiAlias,
      elevation: Dimension.card_elevation,
      color: Themes.Primary,
      child: Container(
        width: mainWidth-(Dimension.Padding*2),
        padding: EdgeInsets.all(Dimension.Padding),
        child: Text(data.title,style: TextStyle(color: Themes.White,fontSize: Dimension.Text_Size_Big,fontWeight: Dimension.textBold),),
      ),
    );
  }
  Widget faqBody(FaqData data){
    return Card(
      margin: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding),
      clipBehavior: Clip.antiAlias,
      elevation: Dimension.card_elevation,
      color: Themes.White,
      child: Container(
        width: mainWidth-(Dimension.Padding*2),
        padding: EdgeInsets.all(Dimension.Padding),
        child: Text(data.details,style: Theme.of(context).textTheme.bodyText1,),
      ),
    );
  }
}
