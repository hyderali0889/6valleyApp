import 'package:flutter/material.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Packege/Loading_Button/Loading_Button.dart';
import 'package:geniouscart/Packege/Switcher/xlive_switch.dart';
import 'package:geniouscart/Providers/Vendor/VendorSocialLinksProvider.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/DefaultTextField.dart';
import 'package:geniouscart/Widgets/ImageFormNetwork.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';

class VendorSocialLinks extends StatefulWidget {
  @override
  _VendorSocialLinksState createState() => _VendorSocialLinksState();
}

class _VendorSocialLinksState extends State<VendorSocialLinks> {

  VendorSocialLinksProvider provider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VendorSocialLinksProvider>(
      create: (_)=>VendorSocialLinksProvider()..setView(context),
      child: Consumer<VendorSocialLinksProvider>(
        builder: (context,model,child){
          provider=model;
          return Scaffold(
            appBar: DefaultAppbar(context: context,title: ModalRoute.of(context).settings.arguments.toString()),
            body: ListView(
              padding: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding),
              children: [
                Padding(
                  padding: EdgeInsets.only(top: Dimension.Padding),
                  child: Row(
                    children: [
                      Expanded(
                        child: DefaultTextField(
                          controller: provider.google,
                          label: language.Google,
                          isRequired: true
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: XlivSwitch(
                          value: provider.linkStatus[0],
                          onChanged: (state)=>provider.changeLinkStatus(status: state,index: 0),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Dimension.Padding),
                  child: Row(
                    children: [
                      Expanded(
                        child: DefaultTextField(
                            controller: provider.facebook,
                            label: language.Facebook,
                            isRequired: true
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: XlivSwitch(
                          value: provider.linkStatus[1],
                          onChanged: (state)=>provider.changeLinkStatus(status: state,index: 1),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Dimension.Padding),
                  child: Row(
                    children: [
                      Expanded(
                        child: DefaultTextField(
                            controller: provider.twitter,
                            label: language.Twitter,
                            isRequired: true
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: XlivSwitch(
                          value: provider.linkStatus[2],
                          onChanged: (state)=>provider.changeLinkStatus(status: state,index: 2),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Dimension.Padding),
                  child: Row(
                    children: [
                      Expanded(
                        child: DefaultTextField(
                            controller: provider.linkedIn,
                            label: language.LinkedIn,
                            isRequired: true
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: XlivSwitch(
                          value: provider.linkStatus[3],
                          onChanged: (state)=>provider.changeLinkStatus(status: state,index: 3),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Dimension.Padding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      LoadingButton(
                        isLoading: provider.Loading,
                        onPressed: (){
                          provider.updateData();
                        },
                        defaultStyle: true,
                        decoration: BoxDecoration(
                            color: Themes.Primary,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10,right: 10),
                          child: Text(language.Save,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.White),),
                        ),
                      ),
                    ],
                  ),
                )
              ]
            ),
          );
        },
      ),
    );
  }
}
