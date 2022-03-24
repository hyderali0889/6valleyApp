import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geniouscart/AppHelper/Helper.dart';
import 'package:geniouscart/Class/DetailsProduct.dart';
import 'package:geniouscart/Class/Product.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Packege/TabView/src/navigation_bar_item.dart';
import 'package:geniouscart/Providers/CartProvider.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/DefaultDialog.dart';
import 'package:geniouscart/Widgets/DialogButton.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';

class ProductDetailsProvider with ChangeNotifier{
  ProductData data;
  DetailsProduct detailsProduct;
  BuildContext context;
  bool haveInternetError=false;
  int selectedSize=0;
  int selectedColor=0;
  int quantity=1;
  bool inStock=false;
  bool isFavorite=false,favoriteState=false;
  bool isCompared=false,compareState=false;
  bool isAddedToCart=false,cartState=false;
  int cartIndex=-1;
  int detailsSection=0;

  List<bool> commentReplyEnable=List();
  List<bool> commentEditEnable=List();

  TextEditingController comment=TextEditingController();
  TextEditingController replay=TextEditingController();
  bool commentLoading=false,replyLoading=false;

  bool addToFavoriteSellerLoading=false;

  List<IsMyComment> myComment=List();

  CartProvider cartProvider;

  final List<TabViewItem> items = [
    TabViewItem(title: Text(language.Product_Details_Sections[0]),backgroundColor: Themes.Background),
    TabViewItem(title: Text(language.Product_Details_Sections[1]),backgroundColor: Themes.Background),
    TabViewItem(title: Text(language.Product_Details_Sections[2]),backgroundColor: Themes.Background),
    TabViewItem(title: Text(language.Product_Details_Sections[3]),backgroundColor: Themes.Background),
  ];

  int section()=>detailsSection;
  void changeSection(int index){
    detailsSection=index;
    notifyListeners();
  }
  ProductDetailsProvider(ProductData value){
    context=Api_Client.context;
    data=value;
    cartProvider=Provider.of<CartProvider>(context);
    getProductDetails();
    cartIndex=cartProvider.getHaveAddedToCart(data.id);
    if(cartIndex>-1){
      quantity=cartProvider.addToCart[cartIndex].quantity;
      isAddedToCart=true;
    }
  }

  Future getProductDetails()async{
    String Link=DetailsProduct.makeDetailsProductApi(URL.ProductDetails,productId: data.id.toString());
    Map<String,dynamic> response = await Api_Client.SimpleRequest(url: Link);
    /*try {*/
      if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
        detailsProduct = DetailsProduct.fromJson(response);
        if(detailsProduct.data.sizeQuantity.isNotEmpty){
          inStock=int.parse(detailsProduct.data.sizeQuantity[selectedSize])>0;
        }
        else
          inStock=true;
        if(isAddedToCart){
          for(int i=0;i<detailsProduct.data.sizes.length;i++){
            if(cartProvider.addToCart[cartIndex].selectedSize==detailsProduct.data.sizes[i]){
              selectedSize=i;
              break;
            }
          }
          for(int i=0;i<detailsProduct.data.colors.length;i++){
            if(cartProvider.addToCart[cartIndex].selectedColor==detailsProduct.data.colors[i]){
              selectedColor=i;
              break;
            }
          }
          try{
            for(int i=0;i<detailsProduct.data.attributes.attribute.length;i++){
              for(int j=0;j<cartProvider.addToCart[cartIndex].attributes.attribute.length;j++){
                if(cartProvider.addToCart[cartIndex].attributes.name[j]==detailsProduct.data.attributes.name[i]){
                  detailsProduct.data.attributes.attribute[i].selected=cartProvider.addToCart[cartIndex].attributes.attribute[j].selected;
                  break;
                }
              }
            }
          }catch(e){}
        }
/*        if(detailsProduct.data.sizes.length>0){
          detailsProduct.data.currentPrice=(currentPrice+double.parse(detailsProduct.data.sizePrice[selectedSize])).toString();
        }*/
        setCommentData();
      } else if (response.containsKey(AppConstant.Error)) {
        ErrorMessage(context,message: response[AppConstant.Error]);
      }
    /*} catch (e) {
      haveInternetError=true;
      ErrorMessage(context,message: response[AppConstant.Error]);
    }*/
    notifyListeners();
  }

  Future addToFavoriteSeller()async{
    addToFavoriteSellerLoading=true;
    notifyListeners();
    Map<String,dynamic> response = await Api_Client.Request(url: URL.Add_Favorite_Sellers,method: Method.POST,body: {AppConstant.vendor_id:detailsProduct.data.shop.id.toString()});
    try {
      if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
        SuccessMessage(context,message: response[AppConstant.Error].toString()!='[]' ? response[AppConstant.Error][AppConstant.message] : response[AppConstant.data][AppConstant.message]);
      } else if (response.containsKey(AppConstant.Error)) {
        ErrorMessage(context,message: response[AppConstant.Error]);
      }
    } catch (e) {
      haveInternetError=true;
      ErrorMessage(context,message: response[AppConstant.Error]);
    }
    addToFavoriteSellerLoading=false;
    notifyListeners();
  }

  void setCommentData(){
    myComment.clear();
    commentEditEnable.clear();
    commentReplyEnable.clear();
    for(int i=0;i<detailsProduct.data.comments.length;i++){
      commentReplyEnable.add(false);
      commentEditEnable.add(false);
      myComment.add(IsMyComment.fromComment(detailsProduct.data.comments[i]));
    }
  }

  void setEnableReply(int index,{bool state}){
    commentReplyEnable[index]=state ?? !commentReplyEnable[index];
    notifyListeners();
  }
  void setEditComment(int index){
    commentEditEnable[index]=!commentEditEnable[index];
    notifyListeners();
  }

  void setEditReply(int index,int replyIndex){
    myComment[index].replies[replyIndex].isEnableEdit=!myComment[index].replies[replyIndex].isEnableEdit;
    notifyListeners();
  }


  void selectProductSize(int index){
    selectedSize=index;
    inStock=int.parse(detailsProduct.data.sizeQuantity[selectedSize])>0;
   /* if(detailsProduct.data.sizes.length>0){
      detailsProduct.data.currentPrice=(currentPrice+double.parse(detailsProduct.data.sizePrice[index])).toString();
    }*/
    notifyListeners();
  }

  String getProductCalculatedPrice(){
    double price=0;
    if(detailsProduct.data.attributes!=null){
      for(int i=0;i<detailsProduct.data.attributes.attribute.length;i++){
        price+=double.parse(detailsProduct.data.attributes.attribute[i].prices[detailsProduct.data.attributes.attribute[i].selected.indexOf(true)]);
      }
    }
    if(detailsProduct.data.sizePrice.isNotEmpty){
      price+=double.parse(detailsProduct.data.sizePrice[selectedSize]);
    }
    return (double.parse(detailsProduct.data.currentPrice)+price).toStringAsFixed(2);
  }

  void selectProductColor(int index){
    selectedColor=index;
    notifyListeners();
  }
  void addProduct(bool isAdd){
    if(isAdd /*&& int.parse(detailsProduct.data.sizeQuantity[selectedSize])>quantity*/)
      quantity++;
    else{
      if(quantity>1)
        quantity--;
    }
    notifyListeners();
  }
  void addToFavorite()async{
    if(user==null){
      showLoginDialog();
    }
    else {
      favoriteState = true;
      notifyListeners();
      Map<String, dynamic> response = await Api_Client.Request(
          url: URL.Add_Favorite_Product,
          method: Method.POST,
          body: {AppConstant.product_id: detailsProduct.data.id.toString()});
      try {
        if (response.containsKey(AppConstant.status) && response[AppConstant.status] == true) {
          isFavorite=true;
          if (response.containsKey(AppConstant.Error) && response[AppConstant.Error].toString()!='[]'){
            SuccessMessage(context, message: response[AppConstant.Error][AppConstant.message]);
          }
          else{
            SuccessMessage(context,message: response[AppConstant.data][AppConstant.message]);
          }
        } else if (response.containsKey(AppConstant.Error)) {
          ErrorMessage(context, message: response[AppConstant.Error][AppConstant.message]);
        }
      } catch (e) {
        haveInternetError = true;
        ErrorMessage(context, message: response[AppConstant.Error]);
      }
      favoriteState = false;
      notifyListeners();
    }
  }
  void addToCompare(){
    if(user==null){
      showLoginDialog();
    }
    else{
      compareState=true;
      notifyListeners();
      Timer(const Duration(milliseconds: 2000), () {
        isCompared=!isCompared;
        compareState=false;
        notifyListeners();
      });
    }
  }
  void addProductToCart(){
    cartState=true;
    notifyListeners();
    cartProvider.addedToCart(detailsProduct, quantity: quantity,
        selectedColor: detailsProduct.data.colors.isNotEmpty ? detailsProduct
            .data.colors[selectedColor] : '',
        selectedSize: detailsProduct.data.sizes.isNotEmpty ? detailsProduct
            .data.sizes[selectedSize] : '',
        sizePrice: detailsProduct.data.sizePrice.isNotEmpty ? detailsProduct.data
            .sizePrice[selectedSize] : '');

    Timer(Duration(milliseconds: 2000), () {
      isAddedToCart=true;
      cartState=false;
      notifyListeners();
    });
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
                  child: Text(language.Please_Login_your_account,style: Theme.of(context).textTheme.bodyText1,),
                ),
                DialogButton(
                    negativeButton: language.Close,
                    positiveButton: language.OK,
                    onTap: (status){
                      Navigator.of(context).pop();
                      if(status)
                        Navigator.of(context).pushNamed(AUTHENTICATION,arguments: true);
                    }
                )
              ],
            ),
          );
        },
    );
  }
  void checkLoginStatus(){
    setCommentData();
    notifyListeners();
  }

  Future submitComment({bool isUpdate=false,int index})async{
    if(isUpdate)
      myComment[index].Loading=true;
    else
      commentLoading=true;
    notifyListeners();
    Map<String,String> body={
      AppConstant.comment: isUpdate ? myComment[index].controller.text : comment.text
    };
    if(isUpdate)
      body[AppConstant.id] = detailsProduct.data.comments[index].id.toString();
    else
      body[AppConstant.product_id] = detailsProduct.data.id.toString();
    Map<String,dynamic> response = await Api_Client.Request(url: isUpdate ? URL.Edit_Comment : URL.Submit_Comment,method: Method.POST,body: body);
    try {
      if(response.containsKey(AppConstant.data)) {
        if(isUpdate) {
          detailsProduct.data.comments[index].comment=Comments.fromJson(response[AppConstant.data]).comment;
          myComment[index].controller.text=detailsProduct.data.comments[index].comment;
          commentEditEnable[index]=false;
        }
        else{
          detailsProduct.data.comments.add(Comments.fromJson(response[AppConstant.data]));
          myComment.add(IsMyComment.fromComment(Comments.fromJson(response[AppConstant.data])));
          commentReplyEnable.add(false);
          commentEditEnable.add(false);
          comment.text='';
        }
      } else if (response.containsKey(AppConstant.Error)) {
        ErrorMessage(context,message: response[AppConstant.Error]);
      }
    } catch (e) {
      haveInternetError=true;
      ErrorMessage(context,message: response[AppConstant.Error]);
    }
    if(isUpdate)
      myComment[index].Loading=false;
    else
      commentLoading=false;
    notifyListeners();
  }
  Future submitCommentReply(int commentIndex,{bool isUpdate=false,int index})async{
    if(isUpdate)
      myComment[commentIndex].replies[index].Loading=true;
    else
    replyLoading=true;
    notifyListeners();
    Map<String,String> body={
      AppConstant.reply: isUpdate ? myComment[commentIndex].replies[index].replyController.text : replay.text
    };
    if(isUpdate)
      body[AppConstant.id] = detailsProduct.data.comments[commentIndex].replies[index].id.toString();
    else
      body[AppConstant.comment_id] = detailsProduct.data.comments[commentIndex].id.toString();
    Map<String,dynamic> response = await Api_Client.Request(url: isUpdate ? URL.Edit_Reply :  URL.Submit_Comment_Reply,method: Method.POST,body: body);
    try {
      if(response.containsKey(AppConstant.data)) {
        if(isUpdate){
          detailsProduct.data.comments[commentIndex].replies[index]=Replies.fromJson(response[AppConstant.data]);
          setEditReply(commentIndex, index);
        }
        else{
          detailsProduct.data.comments[commentIndex].replies.add(Replies.fromJson(response[AppConstant.data]));
          myComment[commentIndex].replies.add(IsMyReply.fromReplies(Replies.fromJson(response[AppConstant.data])));
          replay.text='';
        }
      } else if (response.containsKey(AppConstant.Error)) {
        ErrorMessage(context,message: response[AppConstant.Error]);
      }
    } catch (e) {
      haveInternetError=true;
      ErrorMessage(context,message: response[AppConstant.Error]);
    }
    if(isUpdate)
      myComment[commentIndex].replies[index].Loading=false;
    else
    replyLoading=false;
    notifyListeners();
  }

  void deleteComment(int index){
    detailsProduct.data.comments.removeAt(index);
    myComment.removeAt(index);
    notifyListeners();
  }
  void deleteCommentReply(int commentIndex,int replyIndex){
    detailsProduct.data.comments[commentIndex].replies.removeAt(replyIndex);
    myComment[commentIndex].replies.removeAt(replyIndex);
    notifyListeners();
  }

  void selectAttribute(int index, int position) {
    detailsProduct.data.attributes.attribute[index].selected=List.filled(detailsProduct.data.attributes.attribute[index].selected.length, false);
    detailsProduct.data.attributes.attribute[index].selected[position]=true;
    notifyListeners();
  }
}

class IsMyComment {
  bool isIt;
  TextEditingController controller;

  List<IsMyReply> replies;
  bool Loading;

  IsMyComment({this.isIt=false, this.controller,this.replies,this.Loading});
  IsMyComment.fromComment(Comments comment){
    replies = List<IsMyReply>();
    for (var reply in comment.replies) {
      replies.add(IsMyReply.fromReplies(reply));
    }
    try{
      isIt= comment.userId==user.id.toString() ? true : false;
    }catch(e){}
    controller=TextEditingController(text: comment.comment);
    Loading=false;
  }

}
class IsMyReply{
  bool isIt;
  TextEditingController replyController;
  bool isEnableEdit;
  bool Loading;

  IsMyReply({this.isIt=false, this.replyController,this.isEnableEdit=false,this.Loading=false});

   static fromReplies(Replies replies){
    try{
      if(replies.userId==user.id.toString())
        return IsMyReply(isIt: true,replyController: TextEditingController(text: replies.comment));
      else
        return IsMyReply(isIt: false,replyController: TextEditingController(text: replies.comment));
    }
    catch(e){
      return IsMyReply(isIt: false,replyController: TextEditingController(text: replies.comment));
    }
  }
}