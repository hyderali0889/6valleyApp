import 'package:flutter/material.dart';
import 'package:geniouscart/AppHelper/Helper.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Packege/flutter_html/flutter_html.dart';
import 'package:geniouscart/Packege/flutter_html/style.dart';
import 'package:geniouscart/Providers/AboutUsProvider.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/Widgets/AboutUsSkeleton.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {

  AboutUsProvider aboutUsProvider;
  int index=0;

  @override
  Widget build(BuildContext context) {
    index=ModalRoute.of(context).settings.arguments;
    return ChangeNotifierProvider<AboutUsProvider>(
      create: (_)=>AboutUsProvider()..setView(context),
      child: Consumer<AboutUsProvider>(
        builder: (context,model,child){
          aboutUsProvider=model;
          return Scaffold(
            appBar: DefaultAppbar(context: context,title: language.Details),
            body: aboutUsProvider.Loading ? AboutUsSkeleton(context: context) : ListView(
              padding: EdgeInsets.all(0),
              children: [
                Padding(
                  padding: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding,top: Dimension.Padding),
                  child: Text(aboutUsProvider.allDetails.data[index].title,style: TextStyle(color: Themes.Text_Color,fontSize: 24,fontWeight: Dimension.textBold),),
                ),
                Html(
                    data: aboutUsProvider.allDetails.data[index].content,
                    style: {
                      "html": Style(
                        backgroundColor: Themes.Background,
                        padding: EdgeInsets.only(bottom: 10,left: 5,right: 5),
                        color: Themes.Text_Color,
                        fontSize: FontSize(Dimension.Text_Size),
                      )
                    },
                    onLinkTap: (url) {
                      Helper.goBrowser(url);
                    }
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
