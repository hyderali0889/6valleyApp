import 'dart:async';
import 'dart:convert';

import 'package:country_pickers/countries.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:geniouscart/Class/Coupon.dart';
import 'package:geniouscart/Class/Product.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Providers/CartProvider.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/URL/Api_Client2.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/DefaultDialog.dart';
import 'package:geniouscart/Widgets/DialogButton.dart';
import 'package:geniouscart/Widgets/KeyboardHandler.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';

class PlaceOrderProvider with ChangeNotifier{
  BuildContext context;
  bool Loading=true;
  int currentPage=0;
  List<Country> allCountry=countryList;
  Country selectedCountry;
  bool haveCouponCode=false;
  Coupon couponData;

  GlobalKey<FormState> formKey=GlobalKey();

  List<String>ways=['Ship To Address','Pick Up'];
  TextEditingController name=TextEditingController(text : user.fullName);
  TextEditingController email=TextEditingController(text : user.email);
  TextEditingController phone=TextEditingController(text : user.phone);
  FocusNode phoneFocus=FocusNode();
  TextEditingController address=TextEditingController(text : user.address);
  TextEditingController state=TextEditingController();
  TextEditingController city=TextEditingController(text: user.city);
  TextEditingController postalCode=TextEditingController(text: user.zipCode);
  TextEditingController orderNote=TextEditingController();

  //Shipping
  TextEditingController shippingName=TextEditingController();
  TextEditingController shippingEmail=TextEditingController();
  TextEditingController shippingPhone=TextEditingController();
  FocusNode shippingPhoneFocus=FocusNode();
  TextEditingController shippingAddress=TextEditingController();
  TextEditingController shippingState=TextEditingController();
  TextEditingController shippingCity=TextEditingController();
  TextEditingController shippingPostalCode=TextEditingController();


  TextEditingController couponCode=TextEditingController();

  bool enableShipping=false;

  CartProvider cartProvider;

  List<Tabs> tabs;

  PageController pageController=PageController(initialPage: 0);

  String selectedShipping;

  Country selectedShippingCountry;
  bool couponLoading=false;

  bool placeOrderLoading=false;

  CouponStatus couponMessage;


  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    tabs=allTabs();
  }

  void setView(BuildContext context){
    this.context=context;
    cartProvider=Provider.of<CartProvider>(context);
    selectedShipping=ways[0];
    tabs=allTabs();
    try{
      selectedCountry=CountryPickerUtils.getCountryByName(user.country);
      selectedShippingCountry=CountryPickerUtils.getCountryByName(user.country);
    }catch(e){}
  }

  allTabs()=>[
    Tabs(
        title: language.Address,
        isSelected: true,
        image: 'assets/images/profile.svg'
    ),
    Tabs(
        title: language.Order,
        isSelected: false,
        image: 'assets/images/order.svg'
    ),
    Tabs(
        title: language.Payment,
        isSelected: false,
        image: 'assets/images/card.svg'
    ),
  ];

  String getQuantity(){
    int count =0;
    for(ProductData data in cartProvider.addToCart){
      count+=data.quantity;
    }
    return count.toString();
  }



  Future submitOrder() async {
    placeOrderLoading=true;
    notifyListeners();
    List products= List();
    for(var product in cartProvider.addToCart){
      var pr={
        AppConstant.id: product.id,
        AppConstant.qty: product.quantity,
        AppConstant.size: product.selectedSize ?? "",
        AppConstant.size_qty: product.selectedSize!="" ? product.quantity : "",
        AppConstant.size_key: product.selectedSize,
        AppConstant.size_price: product.sizePrice,
        AppConstant.color: product.selectedColor,
        AppConstant.keys: "",
        AppConstant.values: "",
        AppConstant.prices: ""
      };
      if(product.attributes!=null){
        var attr={};
        String keys="",values="",prices="";
        for(int i=0;i<product.attributes.attribute.length;i++){
          keys+=i==0 ? product.attributes.name[i]:",${product.attributes.name[i]}";
          values+=i==0 ? product.attributes.attribute[i].values[product.attributes.attribute[i].selected.indexOf(true)]:",${product.attributes.attribute[i].values[product.attributes.attribute[i].selected.indexOf(true)]}";
          prices+=i==0 ? product.attributes.attribute[i].prices[product.attributes.attribute[i].selected.indexOf(true)]:",${product.attributes.attribute[i].prices[product.attributes.attribute[i].selected.indexOf(true)]}";
          attr[product.attributes.name[i]]={
            AppConstant.value:product.attributes.attribute[i].values[product.attributes.attribute[i].selected.indexOf(true)],
            AppConstant.price:product.attributes.attribute[i].prices[product.attributes.attribute[i].selected.indexOf(true)]
          };
        }
        pr[AppConstant.keys]=attr;
        pr[AppConstant.keys]=keys;
        pr[AppConstant.values]=values;
        pr[AppConstant.prices]=prices;
      }
      //print(json.encode(pr));
      products.add(pr);
    }
    Map<String,String> body={
      AppConstant.currency_code: appCurrency.name,
      AppConstant.items: json.encode(products),
      AppConstant.user_id: auth.data.user.id.toString(),
      AppConstant.state: state.text,
      AppConstant.name: name.text,
      AppConstant.email: email.text,
      AppConstant.phone: phone.text,
      AppConstant.address: address.text,
      AppConstant.customer_country: selectedCountry.name ?? "",
      AppConstant.city: city.text,
      AppConstant.zip: postalCode.text,
      AppConstant.shipping_state: shippingState.text,
      AppConstant.shipping_name: shippingName.text ?? "",
      AppConstant.shipping_email: shippingEmail.text ?? "",
      AppConstant.shipping_phone: shippingPhone.text ?? "",
      AppConstant.shipping_address: shippingAddress.text ?? "",
      AppConstant.shipping_country: selectedShippingCountry!=null ? selectedShippingCountry.name :  "",
      AppConstant.shipping_city: shippingCity.text ?? "",
      AppConstant.shipping_zip: shippingPostalCode.text ?? "",
      AppConstant.totalQty: getQuantity(),
      //AppConstant.total: (double.parse(appCurrency.value) * double.parse(getTotalPrice(withCoupon: true))).toStringAsFixed(1),
      AppConstant.total: actualPrice(double.parse(getTotalPrice(withCoupon: true)).toString(),withSign: false),
      AppConstant.shipping: "shipto",
      AppConstant.pickup_location: "",
      AppConstant.shipping_cost: '0',
      AppConstant.packing_cost: '0',
      AppConstant.shipping_title: "Free Shipping",
      AppConstant.packing_title: "Default Packaging",
      AppConstant.tax: '0',
      AppConstant.order_notes: orderNote.text ?? "",
      AppConstant.coupon_code:haveCouponCode ? couponData!=null ? couponData.data.code : "" : "",
      AppConstant.coupon_discount: couponData!=null ? couponData.data.price : "",
      AppConstant.dp: '0',
      AppConstant.vendor_shipping_id: '0',
      AppConstant.vendor_packing_id: '0',
      AppConstant.wallet_price: '0',
      AppConstant.affilate_user: ''/*user.affilateLink*/
    };
    await ApiClient2.Request(context,
        url: URL.Checkout,
        body: body,
        method: Method.POST,
        onSuccess: (data){
          cartProvider.addToCart.clear();
          prefs.setString(AppConstant.Share_Product, '[]');
          cartProvider.notifyListeners();
          goForPayment(data);
        },
        onError: (data){
        }
    );
    placeOrderLoading=false;
    notifyListeners();
  }

  void checkCoupon() async{
    couponData=null;
    couponLoading=true;
    couponMessage=null;
    notifyListeners();
    if(couponCode.text.isNotEmpty) {
      await ApiClient2.SimpleRequest(context,
          url: URL.Check_Coupon + couponCode.text,
          enableShowError: false,
          onSuccess: (data) {
            couponData=Coupon.fromJson(data);
            couponMessage=CouponStatus(message: '${couponData.data.price} ${couponData.data.type=='0' ? '%' : 'USD'} ${language.Discount}',status: true);
          },
          onError: (data) {
            couponMessage=CouponStatus(message: data[AppConstant.error],status: false);
          }
      );
    }
    else
      ErrorMessage(context,message:language.Please_enter_valid_coupon);
    couponLoading=false;
    notifyListeners();

  }
  void placeOrderConfirmation()async{
    var response= await showDialog(
        context: context,
        builder: (BuildContext context){
          return WillPopScope(
            onWillPop: back,
            child: DefaultDialog(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  Padding(
                    padding: EdgeInsets.all(Dimension.Padding).copyWith(top: 0),
                    child: Text(language.Do_you_want_to_place_your_order,style: Theme.of(context).textTheme.bodyText1,),
                  ),
                  DialogButton(
                      negativeButton: language.No,
                      positiveButton: language.Yes,
                      onTap: (state){
                        Navigator.of(context).pop(state);
                      }
                  )
                ],
              ),
              title: language.Order,
            ),
          );
        }
    );
    if(response!=null)if(response){
      submitOrder();
    }
  }


  void changeTab(int state) {
    try{
      if(state>0)
        tabs[pageController.page.toInt()+1].isSelected=true;
      else{
        tabs[pageController.page.toInt()-1].isSelected=true;
        tabs[pageController.page.toInt()].isSelected=false;
      }
      pageController.animateToPage(pageController.page.toInt()+state, duration: Duration(milliseconds: 250), curve: Curves.easeIn);
      currentPage+=state;
      notifyListeners();
    }catch(e){
      placeOrderConfirmation();
    }
  }

  void onPageChange(int value) {
    currentPage=value;
    notifyListeners();
  }

  void setShipping(String newValue) {
    selectedShipping=newValue;
    notifyListeners();
  }
  void changeCouponCodeState() {
    haveCouponCode=!haveCouponCode;
    notifyListeners();
  }

  keyboardConfiguration() {
    return KeyboardActionsConfig(
      keyboardSeparatorColor: Colors.transparent,
      actions: [
        TextFieldAction(focusNode: phoneFocus),
      ],
    );
  }

  void changeShipping(bool value) {
    enableShipping=value;
    notifyListeners();
  }

  void setCountry(Country newValue) {
    selectedCountry=newValue;
    notifyListeners();
  }

  void setShippingCountry(Country newValue) {
    selectedShippingCountry=newValue;
    notifyListeners();
  }

  String getTotalPrice({bool withCoupon=false}) {
    double total=0;
    for(int k=0;k<cartProvider.addToCart.length;k++){
      double price =double.parse(cartProvider.addToCart[k].currentPrice);
      if(cartProvider.addToCart[k].attributes!=null){
        for(int i=0;i<cartProvider.addToCart[k].attributes.attribute.length;i++){
          price+=double.parse(cartProvider.addToCart[k].attributes.attribute[i].prices[cartProvider.addToCart[k].attributes.attribute[i].selected.indexOf(true)]);
        }
      }
      if(cartProvider.addToCart[k].sizePrice.isNotEmpty){
        price+=double.parse(cartProvider.addToCart[k].sizePrice);
      }
      double discount=0;
      for(int i=0;i<cartProvider.addToCart[k].wholeSellQuantity.length;i++){
        if(cartProvider.addToCart[k].quantity>=int.parse(cartProvider.addToCart[k].wholeSellQuantity[i])){
          discount=double.parse(cartProvider.addToCart[k].wholeSellDiscount[i]);
        }
      }
      if(discount==0)
        total+=price*cartProvider.addToCart[k].quantity;
      else
        total+=((price*cartProvider.addToCart[k].quantity)/100)*(100-discount);
    }
    if(withCoupon)
      total= couponData!=null ? couponData.data.type=='0' ? (total*double.parse('0.${(100-double.parse(couponData.data.price))}')) : (total-double.parse(couponData.data.price)) : total;
    return total.toStringAsFixed(1);
  }

  Future<bool> back() {
  }

  void goForPayment(data) async{
    var response = await Navigator.of(context).pushNamed(PAYMENT_PAGE, arguments: {
      AppConstant.url:data[AppConstant.data],
    });
    Navigator.of(context).pop(true);
  }
}

class Tabs{
  String image,title;
  bool isSelected;

  Tabs({this.image, this.title, this.isSelected});
}

class CouponStatus{
  String message;
  bool status;

  CouponStatus({this.message, this.status});
}
