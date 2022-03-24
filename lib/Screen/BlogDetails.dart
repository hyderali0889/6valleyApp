import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geniouscart/AppHelper/Helper.dart';
import 'package:geniouscart/Class/Blog.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Packege/flutter_html/flutter_html.dart';
import 'package:geniouscart/Packege/flutter_html/style.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/Widgets/BackButton.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/HeroAnimation.dart';
import 'package:geniouscart/Widgets/ImagePlaceHolder.dart';

import '../main.dart';

class BlogDetails extends StatefulWidget {
  @override
  _BlogDetailsState createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
  var data;
  BlogData details;

  @override
  Widget build(BuildContext context) {
    data=ModalRoute.of(context).settings.arguments;
    details=data[AppConstant.data];
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.all(0),
            children: [
              heroWidget()
            ],
          ),
          DefaultBackButton(context)
        ],
      ),
    );
  }

  Widget heroWidget(){
    return HeroAnimation(
      tag: data[AppConstant.HeroTag],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl: details.photo,
                fit: BoxFit.cover,
                width: mainWidth,
                progressIndicatorBuilder: (context, url, downloadProgress) =>ImagePlaceHolder(height: 250),
                errorWidget: (context, url, error) => ImagePlaceHolder(isError: true),
              ),
              Positioned(
                left: 0,
                bottom: 0,
                child: Container(
                  color: Themes.Primary,
                  width: 60,
                  height: 60,
                  alignment: Alignment.center,
                  child: Text(Helper.getDateTime(details.createdAt.date,serverDateTime: ServerDateTime.Date).replaceAll(' ', '\n'),style: TextStyle(
                    color: Themes.White,fontSize: Dimension.Text_Size_Big,fontWeight: Dimension.textBold,
                  ),textAlign: TextAlign.center,),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 10,right: 10,top: 10),
            child: Text(details.title,style: TextStyle(color: Themes.Text_Color,fontSize: 24,fontWeight: Dimension.textBold),),
          ),
          Wrap(
            children: [
              FlatButton.icon(
                  onPressed: null,
                  icon: Icon(Icons.calendar_today,color: Themes.Primary.withAlpha(Dimension.Alpha),),
                  label: Text(Helper.getDateTime(details.createdAt.date,serverDateTime: ServerDateTime.Date,withYear: true),style: Theme.of(context).textTheme.bodyText1,)
              ),
              FlatButton.icon(
                  onPressed: null,
                  icon: Icon(Icons.visibility,color: Themes.Primary.withAlpha(Dimension.Alpha),),
                  label: Text('${details.views} ${language.Views}',style: Theme.of(context).textTheme.bodyText1)
              ),
              FlatButton.icon(
                  onPressed: null,
                  icon: Icon(Icons.comment,color: Themes.Primary.withAlpha(Dimension.Alpha),),
                  label: Text('${language.Source} : ${details.source}',style: Theme.of(context).textTheme.bodyText1)
              ),
            ],
          ),
          Html(
              data: details.details,
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
  }
}
