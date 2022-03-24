import 'package:flutter/material.dart';
import 'package:geniouscart/Class/CategoryModel.dart';
import 'package:geniouscart/Class/FaqModel.dart';
import 'package:geniouscart/Class/SellerProducts.dart';
import 'package:geniouscart/Class/Product.dart' as Product;
import 'package:geniouscart/Class/WishProduct.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Providers/FavoriteSellerProductProvider.dart';
import 'package:geniouscart/Providers/ShowProductProvider.dart';
import 'package:geniouscart/Providers/WishListProvider.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/Widgets/CircularProgress.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/DefaultDialog.dart';
import 'package:geniouscart/Widgets/DialogButton.dart';
import 'package:geniouscart/Widgets/EmptyView.dart';
import 'package:geniouscart/Widgets/FaqSkeleton.dart';
import 'package:geniouscart/Widgets/HomePopularProductSkeleton.dart';
import 'package:geniouscart/Widgets/HorizontalProductSkeleton.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/RatingVIew.dart';
import 'package:geniouscart/Widgets/SwipeRefresh.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';

class FavoriteSellerProduct extends StatefulWidget {
  @override
  _FavoriteSellerProductState createState() => _FavoriteSellerProductState();
}

class _FavoriteSellerProductState extends State<FavoriteSellerProduct> {

  FavoriteSellerProductProvider provider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavoriteSellerProductProvider>(
      create: (_)=>FavoriteSellerProductProvider()..setView(context),
      child: Consumer<FavoriteSellerProductProvider>(builder: (context,model,child){
        provider=model;
        return Scaffold(
          appBar: DefaultAppbar(context: context,title: language.Product),
          body: Container(
            child: provider.Loading ? HorizontalProductSkeleton(context: context,count: 10)
                : provider.products!=null  ? provider.products.data.length >0 ?
            ListView.builder(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount: provider.products.data.length,
                itemBuilder: (context,index){
                  return ListAnimation(
                      child: productList(provider.products.data[index],index),
                      index: index
                  );
                }
            ): EmptyView(image :'assets/images/empty-box.png',message: Text(language.Product_Not_Found,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.Grey),)):
            EmptyView(image :'assets/images/empty-box.png',message: Text(language.Product_Not_Found,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.Grey))),
          ),
        );
      },),
    );
  }

  Widget productList(ProductData date,int index){
    return GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed(PRODUCT_DETAILS,arguments: Product.ProductData.fromJson(date.toJson()));
        },
        child: Card(
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
        )
    );
  }


}
