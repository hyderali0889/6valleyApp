import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:geniouscart/AppHelper/Helper.dart';
import 'package:geniouscart/Class/Banners.dart';
import 'package:geniouscart/Class/FeaturedBanners.dart';
import 'package:geniouscart/Class/Product.dart';
import 'package:geniouscart/Class/Services.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Widgets/HeroAnimation.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:geniouscart/Packege/TabView/src/navigation_bar.dart';
import 'package:geniouscart/Packege/flutter_html/flutter_html.dart';
import 'package:geniouscart/Packege/flutter_html/style.dart';
import 'package:geniouscart/Providers/HomeProvider.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/Widgets/CircularProgress.dart';
import 'package:geniouscart/Widgets/DynamicSIzeWidget.dart';
import 'package:geniouscart/Widgets/GridAnimation.dart';
import 'package:geniouscart/Widgets/Headding.dart';
import 'package:geniouscart/Widgets/HomeFeaturedBannersSkeleton.dart';
import 'package:geniouscart/Widgets/HomeFeaturedProductSkeleton.dart';
import 'package:geniouscart/Widgets/HomePageSlider.dart';
import 'package:geniouscart/Widgets/HomePopularProductSkeleton.dart';
import 'package:geniouscart/Widgets/HomeServiceSkeleton.dart';
import 'package:geniouscart/Widgets/HomeTopBannerSkeleton.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/RatingVIew.dart';
import 'package:geniouscart/Widgets/SwipeRefresh.dart';
import 'package:provider/provider.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';

import '../main.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin{
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  HomeProvider homeProvider;
  double height=250;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(homeProvider==null) {
      Api_Client.config(context);
      homeProvider = Provider.of<HomeProvider>(context);
    }
    return Scaffold(
      body: Container(
        child: SwipeRefresh(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed(SEARCH);
              },
              child: Container(
                margin: EdgeInsets.only(top: Dimension.Size_10,left: Dimension.Padding,right: Dimension.Padding),
                padding: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding),
                decoration: BoxDecoration(
                  color: Color(0xFFCAD3DB),
                  borderRadius: BorderRadius.circular(Dimension.Size_5)
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Text(language.Search_Product,style: Theme.of(context).textTheme.bodyText1,)),
                    HeroAnimation(
                        tag: AppConstant.HeroTagSearch,
                        child: IconButton(
                          onPressed: null,
                          icon: Icon (Icons.search,color: Themes.Text_Color,),
                        )
                    )
                  ],
                ),
              ),
            ),
            Visibility(
              visible: customization.data.slider=="1",
              child: HomePageSlider(homeProvider.homeSlider)
            ),
            Visibility(
              visible: customization.data.service=="1",
              child:  homeProvider.services != null ? StaggeredGridView.countBuilder(
                primary: false,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: homeProvider.services.data.length,
                padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                crossAxisCount: 4,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                itemBuilder: (context, index) {
                  return ListAnimation(
                      index: index,
                      child: servicesList(homeProvider.services.data[index])
                  );
                } ,
                staggeredTileBuilder: (index) =>  StaggeredTile.fit(2),
              ):HomeServiceSkeleton(context: context,count: 4),
            ),
            Divider(thickness: 1,height: 1,),
            Visibility(
              visible: customization.data.featured=="1",
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Headding(title: language.Featured,width: 70),
                  homeProvider.products != null ? Container(
                    height: 230,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: homeProvider.products.data.data.length,
                      padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                      itemBuilder: (context, index) {
                        return ListAnimation(
                            index: index,
                            child: productList(homeProvider.products.data.data[index],index)
                        );
                      } ,
                    ),
                  ):HomeFeaturedProductSkeleton(context: context,count: 10),
                ],
              ),
            ),
            Visibility(
              visible: customization.data.smallBanner=="1",
              child:  homeProvider.topBanners != null ? Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: homeProvider.topBanners.data.length,
                  padding: EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    return ListAnimation(
                        index: index,
                        child: bannerList(homeProvider.topBanners.data[index],index)
                    );
                  } ,
                ),
              ):HomeTopBannerSkeleton(context: context,height: 180),
            ),
            Visibility(
              visible: customization.data.hotSale=="1",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding,top: 10,bottom: 10),
                    child: Text(language.Popular_Product,style: TextStyle(fontSize: 24,fontWeight: Dimension.textMedium,color: Themes.Text_Color),),
                  ),
                  Container(
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Positioned(
                            bottom:2.5,
                            child: Container(height: 2,width: mainWidth,color: Themes.Grey.withAlpha(Dimension.Alpha),)
                        ),
                        Container(
                          height: 40,
                          margin: EdgeInsets.only(top: Dimension.Padding),
                          child: CustomTabView(
                            onTap: (index)=>homeProvider.changePopularTab(index),
                            reverse: true,
                            curve: Curves.easeInBack,
                            items: homeProvider.items,
                            activeColor: Themes.Primary,
                            enableShadow: false,
                            inactiveColor: Themes.Text_Color,
                            indicatorColor: Themes.Primary,
                            inactiveStripColor: Themes.Background,
                            currentIndex: homeProvider.popularTab(),
                            fontSize: Dimension.Text_Size_Small,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopularSection(),
                ],
              ),
            ),
            Visibility(
              visible: customization.data.best=="1",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Headding(title: language.Best_Seller,width: 80),
                  homeProvider.bestSeller != null ? StaggeredGridView.countBuilder(
                    primary: false,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: homeProvider.bestSeller.data.data.length,
                    padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                    crossAxisCount: 4,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    itemBuilder: (context, index) {
                      return GridAnimation(
                          index: index,
                          child: bestSellerList(homeProvider.bestSeller.data.data[index],index)
                      );
                    } ,
                    staggeredTileBuilder: (index) =>  StaggeredTile.fit(2),
                  ):HomeFeaturedBannersSkeleton(context: context,count: 4),
                ],
              ),
            ),
            Visibility(
              visible: customization.data.flashDeal=="1",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Headding(title: language.Flash_Deal,width: 80),
                  homeProvider.freshDeal != null ? Container(
                    height: 400,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: homeProvider.freshDeal.data.data.length,
                      padding: EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                        return ListAnimation(
                            index: index,
                            child: FreshDeal(homeProvider.freshDeal.data.data[index])
                        );
                      } ,
                    ),
                  ):HomeTopBannerSkeleton(context: context,height: 180),
                ],
              ),
            ),
            Visibility(
              visible: customization.data.smallBanner=="1",
              child: homeProvider.middleBanner != null ? Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: homeProvider.middleBanner.data.length,
                  padding: EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    return ListAnimation(
                        index: index,
                        child: bannerList(homeProvider.middleBanner.data[index],index)
                    );
                  } ,
                ),
              ):HomeTopBannerSkeleton(context: context,height: 180),
            ),
            Visibility(
              visible: customization.data.topRated=="1",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Headding(title: language.Top_Rated,width: 70),
                  homeProvider.topRated != null ? StaggeredGridView.countBuilder(
                    primary: false,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: homeProvider.topRated.data.data.length,
                    padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                    crossAxisCount: 4,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    itemBuilder: (context, index) {
                      return GridAnimation(
                          index: index,
                          child: bestSellerList(homeProvider.topRated.data.data[index],index)
                      );
                    } ,
                    staggeredTileBuilder: (index) =>  StaggeredTile.fit(2),
                  ):HomeFeaturedBannersSkeleton(context: context,count: 4),
                ],
              ),
            ),
            Visibility(
              visible: customization.data.largeBanner=="1",
              child: homeProvider.bottomBanner != null ? Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: homeProvider.bottomBanner.data.length,
                  padding: EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    return ListAnimation(
                        index: index,
                        child: bannerList(homeProvider.bottomBanner.data[index],index)
                    );
                  } ,
                ),
              ):HomeTopBannerSkeleton(context: context,height: 180),
            ),
            Visibility(
              visible: customization.data.big=="1",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Headding(title: language.Big_Save,width: 70),
                  homeProvider.bigSave != null ? StaggeredGridView.countBuilder(
                    primary: false,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: homeProvider.bigSave.data.data.length,
                    padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                    crossAxisCount: 4,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    itemBuilder: (context, index) {
                      return GridAnimation(
                          index: index,
                          child: bestSellerList(homeProvider.bigSave.data.data[index],index)
                      );
                    } ,
                    staggeredTileBuilder: (index) =>  StaggeredTile.fit(2),
                  ):HomeFeaturedBannersSkeleton(context: context,count: 4),
                ],
              ),
            ),
            Visibility(
              visible: customization.data.partners=="1",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Headding(title: language.Brands,width: 70),
                  homeProvider.partners != null ? Container(
                    height: 100,
                    child: ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: homeProvider.partners.data.length,
                      padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                      itemBuilder: (context, index) {
                        return ListAnimation(
                            index: index,
                            child: GestureDetector(
                              onTap: (){
                                Helper.goBrowser(homeProvider.partners.data[index].link);
                              },
                              child: Container(
                                  margin: EdgeInsets.only(left: Dimension.Padding),
                                  child: Image.network(homeProvider.partners.data[index].image)
                              ),
                            )
                        );
                      } ,
                    ),
                  ):Container(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: Dimension.Padding),
            ),
            /*Container(
              padding: EdgeInsets.all(Dimension.Padding),
              alignment: Alignment.center,
              color: Themes.getColorFromColorCode(appSetting.data.copyrightColor),
              child: Html(
                  data: appSetting.data.copyright,
                  style: {
                    "html": Style(
                        backgroundColor: Colors.black12,
                        color: Themes.White,
                        fontSize: FontSize(Dimension.Text_Size),
                        textAlign: TextAlign.center
                    )
                  },
                  onLinkTap: (url) {
                    print("Opening $url...");
                  }
              ),
            )*/
          ],
          onRefresh: homeProvider.refresh,
          controller: homeProvider.refreshController,
        ),
      ),
    );
  }
  Widget featuredList(FeaturedBannersData date){
    return GestureDetector(
      onTap: (){
        Helper.goBrowser(date.link);
      },
      child: Image.network(date.photo)
    );
  }
  Widget productList(ProductData date,int index){
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed(PRODUCT_DETAILS,arguments: date);
      },
      child: Container(
        width: 135,
          child: Card(
            elevation: Dimension.card_elevation,
            clipBehavior: Clip.antiAlias,
            color: Themes.White,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(date.thumbnail),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(date.title,style: TextStyle(fontSize: Dimension.Text_Size_Small,color: Themes.Text_Color,fontWeight: Dimension.textMedium),maxLines: 2,overflow: TextOverflow.ellipsis,),
                        Row(
                          children: [
                            Text(actualPrice(date.currentPrice),style: TextStyle(fontSize: Dimension.Text_Size_Small,color: Themes.Text_Color,fontWeight: FontWeight.bold),),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(actualPrice(date.previousPrice),style: TextStyle(fontSize: Dimension.Text_Size_Small,color: Themes.Grey,fontWeight: FontWeight.normal,decoration: TextDecoration.lineThrough),),
                            ),
                          ],
                        ),
                        RatingView(rating: date.rating.toDouble())
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
      )
    );
  }
  Widget bestSellerList(ProductData date,int index){
    return GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed(PRODUCT_DETAILS,arguments: date);
        },
        child: Card(
          elevation: Dimension.card_elevation,
          clipBehavior: Clip.antiAlias,
          color: Themes.White,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: mainWidth*0.4,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(date.thumbnail),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(date.title,style: TextStyle(fontSize: Dimension.Text_Size_Small,color: Themes.Text_Color,fontWeight: Dimension.textMedium),maxLines: 2,overflow: TextOverflow.ellipsis,),
                      Row(
                        children: [
                          Text(actualPrice(date.currentPrice),style: TextStyle(fontSize: Dimension.Text_Size,color: Themes.Text_Color,fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(actualPrice(date.previousPrice),style: TextStyle(fontSize: Dimension.Text_Size_Small,color: Themes.Grey,fontWeight: FontWeight.normal,decoration: TextDecoration.lineThrough),),
                          ),
                        ],
                      ),
                      RatingView(rating: date.rating.toDouble())
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
  Widget popularProductList(ProductData date,int index){
    return GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed(PRODUCT_DETAILS,arguments: date);
        },
        child: Container(
            child: Card(
              elevation: Dimension.card_elevation,
              clipBehavior: Clip.antiAlias,
              color: Themes.White,
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(date.thumbnail,height: 120,),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(actualPrice(date.currentPrice),style: TextStyle(fontSize: Dimension.Text_Size_Big,color: Themes.Text_Color,fontWeight: FontWeight.bold),),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(actualPrice(date.previousPrice),style: TextStyle(fontSize: Dimension.Text_Size,color: Themes.Grey,fontWeight: FontWeight.normal,decoration: TextDecoration.lineThrough),),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 3),
                              child: RatingView(rating: date.rating.toDouble()),
                            ),
                            Text(date.title,style: TextStyle(fontSize: Dimension.Text_Size,color: Themes.Text_Color,fontWeight: Dimension.textMedium),maxLines: 2,overflow: TextOverflow.ellipsis,),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
        )
    );
  }
  Widget servicesList(ServicesData date){
    return ListTile(
      leading: Image.network(date.photo,height: 30,width: 30,),
      title: Text(date.title,style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size,fontWeight: Dimension.textMedium),),
      subtitle: Text(date.details,style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size_Small_Extra,fontWeight: FontWeight.normal)),
    );
  }
  Widget bannerList(BannerData date,int index){
    return GestureDetector(
        onTap: (){
          Helper.goBrowser(date.link);
        },
        child: Container(
          margin: EdgeInsets.only(top: Dimension.Padding),
            child: Image.network(date.image)
        )
    );
  }


  Widget PopularSection() {
    Product products;
    if(homeProvider.popularTabIndex==0)
      products=homeProvider.hotProduct;
    else if(homeProvider.popularTabIndex==1)
      products=homeProvider.newProduct;
    else if(homeProvider.popularTabIndex==2)
      products=homeProvider.trendingProduct;
    else
      products=homeProvider.saleProduct;

    return products != null ? Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: products.data.data.length,
        padding: EdgeInsets.only(left: 10,right: 10,top: 10),
        itemBuilder: (context, index) {
          return ListAnimation(
              index: index,
              child: popularProductList(products.data.data[index],index)
          );
        } ,
      ),
    ):HomePopularProductSkeleton(context: context,count: 10);
  }


}

class FreshDeal extends StatefulWidget {

  ProductData data;
  FreshDeal(this.data);

  @override
  _FreshDealState createState() => _FreshDealState(data);
}

class _FreshDealState extends State<FreshDeal> with AutomaticKeepAliveClientMixin{
  ProductData data;


  _FreshDealState(this.data);

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  int differenceSeconds=32058490;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try{
      final endDate = DateTime(int.parse(data.saleEndDate.split('/')[2]), int.parse(data.saleEndDate.split('/')[1]), int.parse(data.saleEndDate.split('/')[0]));
      final now = DateTime.now();
      differenceSeconds = endDate.difference(now).inSeconds;
      print('Seconds = $differenceSeconds');
    }catch(e){}
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed(PRODUCT_DETAILS,arguments: data);
        },
        child: Container(
          margin: EdgeInsets.only(top: 5),
          width: 220,
            child: Card(
              elevation: Dimension.card_elevation,
              clipBehavior: Clip.antiAlias,
              color: Themes.White,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 220,
                      width: 220,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(data.thumbnail),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                    //Image.network(data.thumbnail,height: 120,fit: BoxFit.cover,),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RatingView(rating: data.rating.toDouble()),
                          Row(
                            children: [
                              Text(actualPrice(data.currentPrice),style: TextStyle(fontSize: Dimension.Text_Size,color: Themes.Text_Color,fontWeight: FontWeight.bold),),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(actualPrice(data.previousPrice),style: TextStyle(fontSize: Dimension.Text_Size_Small,color: Themes.Grey,fontWeight: FontWeight.normal,decoration: TextDecoration.lineThrough),),
                              ),
                            ],
                          ),
                          Text(data.title,style: TextStyle(fontSize: Dimension.Text_Size_Small,color: Themes.Text_Color,fontWeight: Dimension.textMedium),maxLines: 2,overflow: TextOverflow.ellipsis,),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 70,
                            width: mainWidth*0.55,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Themes.White,
                              border: Border.all(color: Themes.Text_Color.withAlpha(Dimension.Alpha),width: 1),
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SlideCountdownClock(
                                  duration: Duration(seconds: differenceSeconds),
                                  slideDirection: SlideDirection.Up,
                                  separator: " : ",
                                  textStyle: TextStyle(
                                    fontSize: Dimension.Text_Size_Big,
                                    fontWeight: Dimension.textBold,
                                    color: Themes.Primary
                                  ),
                                  shouldShowDays: true,
                                  onDone: () {
                                    //_scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Clock 1 finished')));
                                  },
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: Dimension.Padding,left: Dimension.Padding),
                                        child: Text(language.Fresh_Deal_Times[0],style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size_Small,fontWeight: Dimension.textMedium),),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: Dimension.Padding),
                                        child: Text(language.Fresh_Deal_Times[1],style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size_Small,fontWeight: Dimension.textMedium),),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: Dimension.Padding),
                                        child: Text(language.Fresh_Deal_Times[2],style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size_Small,fontWeight: Dimension.textMedium),),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: Dimension.Padding),
                                        child: Text(language.Fresh_Deal_Times[3],style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size_Small,fontWeight: Dimension.textMedium),),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
        )
    );
  }
}

