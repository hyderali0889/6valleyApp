import 'package:flutter/material.dart';
import 'package:geniouscart/AppHelper/Helper.dart';
import 'package:geniouscart/Class/Product.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Packege/Loading_Button/Loading_Button.dart';
import 'package:geniouscart/Providers/CartProvider.dart';
import 'package:geniouscart/Providers/MainPageProvider.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/DefaultDialog.dart';
import 'package:geniouscart/Widgets/DialogButton.dart';
import 'package:geniouscart/Widgets/EmptyCart.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/RatingVIew.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';

import 'MainScreen.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> with AutomaticKeepAliveClientMixin{

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  CartProvider cartProvider;

  bool isHaveAppBar=false;

  @override
  Widget build(BuildContext context) {
    if(cartProvider==null) {
      cartProvider = Provider.of<CartProvider>(context);
      if (ModalRoute
          .of(context)
          .settings
          .arguments != null)
        isHaveAppBar = ModalRoute
            .of(context)
            .settings
            .arguments;
    }
    return Scaffold(
      appBar: isHaveAppBar ?  DefaultAppbar(context: context,title: language.Cart) : PreferredSize(
        preferredSize: Size(0,0),
        child: Container(),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                cartProvider.addToCart.isNotEmpty ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cartProvider.addToCart.length,
                  padding: EdgeInsets.all(0),
                  itemBuilder: (context,index){
                    return ListAnimation(
                        child: cartList(cartProvider.addToCart[index], index),
                        index: index
                    );
                  }
                ) : EmptyCart(),
                SizedBox(height: mainHeight*0.1,)
              ],
            ),
          ),
          Positioned(
            bottom: Dimension.Size_10,
            child: Visibility(
                visible: cartProvider.addToCart.isNotEmpty,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadingButton(
                      isLoading: false,
                      onPressed: (){
                          if(auth==null)
                            showLoginDialog();
                          else
                            goCheckout();
                      },
                      defaultStyle: true,
                      backgroundColor: Themes.Primary,
                      child: Container(
                        width: mainWidth*0.4,
                        alignment: Alignment.center,
                        child: Text(language.Checkout,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.White),),
                      ),
                    )
                  ],
                )
            ),
          )
        ],
      ),
    );
  }
  void goCheckout()async{
    var data= await Navigator.of(context).pushNamed(CHECKOUT);
    if(data!=null)if(data) {
      cartProvider.clearCart();
      try{mainPageProvider.changeTab(3);}
      catch(e){
        print(e);
      }
      Navigator.of(context).pushNamed(ORDERS);
    }
  }
  void showLoginDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context){
          return DefaultDialog(
          title: language.Login,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(0),
            children: [
              Padding(
                padding: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding),
                child: Text(language.You_have_to_login_first,style: Theme.of(context).textTheme.bodyText1,),
              ),
              DialogButton(
                  negativeButton: language.Close,
                  positiveButton: language.OK,
                  onTap: (status)async{
                    Navigator.of(context).pop();
                    if(status) {
                      var data= await Navigator.of(context).pushNamed(AUTHENTICATION,arguments: true);
                      if(data!=null)if(data){
                        goCheckout();
                      }
                    }
                  }
              )
            ],
          ),
        );
        }
    );
  }


  Widget cartList(ProductData date,int index){
    return GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed(PRODUCT_DETAILS,arguments: date);
        },
        child: Container(
            child: Card(
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
                                    Text(actualPrice(cartProvider.getProductCalculatedPrice(index)),style: TextStyle(fontSize: Dimension.Text_Size_Big,color: Themes.Text_Color,fontWeight: FontWeight.bold),),
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
                                              Text('${actualPrice(cartProvider.getSutotalPrice(index)[AppConstant.total])}',style: TextStyle(fontSize: Dimension.Text_Size,color: Themes.Text_Color),),
                                              Visibility(
                                                visible: cartProvider.getSutotalPrice(index)[AppConstant.item_discount]!="0.0",
                                                child: Text(' - ${double.parse(cartProvider.getSutotalPrice(index)[AppConstant.item_discount]).toStringAsFixed(0)}%',style: TextStyle(fontSize: Dimension.Text_Size,color: Themes.Text_Color),)
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
                        Container(
                          width: 40,
                          height: 100,
                          margin: EdgeInsets.only(right: 10,top: 10,bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Themes.Grey)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: ()=>cartProvider.cartUpdate(index,quantity: date.quantity+1),
                                  child: Icon(Icons.add,color: Themes.Grey,),
                                ),
                              ),
                              Divider(color: Themes.Grey,height: 1,),
                              Padding(
                                padding: EdgeInsets.only(top: 5,bottom: 5),
                                child: Text(date.quantity.toString(),style: Theme.of(context).textTheme.bodyText1,),
                              ),
                              Divider(color: Themes.Grey,height: 1,),
                              Expanded(
                                child: GestureDetector(
                                  onTap: ()=>cartProvider.cartUpdate(index,quantity: date.quantity-1),
                                  child: Icon(Icons.remove,color: Themes.Grey),
                                ),
                              ),
                            ],
                          ),
                        )
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
            )
        )
    );
  }
}
