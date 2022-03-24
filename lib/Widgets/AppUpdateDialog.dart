import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/main.dart';
import 'package:flutter/material.dart';

class AppUpdateDialog extends StatefulWidget {
  String appVersion,latestAppVersion;
  AppUpdateDialog({this.appVersion, this.latestAppVersion});

  @override
  _AppUpdateDialogState createState() => _AppUpdateDialogState();
}

class _AppUpdateDialogState extends State<AppUpdateDialog> {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: ListView(
        padding: EdgeInsets.all(Dimension.Padding),
        shrinkWrap: true,
        children: <Widget>[
          Container(
            height: 100,
            width: 100,
            padding: EdgeInsets.only(top:Dimension.Padding,bottom: Dimension.Padding),
            margin: EdgeInsets.only(bottom: Dimension.Padding),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Themes.Primary,
            ),
            child: Image.asset('assets/images/logo_transparent.png',height: 80,width: 80,color: Colors.white,),
          ),
          Text(language.Update_your_app,style: TextStyle(color: Themes.Text_Color,fontSize: 24,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
          Padding(
            padding: EdgeInsets.only(top: Dimension.Padding),
            child: Text(language.You_are_using_an_outdated_vestion_of+" ${AppConstant.AppName}",style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size_Big,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
          ),
          Padding(
            padding: EdgeInsets.only(top: Dimension.Padding),
            child: Text(language.Latest_version_code+" ${widget.latestAppVersion}",style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size,fontWeight: FontWeight.normal),textAlign: TextAlign.center,),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5,bottom: Dimension.Padding),
            child: Text(language.Your_version_code+" ${widget.appVersion}",style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size,fontWeight: FontWeight.normal),textAlign: TextAlign.center,),
          ),
          GestureDetector(
            onTap: (){
                Navigator.of(context).pop(true);
            },
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Themes.Primary,
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: Text(language.Download.toUpperCase(),style: TextStyle(color: Colors.white,fontSize: Dimension.Text_Size_Big,fontWeight: FontWeight.normal),),
            ),
          )
        ],
      ),
    );
  }
}
