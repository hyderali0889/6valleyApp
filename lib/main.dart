import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geniouscart/AppHelper/AppTheme.dart';
import 'package:geniouscart/Class/AppSettings.dart';
import 'package:geniouscart/Class/Auth.dart';
import 'package:geniouscart/Class/Currencies.dart';
import 'package:geniouscart/Class/PageSetting.dart';
import 'package:geniouscart/Class/User.dart';
import 'package:geniouscart/Language/Language.dart';
import 'package:geniouscart/Providers/AccountProvider.dart';
import 'package:geniouscart/Providers/CartProvider.dart';
import 'package:geniouscart/Providers/HomeProvider.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Class/SectionCustomization.dart';
import 'Class/SocialSetting.dart';
import 'Language/AppLocalizations.dart';
import 'Providers/MainPageProvider.dart';
import 'Providers/SearchProductProvider.dart';
import 'Providers/SplashProvider.dart';
import 'Route/Route.dart';
import 'Widgets/ListScrollBehavior.dart';

Language language = Language();
SharedPreferences prefs;
String appLocale = AppConstant.Default_Language;
AppLocale mainLocale = AppConstant.Default_Locale;

AppSetting appSetting;
PageSetting pageSetting;
SocialSetting socialSetting;
SectionCustomization customization;
Auth auth;
User user;
String userType;
bool isVendor;

Currencies currencies;
List<String> currencyName=List();
Currency appCurrency;
Currency defaultCurrency;

double mainHeight, mainWidth, paddingTop, appbarHeight;

String firebaseToken;

void main() {
  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => AccountProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => MainPageProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => SearchProductProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light));
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppProvider>(
        create: (BuildContext context) => AppProvider(),
        child: Consumer<AppProvider>(builder: (context, model, child) {
          return ConnectivityAppWrapper(
            app: MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: Locale(appLocale),
              supportedLocales: LocaleHelper.getAllLocale(),
              builder: (context, child) {
                /*ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
                    return buildError(context, errorDetails);
                  };*/
                return ScrollConfiguration(
                  behavior: ListScrollBehavior(),
                  child: child,
                );
              },
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate
              ],
              theme: AppTheme(),
              routes: appRoutes(),
              initialRoute: SPLASH_SCREEN,
          ));
        }));
  }
}

String actualPrice(String price,{bool withSign=true}) {
  return '${withSign ? '${appCurrency.sign} ':''}${(double.parse(appCurrency.value) * double.parse(price)).toStringAsFixed(1)}';
}
