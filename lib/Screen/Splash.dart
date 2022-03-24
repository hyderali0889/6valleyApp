import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geniouscart/Providers/SplashProvider.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:provider/provider.dart';


import '../main.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash>{

  SplashProvider splashProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    Api_Client.config(context);
    mainHeight=MediaQuery.of(context).size.height;
    mainWidth=MediaQuery.of(context).size.width;
    paddingTop=MediaQuery.of(context).padding.top;
    splashProvider=Provider.of<SplashProvider>(context);
    appbarHeight=DefaultAppbar(context: context,title: 'Demo').preferredSize.height;
    return Scaffold(
      backgroundColor: Themes.White,
      body: Center(child: Image.asset('assets/images/loading.gif',fit: BoxFit.cover,)),
    );
  }
}
