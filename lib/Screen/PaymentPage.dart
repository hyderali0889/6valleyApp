import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';


import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Language/AppLocalizations.dart';
import 'package:geniouscart/Packege/Loading_Button/Loading_Button.dart';
import 'package:geniouscart/Providers/PaymentPageProvider.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/Widgets/CircularProgress.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/DefaultDialog.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';



class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> with TickerProviderStateMixin {
  PaymentPageProvider provider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    //provider=Provider.of<HomePageProvider>(context)..setView(context);
    return ChangeNotifierProvider<PaymentPageProvider>(
      create: (_) => PaymentPageProvider()..setView(context),
      child: Consumer<PaymentPageProvider>(
        builder: (context, model, child) {
          provider = model;
          return Scaffold(
            appBar: DefaultAppbar(context: context,title: language.Payment),
            body: Builder(builder: (BuildContext context) {
              return Container(
                //onWillPop: back,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    WebView(
                      initialUrl: provider.webUrl,
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (WebViewController webViewController) {
                        Map<String, String> headers = {'Authorization':'${AppConstant.Bearer} ${auth.data.token}'};
                        webViewController.loadUrl(provider.webUrl, headers: headers);
                        provider.controller.complete(webViewController);
                        provider.webViewController = webViewController;
                      },
                      javascriptChannels: Set.from([
                        JavascriptChannel(
                            name: 'Print',
                            onMessageReceived: (JavascriptMessage message) {
                              Map<String,dynamic> data=jsonDecode(message.message);
                              showSuccessDialog(data);
                            })
                      ]),
                      navigationDelegate: (NavigationRequest action) {
                        return NavigationDecision.navigate;
                      },
                      debuggingEnabled: true,
                      onPageStarted: (String url) {
                        provider.startLoading();
                      },
                      onPageFinished: (String url) {
                        provider.finishLoading();
                      },
                      gestureNavigationEnabled: true,
                    ),
                    IgnorePointer(
                      ignoring: true,
                      child: Visibility(visible:provider.Loading,child: CircularProgress(size: Dimension.Size_30,width: 2)),
                    )
                  ],
                ),
              );
            }),
          );
        },
      ),
    );
  }


  void showSuccessDialog(Map<String, dynamic> data) async{
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
              child: DefaultDialog(
                title: data['status'] ? language.Success : language.Failed,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: Dimension.Padding,
                          right: Dimension.Padding,
                          top: Dimension.Size_10),
                      child: Text(data['data'], style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1,),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FlatButton(
                          child: Text(language.OK, style: TextStyle(
                              color: Themes.Green,
                              fontSize: Dimension.Text_Size_Small_Extra,
                              fontWeight: Dimension.textBold),),
                          onPressed: () {
                            Navigator.of(context).pop();
                            if (data['status'])
                              Navigator.of(context).pop(true);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
              onWillPop: back
          );
        }
    );
  }

 /* Future<bool> back()async {
    if (await provider.controller.canGoBack()) {
    await provider.controller.goBack();
    } else {
      Navigator.of(context).pop();
    }
  }*/


  Future<bool> back() {
  }
}