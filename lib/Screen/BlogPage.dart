import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:geniouscart/AppHelper/Helper.dart';
import 'package:geniouscart/Class/Blog.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Packege/flutter_html/flutter_html.dart';
import 'package:geniouscart/Packege/flutter_html/style.dart';
import 'package:geniouscart/Providers/BlogPageProvider.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/Widgets/BlogSkeleton.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/EmptyView.dart';
import 'package:geniouscart/Widgets/HeroAnimation.dart';
import 'package:geniouscart/Widgets/ImageFormNetwork.dart';
import 'package:geniouscart/Widgets/ImagePlaceHolder.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/SwipeRefresh.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';

class BlogPage extends StatefulWidget {
  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {

  BlogPageProvider blogPageProvider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BlogPageProvider>(
      create: (_)=>BlogPageProvider()..setView(context),
      child: Consumer<BlogPageProvider>(builder: (context,model,child){
        blogPageProvider=model;
        return Scaffold(
          appBar: DefaultAppbar(context: context,title: language.Blog),
          body: Container(
            child: SwipeRefresh(
                controller: blogPageProvider.refreshController,
                onRefresh: blogPageProvider.refreshPage,
                children: [
                  blogPageProvider.Loading ? BlogSkeleton(context: context) :
                  blogPageProvider.blog.data.length>0 ? ListView.builder(
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: blogPageProvider.blog.data.length,
                      itemBuilder: (context,index){
                        return ListAnimation(
                            child: blogItem(blogPageProvider.blog.data[index],index),
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

  Widget blogItem(BlogData data,int index) {
    String tag='$BLOG$index';
      return HeroAnimation(
        tag: tag,
        child: GestureDetector(
          onTap: (){
            Navigator.of(context).pushNamed(BLOG_DETAILS,arguments: {
              AppConstant.HeroTag:tag,
              AppConstant.data:data
            });
          },
          child: Card(
            margin: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding,top: Dimension.Padding),
            color: Themes.White,
            clipBehavior: Clip.antiAlias,
            elevation: Dimension.card_elevation,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: data.photo,
                        fit: BoxFit.cover,
                        width: mainWidth,
                        progressIndicatorBuilder: (context, url, downloadProgress) =>ImagePlaceHolder(height: 200),
                        errorWidget: (context, url, error) => ImagePlaceHolder(isError: true,height: 200),
                      ),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: Container(
                          color: Themes.Primary,
                          width: 60,
                          height: 60,
                          alignment: Alignment.center,
                          child: Text(Helper.getDateTime(data.createdAt.date,serverDateTime: ServerDateTime.Date).replaceAll(' ', '\n'),style: TextStyle(
                            color: Themes.White,fontSize: Dimension.Text_Size_Big,fontWeight: Dimension.textBold,
                          ),textAlign: TextAlign.center,),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                    child: Text(data.title,style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size,fontWeight: Dimension.textMedium),maxLines: 1,overflow: TextOverflow.ellipsis,),
                  ),
                  Html(
                      data: data.details,

                      style: {
                        "html": Style(
                            backgroundColor: Themes.White,
                            height: 60,
                            padding: EdgeInsets.only(bottom: 10),
                            color: Themes.Text_Color,
                            fontSize: FontSize(Dimension.Text_Size),
                        )
                      },
                      onLinkTap: (url) {
                        print("Opening $url...");
                      }
                  )
                ],
              ),
            ),
          ),
        ),
      );
  }
}
