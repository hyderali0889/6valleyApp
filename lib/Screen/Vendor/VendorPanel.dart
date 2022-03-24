import 'package:flutter/material.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Providers/Vendor/VendorPanelProvider.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';

class VendorPanel extends StatefulWidget {
  @override
  _VendorPanelState createState() => _VendorPanelState();
}

class _VendorPanelState extends State<VendorPanel> with TickerProviderStateMixin{

  VendorPanelProvider provider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VendorPanelProvider>(
        create: (_)=>VendorPanelProvider()..setView(context),
        child: Consumer<VendorPanelProvider>(
          builder: (context,model,child){
            provider=model;
            if(provider.controllers.isEmpty){
              provider.setAnimation(this);
            }
            return Scaffold(
              appBar: DefaultAppbar(context: context,title: language.Vendor_Panel),
              body: Container(
                child: ListView(
                  padding: EdgeInsets.all(0),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(0),
                      itemCount: provider.sections().length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index){
                        return ListAnimation(
                            child: sections(provider.sections()[index],index),
                            index: index
                        );
                      }
                    ),
                    SizedBox(
                      height: Dimension.Padding,
                    )
                  ],
                ),
              ),
            );
          },
        ),
    );
  }

  Widget sections(Section section, int index) {
    return GestureDetector(
      onTap: (){
        if(section.subSections.isEmpty){
          try{
            Navigator.of(context).pushNamed(section.route,arguments: section.name);
          }catch(e){}
        }
      },
      child: Card(
        margin: EdgeInsets.all(10).copyWith(bottom: 0),
        elevation: Dimension.card_elevation,
        clipBehavior: Clip.antiAlias,
        child: AbsorbPointer(
          absorbing: section.subSections.isEmpty,
          child: ExpansionTile(
            childrenPadding: EdgeInsets.only(bottom: 10),
            trailing: section.subSections.isEmpty ? Container(height: 10,width: 10,) : RotationTransition(
              turns: provider.rotation[index],
              child: const Icon(Icons.expand_more),
            ),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(section.icon,color: Themes.Primary,),
                SizedBox(
                  width: Dimension.Padding,
                ),
                Expanded(child: Text(section.name,style:Theme.of(context).textTheme.bodyText1)),
              ],
            ),
            children: section.subSections.asMap().map((subIndex,e) => MapEntry(
                subIndex,
                subSection(e,index,subIndex)
            )).values.toList(),
            onExpansionChanged: (state){
              provider.changeAnimation(index, state);
            },
          ),
        ),
      ),
    );
  }

  Widget subSection(SubSection subSection, int index, int subIndex) {
    return GestureDetector(
      onTap: (){
        try{
          Navigator.of(context).pushNamed(subSection.route,arguments: subSection.name);
        }catch(e){}
      },
      child: ListAnimation(
          child: Container(
            height: 40,
            margin: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Expanded(child: Text(subSection.name,style: Theme.of(context).textTheme.bodyText1.copyWith(color: Themes.Primary),)),
                SizedBox(width: Dimension.Padding,),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
          index: subIndex
      ),
    );
  }
}
