import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:geniouscart/Class/Currencies.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Language/AppLocalizations.dart';
import 'package:geniouscart/Providers/MainPageProvider.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/Screen/Account.dart';
import 'package:geniouscart/Screen/Authentication/Authentication.dart';
import 'package:geniouscart/Screen/Authentication/Registration.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/CircularProgress.dart';
import 'package:geniouscart/Widgets/DefaultCartIcon.dart';
import 'package:geniouscart/Widgets/DividerList.dart';
import 'package:geniouscart/Widgets/HeroAnimation.dart';
import 'package:geniouscart/Widgets/OfflineStatus.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';
import 'package:geniouscart/CustomIcon/my_flutter_app_icons.dart' as CustomIcon;

import 'Category/AllCategorys.dart';
import 'Cart.dart';
import 'Home.dart';

MainPageProvider mainPageProvider;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}
class _MainScreenState extends State<MainScreen>

    with TickerProviderStateMixin {




  var iconData = <IconData>[
    Icons.home,
    CustomIcon.MyFlutterApp.category,
    Icons.shopping_cart,
    Icons.account_circle,
  ];

  var badges = <int>[null, null, null, null];

  var iconText = <String>[
    language.HomeTabs[0],
    language.HomeTabs[1],
    language.HomeTabs[3],
    language.HomeTabs[2],
  ];




  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(mainPageProvider==null){
      Api_Client.config(context);
      mainPageProvider=Provider.of<MainPageProvider>(context);
      mainPageProvider.appProvider=Provider.of<AppProvider>(context);
      mainPageProvider.tabController = TabController(vsync: this, initialIndex: 0, length: 4);
      mainPageProvider.tabController.addListener(mainPageProvider.onTabViewChange);
      mainPageProvider.animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
      mainPageProvider.animation = Tween(begin: 0, end: 60).animate(mainPageProvider.animationController)
        ..addListener(() {
          mainPageProvider.navigationDrawerButton();
        });
    }
    return InnerDrawer(
      key: mainPageProvider.innerDrawerKey,
      onTapClose: false,
      tapScaffoldEnabled: true,
      /*leftOffset: 0.3,
      rightOffset: 0.4,*/
      offset: IDOffset.only(left: 0.3,right: 0.4),
      swipe: false,
      colorTransitionChild: Colors.black54,
      leftAnimationType: InnerDrawerAnimation.static,
      rightAnimationType: InnerDrawerAnimation.static,
      scaffold: Builder(
        builder: (context){
          double navBarHeight = scaledHeight(context, 85);
          return Scaffold(
              backgroundColor: Themes.Primary,
              appBar: AppBar(
                backgroundColor: Themes.Primary,
                centerTitle: true,
                title: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Image.network(
                          URL.assets+appSetting.data.footerLogo,
                          height: Dimension.Size_30,
                          color: Themes.White,
                        ),
                      ),
                    ),
                    Container(
                      height: Dimension.Size_36,
                      padding: EdgeInsets.only(left: Dimension.Size_10),
                      margin: EdgeInsets.only(right: Dimension.Size_5,left: Dimension.Size_10),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(Dimension.Size_5,),
                        //border: Border.all(color: Themes.White)
                      ),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: Themes.Primary,
                        ),
                        child: DropdownButton<String>(
                          value: appCurrency.name,
                          isExpanded: false,
                          icon: Icon(Icons.arrow_drop_down,color: Themes.White,),
                          underline: Container(),
                          onChanged: (String newValue) {
                            mainPageProvider.changeCurrency(newValue);
                          },
                          items: currencyName.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,style: Theme.of(context).textTheme.bodyText1.copyWith(color: Themes.White),),
                            );
                          }).toList(),
                        ),
                      ),
                    )
                  ],
                ),
                leading: FlatButton(
                  onPressed: () async{
                    mainPageProvider.innerDrawerKey.currentState.toggle();
                    if(mainPageProvider.is_open_drawer)
                    {mainPageProvider.animationController.reverse();}
                    else{
                      mainPageProvider.animationController.forward();
                    }
                    mainPageProvider.is_open_drawer=!mainPageProvider.is_open_drawer;
                  },
                  child: RotationTransition(
                    turns: Tween(begin: 0.5, end: 1.0).animate(mainPageProvider.animationController),
                    child: !mainPageProvider.is_open_drawer ?  Image.asset( 'assets/images/menu.png' ,height: 40,width: 40,color: Themes.Icon_Color,) : Icon(Icons.arrow_back_ios,color: Themes.Icon_Color,),
                  ),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: Dimension.Padding),
                    child: DefaultCartIcon(
                      onTap: ()=>mainPageProvider.changeTab(2),
                      quentity: mainPageProvider.cartProvider.addToCart.length.toString()
                    ),
                  ),
                ],
              ),
              body: OfflineStatus(
                child: TabBarView(
                  //physics: NeverScrollableScrollPhysics(),
                  controller: mainPageProvider.tabController,
                  children: <Widget>[
                    Home(),
                    AllCategories(),
                    Cart(),
                    auth!=null ? Account() : mainPageProvider.isLogin ? Authentication() : Registration(),
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                  height: navBarHeight,
                  width: mainWidth,
                  color: Themes.White,
                  /*child: RollingNavBar.iconData(
                    activeIconColors: [
                      Themes.White,
                    ],
                    activeBadgeColors: <Color>[
                      Themes.White,
                    ],
                    activeIndex: mainPageProvider.currentIndex,
                    animationCurve: Curves.linear,
                    animationType: AnimationType.roll,
                    baseAnimationSpeed: 200,
                    badges: badgeWidgets,
                    iconData: iconData,
                    iconColors: <Color>[Themes.Primary],
                    iconText: iconText,
                    indicatorColors: indicatorColors,
                    iconSize: 24,
                    indicatorRadius: scaledHeight(context, 30),
                    onAnimate: _onAnimate,
                    onTap: _onTap,
                  )*/
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: iconText.asMap().map((index,e) => MapEntry(
                      index,
                      bottomMenu(e,index)
                  )).values.toList(),
                ),
              ));
        },

      ),
      leftChild: Material(
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              color: Themes.Drawe_Color,
              /*decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    ColorTween(
                      begin: Themes.Primary,
                      end: Themes.Primary.withAlpha(50),
                    ).lerp(mainPageProvider.dragUpdate),
                    ColorTween(
                      end: Themes.Primary.withAlpha(50),
                      begin: Themes.Primary,
                    ).lerp(mainPageProvider.dragUpdate),
                  ],
                ),
              ),*/
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(0),
                children: [
                  Visibility(
                    visible: auth!=null,
                    child: DividerList(
                      child: ListTile(
                        onTap:()=>NavigatPage(WISHLIST),
                        //leading: Image.asset('assets/images/wishlist.png',height: 30,),
                        trailing: Icon(Icons.arrow_forward_ios_rounded,color: Themes.White,),
                        title: Text(language.WishList,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.White),),
                      ),
                    ),
                  ),
                  DividerList(
                    child: ListTile(
                      onTap:()=>NavigatPage(ORDER_TRACKING),
                      //leading: Image.asset('assets/images/blog.png',height: 30,),
                      trailing: Icon(Icons.arrow_forward_ios_rounded,color: Themes.White,),
                      title: Text(language.Order_Tracking,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.White),),
                    ),
                  ),
                  DividerList(
                    child: ListTile(
                      onTap:()=>NavigatPage(BLOG),
                      //leading: Image.asset('assets/images/blog.png',height: 30,),
                      trailing: Icon(Icons.arrow_forward_ios_rounded,color: Themes.White,),
                      title: Text(language.Blog,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.White),),
                    ),
                  ),
                  DividerList(
                    child: ListTile(
                      onTap:()=>NavigatPage(FAQS),
                      //leading: Image.asset('assets/images/faq.png',height: 30,),
                      trailing: Icon(Icons.arrow_forward_ios_rounded,color: Themes.White,),
                      title: Text(language.Faq,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.White),),
                    ),
                  ),
                  DividerList(
                    child: ListTile(
                      onTap:()=>NavigatPage(ABOUTUS,arguments: 0),
                      //leading: Image.asset('assets/images/about-us.png',height: 30,),
                      trailing: Icon(Icons.arrow_forward_ios_rounded,color: Themes.White,),
                      title: Text(language.About_us,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.White),),
                    ),
                  ),
                  DividerList(
                    child: ListTile(
                      onTap:()=>NavigatPage(ABOUTUS,arguments: 1),
                      //leading: Image.asset('assets/images/policy.png',height: 30,),
                      trailing: Icon(Icons.arrow_forward_ios_rounded,color: Themes.White,),
                      title: Text(language.Privacy_Policy,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.White),),
                    ),
                  ),
                  DividerList(
                    child: ListTile(
                      onTap:()=>NavigatPage(ABOUTUS,arguments: 2),
                      //leading: Image.asset('assets/images/terms.png',height: 30,),
                      trailing: Icon(Icons.arrow_forward_ios_rounded,color: Themes.White,),
                      title: Text(language.Terms_Condition,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.White),),
                    ),
                  ),
                  DividerList(
                    child: ListTile(
                      onTap:()=>NavigatPage(CONTACT_US),
                      //leading: Image.asset('assets/images/contact-us.png',height: 30,),
                      trailing: Icon(Icons.arrow_forward_ios_rounded,color: Themes.White,),
                      title: Text(language.Contact_us,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.White),),
                    ),
                  ),
                ],
              ),
            ),
            mainPageProvider.dragUpdate < 1
                ? BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: (10 - mainPageProvider.dragUpdate * 10),
                  sigmaY: (10 - mainPageProvider.dragUpdate * 10)),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0),
                ),
              ),
            )
                : null,
          ].where((a) => a != null).toList(),
        ),
      ),
      onDragUpdate: (double val, InnerDrawerDirection direction) =>mainPageProvider.updateNavigationDrawer(val),
    );
  }
  double scaledHeight(BuildContext context, double baseSize) {
    return baseSize * (MediaQuery.of(context).size.height / 800);
  }

  void NavigatPage(String page,{var arguments}) {
    mainPageProvider.innerDrawerKey.currentState.toggle();
    if(mainPageProvider.is_open_drawer)
    {mainPageProvider.animationController.reverse();}
    else{
      mainPageProvider.animationController.forward();
    }
    mainPageProvider.is_open_drawer=!mainPageProvider.is_open_drawer;
    Navigator.of(context).pushNamed(page,arguments: arguments);
  }

  Widget bottomMenu(String e, int index) {
    return Expanded(
      child: InkWell(
        onTap: (){
          mainPageProvider.currentIndex = index;
          mainPageProvider.changeTab(index);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData[index],color:mainPageProvider.currentIndex==index ? Themes.Primary : Themes.Grey),
            SizedBox(height: Dimension.Size_2,),
            Text(e,style: TextStyle(color:mainPageProvider.currentIndex==index ? Themes.Primary : Themes.Grey,fontSize: Dimension.Text_Size),),
            Container(
              margin: EdgeInsets.only(top: Dimension.Size_4),
              height: Dimension.Size_3,
              width: Dimension.Size_30,
              decoration: BoxDecoration(
                color:mainPageProvider.currentIndex==index ? Themes.Primary : Colors.transparent,
                borderRadius: BorderRadius.circular(Dimension.Size_2)
              ),
            )
          ],
        )
      ),
    );
  }

}
