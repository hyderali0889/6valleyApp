import 'package:flutter/material.dart';
import 'package:geniouscart/Class/Product.dart';
import 'package:geniouscart/Class/VendorProductModel.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Providers/Vendor/VendorProductsProvider.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/DefaultDialog.dart';
import 'package:geniouscart/Widgets/DialogButton.dart';
import 'package:geniouscart/Widgets/EmptyView.dart';
import 'package:geniouscart/Widgets/HomePopularProductSkeleton.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/RatingVIew.dart';
import 'package:geniouscart/Widgets/SwipeRefresh.dart';
import 'package:geniouscart/Widgets/VendorProductSkeleton.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';

class VendorProducts extends StatefulWidget {
  @override
  _VendorProductsState createState() => _VendorProductsState();
}

class _VendorProductsState extends State<VendorProducts> {

  VendorProductsProvider provider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VendorProductsProvider>(
      create: (_)=>VendorProductsProvider()..setView(context),
      child: Consumer<VendorProductsProvider>(
        builder: (context,model,child){
          provider=model;
          return Scaffold(
            appBar: DefaultAppbar(context: context,title: ModalRoute.of(context).settings.arguments.toString()),
            body: SwipeRefresh(
                controller: provider.controller,
                onRefresh: provider.refreshData,
                children: [
                  provider.Loading ? VendorProductSkeleton(context: context,count: 10) :
                  provider.product!=null ? provider.product.data.isNotEmpty ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: provider.product.data.length,
                    padding: EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      return ListAnimation(
                          index: index,
                          child: popularProductList(provider.product.data[index],index)
                      );
                    } ,
                  ) : EmptyView():EmptyView(),
                  Padding(
                      padding: EdgeInsets.only(bottom:Dimension.Padding)
                  )
                ]
            ),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: ()=>Navigator.of(context).pushNamed(PRODUCT_TYPE),
                icon: Icon(Icons.add_circle_outline),
                backgroundColor: Themes.Primary,
                label: Text(language.Add_product)
            ),
          );
        },
      ),
    );
  }

  Widget popularProductList(VendorProductData date,int index,{bool isDialog=false}){
    return GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed(PRODUCT_DETAILS,arguments: ProductData.fromJson(date.toJson()));
        },
        child: Stack(
          children: [
            Container(
                child: Card(
                  elevation: Dimension.card_elevation,
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.only(left: 10,right: 10,top: 10),
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
                                    Text('${AppConstant.currencySymbol} ${date.currentPrice}',style: TextStyle(fontSize: Dimension.Text_Size_Big,color: Themes.Text_Color,fontWeight: FontWeight.bold),),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text('${AppConstant.currencySymbol} ${date.previousPrice}',style: TextStyle(fontSize: Dimension.Text_Size,color: Themes.Grey,fontWeight: FontWeight.normal,decoration: TextDecoration.lineThrough),),
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
            ),
            Visibility(
              visible: !isDialog,
              child: Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    onPressed: (){
                      deleteTicketDialog(popularProductList(date, index,isDialog: true),index);
                    },
                    icon: Icon(Icons.delete_outline,color: Themes.Red,),
                  )
              ),
            )
          ],
        )
    );
  }

  void deleteTicketDialog(Widget child,int index)async{
    var data= await showDialog(
        context: context,
        builder: (BuildContext context) {
          return DefaultDialog(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: EdgeInsets.all(Dimension.Padding).copyWith(top: 0),
                  child: Column(
                    children: [
                      Text(language.Remove_Alert, style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1,),
                      Padding(
                        padding: EdgeInsets.only(top: Dimension.Padding),
                        child: child,
                      )
                    ],
                  ),
                ),
                DialogButton(
                    negativeButton: language.No,
                    positiveButton: language.Yes,
                    onTap: (state) {
                      Navigator.of(context).pop(state);
                    }
                )
              ],
            ),
            title: language.Delete_Product,
            isError: true,
          );
        }
    );
    if(data!=null)if(data==true){
      provider.deleteProduct(index);
    }
  }
}
