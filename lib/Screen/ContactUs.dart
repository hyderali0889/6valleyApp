import 'package:flutter/material.dart';
import 'package:geniouscart/AppHelper/Helper.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Packege/Loading_Button/Loading_Button.dart';
import 'package:geniouscart/Packege/flutter_html/flutter_html.dart';
import 'package:geniouscart/Packege/flutter_html/style.dart';
import 'package:geniouscart/Providers/ContactUsProvider.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/DefaultTextField.dart';
import 'package:geniouscart/Widgets/KeyboardHandler.dart';
import 'package:geniouscart/Widgets/SocialView.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  ContactUsProvider provider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContactUsProvider>(
      create: (_)=>ContactUsProvider()..setView(context),
      child: Consumer<ContactUsProvider>(
        builder: (context,model,child){
          provider=model;
          return Scaffold(
            appBar: DefaultAppbar(context: context,title: language.Contact_us),
            body: KeyboardHandler(
              config: provider.configuration(),
              child: Form(
                key: provider.fromKey,
                child: Container(
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    children: [
                      Html(
                          data: pageSetting.data.contactTitle,
                          style: {
                            "html": Style(
                              padding: EdgeInsets.only(left:Dimension.Padding,right: Dimension.Padding),
                            ),
                            "h2": Style(
                              color: Themes.Primary
                            ),
                          },
                          onLinkTap: (url) {
                            Helper.goBrowser(url);
                          }
                      ),
                      Html(
                          data: pageSetting.data.contactText,
                          style: {
                            "html": Style(
                              padding: EdgeInsets.only(left:Dimension.Padding,right: Dimension.Padding),
                              fontSize: FontSize(Dimension.Text_Size)
                            )
                          },
                          onLinkTap: (url) {
                            Helper.goBrowser(url);
                          }
                      ),
                      Padding(
                        padding: EdgeInsets.only(left:Dimension.Padding,right: Dimension.Padding),
                        child: DefaultTextField(
                          controller: provider.name,
                          label: language.Name,
                          isRequired: true,
                          prefixIcon: Icons.person_outline
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left:Dimension.Padding,right: Dimension.Padding,top: Dimension.Padding),
                        child: DefaultTextField(
                            controller: provider.phone,
                            label: language.Phone_Number,
                            isRequired: true,
                            prefixIcon: Icons.phone,
                            textInputType: TextInputType.phone,
                            focusNode: provider.phoneFocusNode
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left:Dimension.Padding,right: Dimension.Padding,top: Dimension.Padding),
                        child: DefaultTextField(
                          controller: provider.email,
                          label: language.Email,
                          textInputType: TextInputType.emailAddress,
                          isRequired: true,
                          prefixIcon: Icons.mail_outline
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left:Dimension.Padding,right: Dimension.Padding,top: Dimension.Padding),
                        child: DefaultTextField(
                          controller: provider.message,
                          label: language.Your_Message,
                          isRequired: true,
                          maxLine: 5
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Dimension.Padding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LoadingButton(
                              isLoading: provider.Loading,
                              onPressed: (){
                                if(provider.fromKey.currentState.validate()){
                                  provider.requestSubmitMessage();
                                }
                              },
                              defaultStyle: true,
                              child: Container(
                                  width: 140,
                                  alignment: Alignment.center,
                                  child: Text(language.Send_Message,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.White),)
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Themes.Primary
                              ),
                            )
                          ],
                        ),
                      ),
                      infoSection(
                        icon: Icons.email,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(pageSetting.data.site,style: Theme.of(context).textTheme.bodyText1,),
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(pageSetting.data.email,style: Theme.of(context).textTheme.bodyText1,),
                            ),
                          ],
                        )
                      ),
                      infoSection(
                          icon: Icons.location_on,
                          child: Padding(
                            padding: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding),
                            child: Text(pageSetting.data.street,style: Theme.of(context).textTheme.bodyText1,),
                          )
                      ),
                      infoSection(
                          icon: Icons.phone_android,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(pageSetting.data.phone,style: Theme.of(context).textTheme.bodyText1,),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(pageSetting.data.fax,style: Theme.of(context).textTheme.bodyText1,),
                              ),
                            ],
                          )
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding,bottom: Dimension.Padding),
                        child: Text('${language.Find_Us_Here} :',style: Theme.of(context).textTheme.headline1,),
                      ),
                      SocialView(),
                      SizedBox(
                        height: Dimension.Padding,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget infoSection({Widget child,IconData icon}){
    return Card(
      margin: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding,bottom: Dimension.Padding),
      elevation: Dimension.card_elevation,
      clipBehavior: Clip.antiAlias,
      color: Themes.White,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              margin: EdgeInsets.only(top: Dimension.Padding,bottom: Dimension.Padding),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Themes.Primary
              ),
              child: Icon(icon,color: Themes.White,size: 40,),
            ),
            child,
            Container(
              margin: EdgeInsets.only(top: Dimension.Padding),
              height: 5,
              color: Themes.Primary,
            )
          ],
        ),
      ),
    );
  }
}
