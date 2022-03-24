import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:geniouscart/Class/Sellers.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Providers/FavoriteSellerProvider.dart';
import 'package:geniouscart/Screen/FavoriteSeller/DeleteFavoriteSeller.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/Widgets/CircularProgress.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/DefaultDialog.dart';
import 'package:geniouscart/Widgets/EmptyView.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/SellerSkeleton.dart';
import 'package:geniouscart/Widgets/SwipeRefresh.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';
import 'package:geniouscart/Route/Route.dart';

class FavoriteSeller extends StatefulWidget {
  @override
  _FavoriteSellerState createState() => _FavoriteSellerState();
}

class _FavoriteSellerState extends State<FavoriteSeller> {

  FavoriteSellerProvider provider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>FavoriteSellerProvider()..setView(context),
      child: Consumer<FavoriteSellerProvider>(
        builder: (context,model,child){
          provider=model;
          return Scaffold(
            appBar: DefaultAppbar(context: context,title: ModalRoute.of(context).settings.arguments),
            body: Container(
              child: SwipeRefresh(
                  controller: provider.refreshController,
                  onRefresh: provider.refreshPage,
                  children: [
                    provider.Loading ? SellerSkeleton(context : context) :
                    provider.sellers!=null ? provider.sellers.data.isNotEmpty ? ListView.builder(
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: provider.sellers.data.length,
                        itemBuilder: (context,index){
                          return ListAnimation(
                              child: sellerList(provider.sellers.data[index],index),
                              index: index
                          );
                        }
                    ) : emptyView():emptyView(),
                    Padding(
                        padding: EdgeInsets.only(bottom:Dimension.Padding)
                    )
                  ]
              ),
            ),
          );
        },
      ),
    );
  }

  Widget emptyView(){
    return Container(
      width: mainWidth,
      height: mainHeight*0.8,
      padding: EdgeInsets.all(Dimension.Padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          WebsafeSvg.asset('assets/images/favorite-shop.svg',height: 200,),
          Padding(
            padding: EdgeInsets.only(top: Dimension.Padding),
            child: Text(language.You_dont_have_any_favorite_shop,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.Grey),),
          )
        ],
      ),
    );
  }

  Widget sellerList(SellerData data, int index,{bool isDialog=false}) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(SELLER_PRODUCT,arguments: data.shopId);
      },
      child: Card(
        margin: EdgeInsets.all(Dimension.Padding).copyWith(bottom: 0),
        clipBehavior: Clip.antiAlias,
        elevation: Dimension.card_elevation,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        WebsafeSvg.asset('assets/images/shop.svg',height: 24,width: 24,),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(data.shopName,style: Theme.of(context).textTheme.headline1,),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          WebsafeSvg.asset('assets/images/owner.svg',height: 24,width: 24,),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(data.ownerName,style: Theme.of(context).textTheme.bodyText1,),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          WebsafeSvg.asset('assets/images/shop-address.svg',height: 24,width: 24,),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(data.shopAddress,style: Theme.of(context).textTheme.bodyText2,),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: !isDialog,
                child: provider.sellers.data[index].loading ? CircularProgress() : IconButton(
                  onPressed: ()=>showDeleteSeller(index),
                  icon: Icon(Icons.delete_outline,color: Themes.Red,),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showDeleteSeller(int index)async{
    var data = await showDialog(
        context: context,
        builder: (BuildContext context){
          return DefaultDialog(
          title: language.Remove_Seller,
          child: DeleteFavoriteSeller(
            child: sellerList(provider.sellers.data[index], index,isDialog: true),
            id : provider.sellers.data[index].id
          ),
        );
        }
    );
    if(data!=null)if(data==true){
      provider.deleteSeller(index);
    }
  }
}
