import 'package:flutter/material.dart';
import 'package:geniouscart/Class/FaqModel.dart';
import 'package:geniouscart/Class/Product.dart';
import 'package:geniouscart/Class/WishProduct.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Providers/WishListProvider.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/Widgets/CircularProgress.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/EmptyView.dart';
import 'package:geniouscart/Widgets/FaqSkeleton.dart';
import 'package:geniouscart/Widgets/HomePopularProductSkeleton.dart';
import 'package:geniouscart/Widgets/HorizontalProductSkeleton.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/RatingVIew.dart';
import 'package:geniouscart/Widgets/SwipeRefresh.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';

class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {

  WishListProvider provider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WishListProvider>(
      create: (_)=>WishListProvider()..setView(context),
      child: Consumer<WishListProvider>(builder: (context,model,child){
        provider=model;
        return Scaffold(
          appBar: DefaultAppbar(context: context,title: language.WishList),
          body: Container(
            child: SwipeRefresh(
                controller: provider.refreshController,
                onRefresh: provider.refreshPage,
                children: [
                  provider.Loading ? HorizontalProductSkeleton(context: context,count: 10) :
                  provider.product!=null ? provider.product.data.length>0 ? ListView.builder(
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: provider.product.data.length,
                      itemBuilder: (context,index){
                        return ListAnimation(
                            child: productList(provider.product.data[index],index),
                            index: index
                        );
                      }
                  ) : EmptyView(isSVG: true,image: 'assets/images/wishlist.svg',message: Text(language.You_have_no_favorite_product,style: Theme.of(context).textTheme.headline1,)) :
                  EmptyView(isSVG: true,image: 'assets/images/wishlist.svg',message: Text(language.You_have_no_favorite_product,style: Theme.of(context).textTheme.headline1,)),
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

  Widget productList(WishProductItem date,int index){
    return GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed(PRODUCT_DETAILS,arguments: ProductData.fromJson(date.toJson()));
        },
        child: Container(
            child: Stack(
              children: [
                Card(
                  elevation: Dimension.card_elevation,
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.all(Dimension.Size_10).copyWith(bottom: 0),
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
                                    Text(actualPrice(date.currentPrice.toString()),style: TextStyle(fontSize: Dimension.Text_Size_Big,color: Themes.Text_Color,fontWeight: FontWeight.bold),),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(actualPrice(date.previousPrice.toString()),style: TextStyle(fontSize: Dimension.Text_Size,color: Themes.Grey,fontWeight: FontWeight.normal,decoration: TextDecoration.lineThrough),),
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
                ),
                Positioned(
                  right: Dimension.Size_10,
                  top: Dimension.Size_10,
                  child: date.Loading ? Padding(
                    padding: EdgeInsets.all(Dimension.Size_10),
                    child: CircularProgress(),
                  ) :IconButton(
                    onPressed: ()=>provider.deleteProduct(index),
                    icon: Icon(Icons.cancel,color: Themes.Red,),
                  )
                )
              ],
            )
        )
    );
  }
}
