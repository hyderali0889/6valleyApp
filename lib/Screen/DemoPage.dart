import 'dart:async';
import 'dart:ui';


import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Providers/DemoProvider.dart';
import 'package:geniouscart/Providers/SplashProvider.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/Widgets/BackButton.dart';
import 'package:geniouscart/Widgets/CircularProgress.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/DefaultDialog.dart';
import 'package:geniouscart/Widgets/ImagePlaceHolder.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';



class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> with TickerProviderStateMixin {
  DemoProvider provider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DemoProvider>(
      create: (_) => DemoProvider()..setView(context),
      child: Consumer<DemoProvider>(
        builder: (context, model, child) {
          provider = model;
          return Scaffold(
            appBar: DefaultAppbar(context: context,title: language.Send_Message),
            body: mainView(),
          );
        },
      ),
    );
  }

  Widget mainView() {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: [

      ],
    );
  }

}
