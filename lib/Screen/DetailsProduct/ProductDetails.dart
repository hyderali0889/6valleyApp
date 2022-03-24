import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geniouscart/Class/DetailsProduct.dart';
import 'package:geniouscart/Class/Product.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Packege/Loading_Button/Loading_Button.dart';
import 'package:geniouscart/Packege/TabView/src/navigation_bar.dart';
import 'package:geniouscart/Providers/ProductDetailsProvider.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/Screen/DetailsProduct/AddReview.dart';
import 'package:geniouscart/Screen/DetailsProduct/DeleteComment.dart';
import 'package:geniouscart/Screen/MainScreen.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/Widgets/CircleButton.dart';
import 'package:geniouscart/Widgets/CircularProgress.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/DefaultCartIcon.dart';
import 'package:geniouscart/Widgets/DefaultDialog.dart';
import 'package:geniouscart/Widgets/DefaultTextField.dart';
import 'package:geniouscart/Widgets/DividerList.dart';
import 'package:geniouscart/Widgets/Headding.dart';
import 'package:geniouscart/Widgets/ImagePlaceHolder.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/LoadingView.dart';
import 'package:geniouscart/Widgets/ProductImageSlider.dart';
import 'package:geniouscart/Widgets/RatingVIew.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';
import 'package:geniouscart/CustomIcon/my_flutter_app_icons.dart' as CustomIcon;
import 'package:websafe_svg/websafe_svg.dart';

import 'PhotoVIew.dart';

class ProductDetails extends StatefulWidget {
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  ProductDetailsProvider productDetailsProvider;
  ProductData data;
  @override
  Widget build(BuildContext context) {
    Api_Client.config(context);
    data=ModalRoute.of(context).settings.arguments;
    return ChangeNotifierProvider<ProductDetailsProvider>(
        create: (BuildContext context) =>ProductDetailsProvider(data),
        child: Consumer<ProductDetailsProvider>(builder: (context, model, child) {
          productDetailsProvider=model;
          return Scaffold(
            appBar: DefaultAppbar(
              context: context,
              title:language.Details,
              action: Padding(
                padding: EdgeInsets.only(right: Dimension.Padding),
                child: DefaultCartIcon(
                    quentity: productDetailsProvider.cartProvider.addToCart.length.toString(),
                    iconColor: Themes.White,
                    onTap: (){
                      Navigator.of(context).pushNamed(CART,arguments: true);
                      /*Navigator.of(context).pop();
                      mainPageProvider.changeTab(2);*/
                    }
                ),
              )
            ),
            body: Container(
              child: Stack(
                children: [
                  productDetailsProvider.detailsProduct!=null ? ListView(
                    padding: EdgeInsets.all(0),
                    children: [
                      ImageSection(),
                      Container(
                        padding: EdgeInsets.only(left : Dimension.Padding,right: Dimension.Padding,top: Dimension.Padding),
                        child: Text(productDetailsProvider.detailsProduct.data.title,style: TextStyle(color: Themes.Text_Color,fontSize: 20,fontWeight: Dimension.textBold),),
                      ),
                      Container(
                        padding: EdgeInsets.only(left : Dimension.Padding,right: Dimension.Padding,bottom: Dimension.Padding),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                  productDetailsProvider.detailsProduct.data.sizeQuantity.isNotEmpty ?
                                  FlatButton.icon(
                                      onPressed: null,
                                      icon: Icon(productDetailsProvider.inStock ? Icons.check_circle_outline : Icons.cancel,color: productDetailsProvider.inStock ? Themes.Green : Themes.Red, ),
                                      label: Text(productDetailsProvider.inStock ? language.In_Stock : language.Out_of_Stock,style: TextStyle(color: productDetailsProvider.inStock ? Themes.Green : Themes.Red,fontSize: Dimension.Text_Size,fontWeight: Dimension.textBold),)
                                  ):Container(),
                                RatingView(rating: productDetailsProvider.detailsProduct.data.rating.toDouble(),unratedColor: Themes.Grey),
                                Padding(
                                  padding: EdgeInsets.only(left: Dimension.Padding),
                                  child: Text('${productDetailsProvider.detailsProduct.data.reviews.length} ${language.Reviews}',style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size_Small,fontWeight: Dimension.textMedium),),
                                )
                              ],
                            ),
                            productDetailsProvider.detailsProduct.data.condition!=null ? Container(
                              padding: EdgeInsets.only(left: 10,right: 10),
                              decoration: BoxDecoration(
                                color: productDetailsProvider.detailsProduct.data.condition==AppConstant.New ? Themes.Green :Themes.Red,
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: Text(productDetailsProvider.detailsProduct.data.condition,style: TextStyle(color: Themes.White,fontSize: Dimension.Text_Size_Small,fontWeight: Dimension.textBold),),
                            ):Container(),
                            Container(
                              padding: EdgeInsets.only(top: 5,bottom: 5),
                              child: Row(
                                children: [
                                  Text('${language.Price} : ',style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size_Big,fontWeight: Dimension.textMedium)),
                                  Padding(
                                    padding: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding),
                                    child: Text(actualPrice(productDetailsProvider.getProductCalculatedPrice()), style: TextStyle(fontWeight: Dimension.textBold,fontSize: 20,color: Themes.Primary)),
                                  ),
                                  Text(actualPrice(productDetailsProvider.detailsProduct.data.previousPrice),style: TextStyle(fontSize: Dimension.Text_Size,fontWeight: Dimension.textNormal,color: Themes.Grey,decoration: TextDecoration.lineThrough)),
                                  Expanded(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        CircleButton(
                                            loading: productDetailsProvider.favoriteState,
                                            onTap: ()=>productDetailsProvider.addToFavorite(),
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: productDetailsProvider.isFavorite ? Themes.Primary : Colors.transparent,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(color: Themes.Primary,width: 2)
                                              ),
                                              child: Icon(productDetailsProvider.isFavorite ? Icons.favorite : Icons.favorite_border,color: productDetailsProvider.isFavorite ? Themes.Icon_Color : Themes.Primary),
                                            )
                                        ),
                                        /*CircleButton(
                                            loading: productDetailsProvider.compareState,
                                            onTap: ()=>productDetailsProvider.addToCompare(),
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: productDetailsProvider.isCompared ? Themes.Primary : Colors.transparent,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(color: Themes.Primary,width: 2)
                                              ),
                                              child: Icon(Icons.compare_arrows,color: productDetailsProvider.isCompared ? Themes.Icon_Color : Themes.Primary),
                                            )
                                        )*/
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible: productDetailsProvider.detailsProduct.data.sizes.length>0,
                        child: Container(
                          margin: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('${language.Size} : ',style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size_Big,fontWeight: Dimension.textMedium)),
                              Expanded(
                                child: Container(
                                  height: 40,
                                  child: ListView.builder(
                                    padding: EdgeInsets.all(0),
                                      shrinkWrap: true,
                                      itemCount: productDetailsProvider.detailsProduct.data.sizes.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context,index){
                                        return GestureDetector(
                                          onTap: ()=>productDetailsProvider.selectProductSize(index),
                                          child: Container(
                                            height: 30,
                                            width: 40,
                                            margin: EdgeInsets.only(left: 5),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Themes.Background,
                                              border: Border.all(color: productDetailsProvider.selectedSize==index ? Themes.Primary : Themes.Text_Color,width: 1.5)
                                            ),
                                            child: Text(productDetailsProvider.detailsProduct.data.sizes[index],style: TextStyle(color: productDetailsProvider.selectedSize==index ? Themes.Primary : Themes.Text_Color,fontSize: Dimension.Text_Size_Big,fontWeight: Dimension.textMedium),),
                                          ),
                                        );
                                      }
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: productDetailsProvider.detailsProduct.data.colors.length>0,
                        child: Container(
                          margin: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding,top: Dimension.Padding),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('${language.Color} : ',style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size_Big,fontWeight: Dimension.textMedium)),
                              Expanded(
                                child: Container(
                                  height: 40,
                                  child: ListView.builder(
                                      padding: EdgeInsets.all(0),
                                      shrinkWrap: true,
                                      itemCount: productDetailsProvider.detailsProduct.data.colors.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context,index){
                                        return GestureDetector(
                                          onTap: ()=>productDetailsProvider.selectProductColor(index),
                                          child: Container(
                                            height: 30,
                                            width: 40,
                                            margin: EdgeInsets.only(left: 5),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: getColors(productDetailsProvider.detailsProduct.data.colors[index]),
                                                shape: BoxShape.circle
                                            ),
                                            child: productDetailsProvider.selectedColor==index ? Icon(Icons.check,color: Themes.White,) : Container(),
                                          ),
                                        );
                                      }
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        //visible: productDetailsProvider.inStock,
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height:50,
                                    margin: EdgeInsets.all(Dimension.Padding),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Themes.Text_Color,width: 1)
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: ()=>productDetailsProvider.addProduct(false),
                                          icon: Icon(Icons.remove,color: Themes.Text_Color,),
                                        ),
                                        VerticalDivider(thickness: 1,color: Themes.Text_Color,),
                                        Padding(
                                          padding: EdgeInsets.only(left: 10,right: 10),
                                          child: Text(productDetailsProvider.quantity.toString(),style: Theme.of(context).textTheme.bodyText1,),
                                        ),
                                        VerticalDivider(thickness: 1,color: Themes.Text_Color,),
                                        IconButton(
                                          onPressed: ()=>productDetailsProvider.addProduct(true),
                                          icon: Icon(Icons.add,color: Themes.Text_Color,),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: Dimension.Padding),
                              child: CircleButton(
                                  loading: productDetailsProvider.cartState,
                                  onTap: (){
                                    if(productDetailsProvider.inStock)
                                      productDetailsProvider.addProductToCart();
                                    else
                                      ErrorMessage(context,message: language.Out_of_Stock);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    foregroundDecoration: BoxDecoration(
                                        color: !productDetailsProvider.inStock ? Themes.Background : null,
                                        shape: BoxShape.circle,
                                        backgroundBlendMode: !productDetailsProvider.inStock ? BlendMode.saturation : null,
                                        //border: Border.all(color: !productDetailsProvider.inStock ? Themes.Grey : Themes.Primary,width: 2)
                                    ),
                                    decoration: BoxDecoration(
                                        color: productDetailsProvider.isAddedToCart ? Themes.Primary : Colors.transparent,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Themes.Primary,width: 2)
                                    ),
                                    child: Icon(Icons.add_shopping_cart ,color: productDetailsProvider.isAddedToCart ? Themes.Icon_Color : Themes.Primary),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                       Visibility(
                         visible: productDetailsProvider.detailsProduct.data.estimatedShippingTime != null,
                         child: Container(
                          margin: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding,bottom: 10,top: 10),
                          child: RichText(
                            text: TextSpan(
                              text: language.Estimated_Shipping_Time,
                              style: Theme.of(context).textTheme.bodyText1,
                              children: <TextSpan>[
                                TextSpan(text: productDetailsProvider.detailsProduct.data.estimatedShippingTime, style: TextStyle(fontWeight: Dimension.textBold,fontSize: Dimension.Text_Size,color: Themes.Text_Color)),
                              ],
                              ),
                            ),
                        ),
                       ),
                      productDetailsProvider.detailsProduct.data.attributes!=null ? ListView.builder(
                        padding: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: productDetailsProvider.detailsProduct.data.attributes.name.length,
                        itemBuilder: (context,index){
                          return ListAnimation(child: attributesItem(index),index: index);
                        },
                      ) : Container(),
                      Container(
                        height: 40,
                        margin: EdgeInsets.only(top: Dimension.Padding),
                        child: CustomTabView(
                          onTap: (index)=>productDetailsProvider.changeSection(index),
                          reverse: true,
                          curve: Curves.easeInBack,
                          items: productDetailsProvider.items,
                          activeColor: Themes.Primary,
                          enableShadow: false,
                          inactiveColor: Themes.Text_Color,
                          indicatorColor: Themes.Primary,
                          inactiveStripColor: Themes.Background,
                          currentIndex: productDetailsProvider.section(),
                          fontSize: Dimension.Text_Size_Small,
                        ),
                      ),
                      Sections(),
                      Visibility(visible:productDetailsProvider.detailsProduct.data.wholeSellQuantity.length>0,child: WholeSell()),
                      SoldBy(),
                      Headding(title: language.Related_Products,width: 125),
                      AllRelatedProduct()
                    ],
                  ):LoadingView(),
                  /*Positioned(
                    top: paddingTop,
                    left: 0,
                    width: mainWidth,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.arrow_back_ios,color: Themes.Primary,),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: DefaultCartIcon(
                              quentity: productDetailsProvider.cartProvider.addToCart.length.toString(),
                            iconColor: Themes.Primary,
                            onTap: ()=>Navigator.of(context).pushNamed(CART,arguments: true)
                          ),
                        )
                      ],
                    ),
                  )*/
                ],
              ),
            ),
          );
        }));
  }

  Color getColors(String color){
    try{
      return Themes.getColorFromColorCode(color);
    }catch(e){
      return Themes.White;
    }
  }

  Widget Sections() {
    if(productDetailsProvider.detailsSection==0)
      return Padding(
        padding:  EdgeInsets.all(Dimension.Padding),
        child: Text(productDetailsProvider.detailsProduct.data.details,style: Theme.of(context).textTheme.bodyText1),
      );
    else if(productDetailsProvider.detailsSection==1)
      return Padding(
        padding:  EdgeInsets.all(Dimension.Padding),
        child: Text(productDetailsProvider.detailsProduct.data.policy,style: Theme.of(context).textTheme.bodyText1,),
      );
    else if(productDetailsProvider.detailsSection==2)
      return reviewView();
    else if(productDetailsProvider.detailsSection==3)
      return commentView();
    else return Container();
  }

  Widget reviewView(){
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.all(0),
      physics: NeverScrollableScrollPhysics(),
      children: [
        productDetailsProvider.detailsProduct.data.reviews.length > 0 ? ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.all(0),
          physics: NeverScrollableScrollPhysics(),
          itemCount: productDetailsProvider.detailsProduct.data.reviews.length,
          itemBuilder: (context,index){
            return ListAnimation(
              index: index,
              child: reviewList(productDetailsProvider.detailsProduct.data.reviews[index])
            );
          },
        ) : Container(
          width: mainWidth,
          height: 150,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/review.png',height: 100,),
              Text(language.Empty_Customer_Review,style: TextStyle(color: Themes.Grey,fontSize: Dimension.Text_Size_Big,fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        auth==null ? loginView(language.Login_to_Review) :
        Container(
          margin: EdgeInsets.only(top: Dimension.Padding),
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: ()=>showWriteReviewDialog(),
            child: Container(
              width: 150,
              height: 40,
                alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Themes.Primary,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Text(language.Write_a_review,textAlign: TextAlign.center,style: TextStyle(color: Themes.White,fontSize: Dimension.Text_Size,fontWeight: Dimension.textMedium),)
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: Dimension.Padding),
        )
      ],
    );
  }

  Widget commentView(){
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.all(0),
      physics: NeverScrollableScrollPhysics(),
      children: [
        productDetailsProvider.detailsProduct.data.comments.length > 0 ? ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.all(0),
          physics: NeverScrollableScrollPhysics(),
          itemCount: productDetailsProvider.detailsProduct.data.comments.length,
          itemBuilder: (context,index){
            return ListAnimation(
                index: index,
                child: commentList(productDetailsProvider.detailsProduct.data.comments[index],index)
            );
          },
        ) : Container(
          width: mainWidth,
          height: 150,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/comment.png',height: 100,),
              Text(language.Empty_Comment,style: TextStyle(color: Themes.Grey,fontSize: Dimension.Text_Size_Big,fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        auth==null ?  loginView(language.Login_to_Comment) :
        writeComment(),
        Padding(
          padding: EdgeInsets.only(bottom: Dimension.Padding),
        )
      ],
    );
  }


  Widget reviewList(Reviews review) {
    return Container(
      margin: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding,top: Dimension.Padding),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Themes.White,
                  border: Border.all(color: Themes.Primary,width: 2)
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: review.userImage,
                    fit: BoxFit.cover,
                    width: 70,
                    height: 70,
                    progressIndicatorBuilder: (context, url, downloadProgress) =>ImagePlaceHolder(height: 70),
                    errorWidget: (context, url, error) => ImagePlaceHolder(isError: true,height: 70),
                  ),
                )
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(review.name,style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size,fontWeight: Dimension.textBold),),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5,bottom: 5),
                        child: RatingView(rating: double.parse(review.rating),unratedColor: Themes.Grey),
                      ),
                      Text(review.review,style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size_Small,fontWeight: Dimension.textNormal),),
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child:Text(review.reviewDate,style: TextStyle(color: Themes.Text_Color.withAlpha(Dimension.Alpha),fontSize: Dimension.Text_Size_Small_Extra,fontWeight: Dimension.textNormal)),
          )
        ],
      ),
    );
  }  
  Widget commentList(Comments comment,int index,{bool isDialog=false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExpansionTile(
          maintainState: true,
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: Dimension.Padding/2,bottom: Dimension.Padding/2),
                child: Stack(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Themes.White,
                                border: Border.all(color: Themes.Primary,width: 2)
                            ),
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: comment.userImage,
                                fit: BoxFit.cover,
                                width: 70,
                                height: 70,
                                progressIndicatorBuilder: (context, url, downloadProgress) =>ImagePlaceHolder(height: 70),
                                errorWidget: (context, url, error) => ImagePlaceHolder(isError: true,height: 70),
                              ),
                            )
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(comment.name,style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size,fontWeight: Dimension.textBold),),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child:Text(comment.comment,style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size_Small,fontWeight: Dimension.textNormal),),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Visibility(
                        visible: !isDialog,
                        child: Row(
                          children: [
                            user!=null ? GestureDetector(
                              onTap: ()=>productDetailsProvider.setEnableReply(index),
                              child: Icon(CustomIcon.MyFlutterApp.replay,color: Themes.Primary,),
                            ):Container(),
                            user!=null ? Visibility(
                              visible: comment.userId==user.id.toString(),
                              child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: GestureDetector(
                                  onTap: ()=>productDetailsProvider.setEditComment(index),
                                  child: Icon(CustomIcon.MyFlutterApp.edit,color: Themes.Primary,),
                                ),
                              ),
                            ) : Container(),
                            user!=null ? Visibility(
                              visible: comment.userId==user.id.toString(),
                              child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: GestureDetector(
                                  onTap: ()=>showDeleteComment(index),
                                  child: Icon(Icons.delete_outline,color: Themes.Primary,),
                                ),
                              ),
                            ) : Container(),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child:Text(comment.createdAt,style: TextStyle(color: Themes.Text_Color.withAlpha(Dimension.Alpha),fontSize: Dimension.Text_Size_Small_Extra,fontWeight: Dimension.textNormal)),
                    )
                  ],
                ),
              ),
              user!=null ? productDetailsProvider.commentEditEnable[index] ? editComment(index: index) : Container() : Container()
            ],
          ),
          children: comment.replies.asMap().map((replyIndex,e) => MapEntry(
            replyIndex,
              commentReplayItem(e,index,replyIndex)
          )).values.toList(),
          onExpansionChanged: (state){
            productDetailsProvider.setEnableReply(index,state: state);
          },
        ),
        user!=null ? Visibility(
          visible: productDetailsProvider.commentReplyEnable[index] && !isDialog,
          child: Container(
            color: Themes.Primary.withAlpha(15),
            padding: EdgeInsets.only(left: Dimension.Padding*3,bottom: Dimension.Padding),
            child: writeComment(isReply: true,index: index)
          ),
        ) : Container(),
      ],
    );
  }

  Widget commentReplayItem(Replies replies,int commentIndex,int index,{bool isDialog=false}){
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: Dimension.Padding/2,left: isDialog ? Dimension.Padding : Dimension.Padding*3,right: Dimension.Padding,bottom: Dimension.Padding/2),
          color: Themes.Primary.withAlpha(15),
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Themes.White,
                          border: Border.all(color: Themes.Primary,width: 2)
                      ),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: replies.userImage,
                          fit: BoxFit.cover,
                          width: 70,
                          height: 70,
                          progressIndicatorBuilder: (context, url, downloadProgress) =>ImagePlaceHolder(height: 70),
                          errorWidget: (context, url, error) => ImagePlaceHolder(isError: true,height: 70),
                        ),
                      )
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(replies.name,style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size,fontWeight: Dimension.textBold),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child:Text(replies.comment,style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size_Small,fontWeight: Dimension.textNormal),),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Visibility(
                  visible: !isDialog,
                  child: Row(
                    children: [
                      user!=null ? Visibility(
                        visible: replies.userId==user.id.toString(),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: GestureDetector(
                            onTap: ()=>productDetailsProvider.setEditReply(commentIndex, index),
                            child: Icon(CustomIcon.MyFlutterApp.edit,color: Themes.Primary,),
                          ),
                        ),
                      ) : Container(),
                      user!=null ? Visibility(
                        visible: replies.userId==user.id.toString(),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: GestureDetector(
                            onTap: ()=>showDeleteReply(commentIndex,index),
                            child: Icon(Icons.delete_outline,color: Themes.Primary,),
                          ),
                        ),
                      ) : Container(),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child:Text(replies.createdAt,style: TextStyle(color: Themes.Text_Color.withAlpha(Dimension.Alpha),fontSize: Dimension.Text_Size_Small_Extra,fontWeight: Dimension.textNormal)),
              )
            ],
          ),
        ),
        productDetailsProvider.myComment[commentIndex].replies[index].isEnableEdit ?
           Container(
             color: Themes.Primary.withAlpha(15),
             padding: EdgeInsets.only(left: Dimension.Padding*3,bottom: Dimension.Padding),
             child: editComment(isReply: true,index: commentIndex,replyIndex: index),
           ) :Container()
      ],
    );
  }


  Widget writeComment({bool isReply=false,int index}){
    return Container(
      margin: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding,top: Dimension.Padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(isReply ? language.Write_Reply : language.Write_Comment,style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size_Small,fontWeight: Dimension.textBold),),
              Visibility(
                visible: isReply,
                child: GestureDetector(
                    onTap: ()=>productDetailsProvider.setEnableReply(index),
                    child: Icon(Icons.cancel,color: Themes.Red,)
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: DefaultTextField(
              controller: isReply ? productDetailsProvider.replay : productDetailsProvider.comment,
              hint: isReply ? language.Write_your_replay : language.Write_your_comment_here,
              backgroundColor: isReply ? Themes.Background : Themes.Primary.withAlpha(15),
              suffixIcon: LoadingButton(
                onPressed: (){
                  if(!isReply)
                    productDetailsProvider.submitComment();
                  else
                    productDetailsProvider.submitCommentReply(index);
                },
                isLoading: isReply ? productDetailsProvider.replyLoading : productDetailsProvider.commentLoading,
                child: Icon(Icons.send,color: Themes.Primary,),
                decoration: BoxDecoration(
                  color: Colors.transparent
                ),
              )
            ),
          )
        ],
      ),
    );
  }
  Widget editComment({bool isReply=false,int index,int replyIndex}){
    return Container(
      margin: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding,top: Dimension.Padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(isReply ? language.Edit_Reply : language.Edit_Comment,style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size_Small,fontWeight: Dimension.textBold),),
              GestureDetector(
                  onTap: (){
                    if(isReply)
                      productDetailsProvider.setEditReply(index, replyIndex);
                    else
                      productDetailsProvider.setEditComment(index);
                  },
                  child: Icon(Icons.cancel,color: Themes.Red,)
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: DefaultTextField(
                controller: isReply ? productDetailsProvider.myComment[index].replies[replyIndex].replyController : productDetailsProvider.myComment[index].controller,
                hint: isReply ? language.Write_your_replay : language.Write_your_comment_here,
                backgroundColor: isReply ? Themes.Background : Themes.Primary.withAlpha(15),
                suffixIcon: LoadingButton(
                  onPressed: (){
                    if(!isReply)
                      productDetailsProvider.submitComment(index: index,isUpdate: true);
                    else
                      productDetailsProvider.submitCommentReply(index,isUpdate: true,index: replyIndex);
                  },
                  isLoading: isReply ? productDetailsProvider.myComment[index].replies[replyIndex].Loading : productDetailsProvider.myComment[index].Loading,
                  child: Icon(Icons.send,color: Themes.Primary,),
                  decoration: BoxDecoration(
                      color: Colors.transparent
                  ),
                )
            ),
          )
        ],
      ),
    );
  }


  Widget loginView(String message){
    return Padding(
      padding:  EdgeInsets.all(Dimension.Padding),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RaisedButton(
              color: Themes.Primary,
              onPressed: ()async{
                await Navigator.of(context).pushNamed(AUTHENTICATION,arguments: true);
                productDetailsProvider.checkLoginStatus();
              },
              child: Text(language.Login,style: TextStyle(color: Themes.White,fontSize: Dimension.Text_Size_Small,fontWeight: Dimension.textBold),),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(message.replaceAll(language.Login, ''),style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size_Small,fontWeight: Dimension.textBold),),
            )
          ],
        ),
      ),
    );
  }

  Widget WholeSell() {
    return Container(
      margin: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding),
      decoration: BoxDecoration(
        color: Themes.Primary.withAlpha(20),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10,bottom: 10),
            child: Text(language.Whole_Sell,style: Theme.of(context).textTheme.headline1,),
          ),
          DividerList(
              child: Container(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${language.Quantity}',style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size,fontWeight: Dimension.textMedium),),
                    Text('${language.Discount}',style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size,fontWeight: Dimension.textMedium),),
                  ],
                ),
              )
          ),
          ListView.builder(
            shrinkWrap: true,
              padding: EdgeInsets.only(bottom: 10),
              physics: NeverScrollableScrollPhysics(),
              itemCount: productDetailsProvider.detailsProduct.data.wholeSellQuantity.length,
              itemBuilder: (context,index){
                return DividerList(
                  showDivider: index<productDetailsProvider.detailsProduct.data.wholeSellQuantity.length-1,
                  child: Container(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${productDetailsProvider.detailsProduct.data.wholeSellQuantity[index]} +',style: Theme.of(context).textTheme.bodyText1,),
                        Text('${productDetailsProvider.detailsProduct.data.wholeSellDiscount[index]} % ${language.Off}',style: Theme.of(context).textTheme.bodyText1,),
                      ],
                    ),
                  )
                );
              }
          )
        ],
      ),
    );
  }

  Widget SoldBy() {
    return Container(
      margin: EdgeInsets.all(Dimension.Padding),
      child: Stack(
        children: [
          DottedBorder(
            borderType: BorderType.RRect,
            color: Themes.Primary,
            radius: Radius.circular(10),
            padding: EdgeInsets.all(10),
            strokeWidth: 3,
            dashPattern: [8, 3],
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                width: mainWidth,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(language.Sold_By,style: TextStyle(color: Themes.Primary,fontWeight: Dimension.textBold,fontSize: Dimension.Text_Size),),
                    FlatButton.icon(
                        onPressed: null,
                        icon: Icon(Icons.check_circle,color: Themes.Green,),
                        label: Text(productDetailsProvider.detailsProduct.data.shop.name,style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size,fontWeight: Dimension.textBold),)
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: productDetailsProvider.detailsProduct.data.shop.items.split(' ')[0],
                        style: TextStyle(color: Themes.Primary,fontSize: 24,fontWeight: Dimension.textBold),
                        children: <TextSpan>[
                          TextSpan(text: '\n${language.Total_Items}', style: TextStyle(fontWeight: Dimension.textNormal,fontSize: Dimension.Text_Size,color: Themes.Text_Color)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: -10,
            child: Visibility(
              visible: user!=null && productDetailsProvider.detailsProduct.data.shop.id!=null,
              child: Container(
                margin: EdgeInsets.only(right: Dimension.Padding),
                child: CircleButton(
                    loading: productDetailsProvider.addToFavoriteSellerLoading,
                    onTap: ()=>productDetailsProvider.addToFavoriteSeller(),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: productDetailsProvider.isAddedToCart ? Themes.Primary : Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(color: Themes.Primary,width: 2)
                      ),
                      child: WebsafeSvg.asset('assets/images/buy.svg' ,color: productDetailsProvider.isAddedToCart ? Themes.Icon_Color : Themes.Primary,height: 24,width: 24,),
                    )
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget relatedProductList(RelatedProducts date,int index){
    return GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed(PRODUCT_DETAILS,arguments: ProductData.fromJson(date.toJson()));
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

  AllRelatedProduct() {
      return Visibility(
        visible: productDetailsProvider.detailsProduct.data.relatedProducts.length >0,
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: productDetailsProvider.detailsProduct.data.relatedProducts.length,
          padding: EdgeInsets.only(left: 10,right: 10,top: 10),
          itemBuilder: (context, index) {
            return ListAnimation(
                index: index,
                child: relatedProductList(productDetailsProvider.detailsProduct.data.relatedProducts[index],index)
            );
          } ,
        ),
      );
  }

  Widget ImageSection() {
    if(productDetailsProvider.detailsProduct.data.images.length>0){
      return ProductImageSlider(productDetailsProvider.detailsProduct.data.images,productDetailsProvider.detailsProduct.data.firstImage);
    }else{
      return GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PhotoView(
                initialIndex: 0,
                images: [ProductImages(id: 0,image: productDetailsProvider.detailsProduct.data.firstImage)],
              ),
            ),
          );
        },
        child: CachedNetworkImage(
          imageUrl: productDetailsProvider.detailsProduct.data.firstImage,
          fit: BoxFit.cover,
          width: mainWidth,
          progressIndicatorBuilder: (context, url, downloadProgress) =>ImagePlaceHolder(height: 300),
          errorWidget: (context, url, error) => ImagePlaceHolder(isError: true,height: 300),
        ),
      );
    }
  }

  void showWriteReviewDialog()async{
    var data = await showDialog(
        context: context,
        builder: (BuildContext context){
          return DefaultDialog(
        title: language.Review,
        child: AddReview(productDetailsProvider.detailsProduct),
      );
        }
    );
    if(data!=null){
      productDetailsProvider.getProductDetails();
    }
  }

  void showDeleteComment(int index)async{
    var data = await showDialog(
        context: context,
        builder: (BuildContext context){
          return DefaultDialog(
          title: language.Delete_Comment,
          child: DeleteComment(commentList(productDetailsProvider.detailsProduct.data.comments[index], index,isDialog: true),
            comment: productDetailsProvider.detailsProduct.data.comments[index],
            message: language.Delete_Comment_Alert,
          ),
        );
        }
    );
    if(data!=null)if(data==true){
      productDetailsProvider.deleteComment(index);
    }
  }
  void showDeleteReply(int commentIndex,int index)async{
    var data = await showDialog(
        context: context,
        builder: (BuildContext context){
          return DefaultDialog(
          title: language.Delete_Reply,
          child: DeleteComment(commentReplayItem(productDetailsProvider.detailsProduct.data.comments[commentIndex].replies[index], commentIndex,index,isDialog: true),
            comment: productDetailsProvider.detailsProduct.data.comments[commentIndex],
            message: language.Delete_reply_Alert,
            isReply: true,
            replyIndex: index,
          ),
        );
        }
    );
    if(data!=null)if(data==true){
      productDetailsProvider.deleteCommentReply(commentIndex,index);
    }
  }

  Widget attributesItem(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(productDetailsProvider.detailsProduct.data.attributes.name[index].replaceAll('_', ' ').toUpperCase(),style: Theme.of(context).textTheme.headline1,),
        Container(
          padding: EdgeInsets.only(top: Dimension.Size_10,bottom: Dimension.Size_5),
          child:ListView.builder(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: productDetailsProvider.detailsProduct.data.attributes.attribute[index].values.length,
            itemBuilder: (context,position){
              return ListAnimation(child: InkWell(
                onTap: ()=>productDetailsProvider.selectAttribute(index,position),
                child: Padding(
                  padding:  EdgeInsets.only(bottom: Dimension.Size_5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(productDetailsProvider.detailsProduct.data.attributes.attribute[index].selected[position] ? Icons.radio_button_checked : Icons.radio_button_off,color: Themes.Primary,),
                      SizedBox(width: Dimension.Size_10,),
                      Expanded(child: Text('${productDetailsProvider.detailsProduct.data.attributes.attribute[index].values[position]} + ${actualPrice(productDetailsProvider.detailsProduct.data.attributes.attribute[index].prices[position])}',style: Theme.of(context).textTheme.bodyText1,))
                    ],
                  ),
                ),
              ),index: index);
            },
          ),
        )
      ],
    );
  }

}


