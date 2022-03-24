import 'package:flutter/material.dart';
import 'package:geniouscart/Class/Product.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Providers/PlaceOrderProvider.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/RatingVIew.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {

  PlaceOrderProvider provider;

  @override
  Widget build(BuildContext context) {
    if(provider==null)
      provider=Provider.of<PlaceOrderProvider>(context);
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          //physics: NeverScrollableScrollPhysics(),
          itemCount: provider.cartProvider.addToCart.length,
          padding: EdgeInsets.all(0),
          itemBuilder: (context,index){
            return ListAnimation(
                child: cartList(provider.cartProvider.addToCart[index], index),
                index: index
            );
          }
      ),
    );
  }

  Widget cartList(ProductData date,int index){
    return Container(
        child: Stack(
          children: [
            Card(
              elevation: Dimension.card_elevation,
              clipBehavior: Clip.antiAlias,
              color: Themes.White,
              margin: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding,top: Dimension.Padding),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(actualPrice(provider.cartProvider.getProductCalculatedPrice(index)),style: TextStyle(fontSize: Dimension.Text_Size_Big,color: Themes.Text_Color,fontWeight: FontWeight.bold),),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(right: Dimension.Size_5,left: Dimension.Size_5),
                                          margin: EdgeInsets.only(top: Dimension.Size_5),
                                          decoration: BoxDecoration(
                                              color: Themes.White,
                                              border: Border.all(color: Themes.Primary,width: 1)
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('${actualPrice(provider.cartProvider.getSutotalPrice(index)[AppConstant.total])}',style: TextStyle(fontSize: Dimension.Text_Size,color: Themes.Text_Color),),
                                              Visibility(
                                                  visible: provider.cartProvider.getSutotalPrice(index)[AppConstant.item_discount]!="0.0",
                                                  child: Text(' - ${double.parse(provider.cartProvider.getSutotalPrice(index)[AppConstant.item_discount]).toStringAsFixed(0)}%',style: TextStyle(fontSize: Dimension.Text_Size,color: Themes.Text_Color),)
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: Dimension.Size_5,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 3),
                                        child: RatingView(rating: date.rating.toDouble(),itemSize: Dimension.Size_12),
                                      ),
                                    ),
                                    Visibility(
                                      visible: date.selectedSize!='',
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        margin: EdgeInsets.only(left: 5,right: 5),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Themes.White,
                                            border: Border.all(color: Themes.Primary ,width: 1)
                                        ),
                                        child: Text(date.selectedSize,style: TextStyle(color: Themes.Primary,fontSize: Dimension.Text_Size_Small,fontWeight: Dimension.textMedium),),
                                      ),
                                    ),
                                    date.selectedColor!='' ? Container(
                                      height: 20,
                                      width: 20,
                                      margin: EdgeInsets.only(left: 5,right: 5),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Themes.getColorFromColorCode(date.selectedColor),
                                          shape: BoxShape.circle
                                      ),
                                    ) : Container()

                                  ],
                                ),
                                Text(date.title,style: TextStyle(fontSize: Dimension.Text_Size_Small,color: Themes.Text_Color),maxLines: 1,overflow: TextOverflow.ellipsis,),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    date.attributes!=null ? Container(
                      padding: EdgeInsets.all(Dimension.Size_5),
                      child: Wrap(
                        children: date.attributes.attribute.asMap().map((index,e) => MapEntry(
                            index,
                            RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.bodyText1,
                                text: '${date.attributes.name[index].replaceAll('_', ' ').toUpperCase()} : ',
                                children: [
                                  TextSpan(
                                    style: Theme.of(context).textTheme.bodyText1.copyWith(color: Themes.Primary,fontWeight: Dimension.textBold),
                                    text: '${actualPrice('${date.attributes.attribute[index].prices[date.attributes.attribute[index].selected.indexOf(true)]}')}',
                                  ),
                                  TextSpan(
                                    text: '${index!=(date.attributes.attribute.length-1) ? ' ,': ''}'
                                  )
                                ]
                              ),
                            )
                        )).values.toList(),
                      ),
                    ) : Container()
                  ],
                ),
              ),
            ),
            Positioned(
              right: Dimension.Size_26,
              top: Dimension.Size_20,
              child: Container(
                padding: EdgeInsets.all(Dimension.Size_10),
                decoration: BoxDecoration(
                  color: Themes.White,
                  shape: BoxShape.circle,
                  border: Border.all(color: Themes.Green,width: 1)
                ),
                child: Text('${date.quantity}',style: Theme.of(context).textTheme.bodyText1.copyWith(color: Themes.Green),),
              )
            )
          ],
        )
    );
  }
}
