import 'dart:async';
import 'dart:io';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:geniouscart/Class/Attributes.dart';
import 'package:geniouscart/Class/CategoryModel.dart';
import 'package:geniouscart/Class/ChildCategoryModel.dart';
import 'package:geniouscart/Class/SubCategoryModel.dart';
import 'package:geniouscart/Screen/Category/SubCategory.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/Api_Client2.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/KeyboardHandler.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';
import 'package:geniouscart/main.dart';
import 'package:random_string/random_string.dart';

class AddPhysicalProductProvider with ChangeNotifier{
  BuildContext context;
  bool Loading=false;

  bool categoryLoading=true,subCategoryLoading=false,childCategoryLoading=false;
  CategoryModel categoryModel=CategoryModel(data: List());
  SubCategoryModel subCategoryModel=SubCategoryModel(data: List());
  ChildCategoryModel childCategoryModel=ChildCategoryModel(data: List());

  TextEditingController name=TextEditingController();
  FocusNode priceFocus=FocusNode();
  TextEditingController sku=TextEditingController(text: randomString(20));
  String type=AppConstant.Create_Product_Type_Value[0];
  String product_type='normal';
  File image;

  GlobalKey<FormState> formKey=GlobalKey();

  CategoryData selectedCategory;
  Attributes categoryAttributes;
  Attributes subCategoryAttributes;
  Attributes childCategoryAttributes;
  SubCategoryData selectedSubCategory;
  ChildCategotyData selectedChildCategory;

  bool allowCondition=false;
  String condition=AppConstant.Product_Condition[0];

  bool allowProductMeasurement=false;
  String productMeasurement=AppConstant.Product_Measurement[0];
  TextEditingController customProductMeasurement=TextEditingController();
  bool isCustomProductMeasurement=false;

  bool allowEstimatedShippingTime=false;
  TextEditingController estimatedShippingTime=TextEditingController();

  bool allowProductSize=false;
  List<ProductSize> allProductSize=[ProductSize()];

  bool allowWholeSale=false;
  List<ProductWholeSale> allWholeSale=[ProductWholeSale()];

  bool allowColor=false;
  List<TextEditingController> allColor=[TextEditingController()];


  bool allowSEO=false;
  TextEditingController seoMetaTags=TextEditingController();
  TextEditingController seoDescription=TextEditingController();


  TextEditingController currentPrice=TextEditingController();
  TextEditingController prevPrice=TextEditingController();
  TextEditingController productStock=TextEditingController();
  TextEditingController productDescription=TextEditingController();
  TextEditingController productReturnPolicy=TextEditingController();
  TextEditingController youtubeVideoUrl=TextEditingController();
  TextEditingController tags=TextEditingController();



  List<FeatureTag> allFeatureTags=[FeatureTag()];




  static const Color guidePrimary = Color(0xFF6200EE);
  static const Color guidePrimaryVariant = Color(0xFF3700B3);
  static const Color guideSecondary = Color(0xFF03DAC6);
  static const Color guideSecondaryVariant = Color(0xFF018786);
  static const Color guideError = Color(0xFFB00020);
  static const Color guideErrorDark = Color(0xFFCF6679);
  static const Color blueBlues = Color(0xFF174378);

  final Map<ColorSwatch<Object>, String> colorsNameMap =
  <ColorSwatch<Object>, String>{
    ColorTools.createPrimarySwatch(guidePrimary): 'Guide Purple',
    ColorTools.createPrimarySwatch(guidePrimaryVariant): 'Guide Purple Variant',
    ColorTools.createAccentSwatch(guideSecondary): 'Guide Teal',
    ColorTools.createAccentSwatch(guideSecondaryVariant): 'Guide Teal Variant',
    ColorTools.createPrimarySwatch(guideError): 'Guide Error',
    ColorTools.createPrimarySwatch(guideErrorDark): 'Guide Error Dark',
    ColorTools.createPrimarySwatch(blueBlues): 'Blue blues',
  };


  @override
  void dispose() {
    super.dispose();
  }

  KeyboardActionsConfig configuration() {
    return KeyboardActionsConfig(
      keyboardSeparatorColor: Colors.transparent,
      actions: [
        TextFieldAction(focusNode: priceFocus),
      ],
    );
  }

  void setView(BuildContext context){
    this.context=context;
    getCategory();
  }



  Future getCategory() async {
    categoryLoading=true;
    notifyListeners();
    await ApiClient2.SimpleRequest(context,
        url: URL.Category,
        onSuccess: (data){
            categoryModel=CategoryModel.fromJson(data);
        },
        onError: (data){
        }
    );
    categoryLoading=false;
    notifyListeners();
  } 
  Future getSubCategory(String url) async {
    subCategoryLoading=true;
    selectedSubCategory=null;
    selectedChildCategory=null;
    subCategoryModel=SubCategoryModel(data: List());
    childCategoryModel=ChildCategoryModel(data: List());
    notifyListeners();
    await ApiClient2.SimpleRequest(context,
        url: url,
        onSuccess: (data){
            subCategoryModel=SubCategoryModel.fromJson(data);
        },
        onError: (data){
        }
    );
    subCategoryLoading=false;
    notifyListeners();
  }
  Future getChildCategory(String url) async {
    childCategoryLoading=true;
    selectedChildCategory=null;
    childCategoryModel=ChildCategoryModel(data: List());
    notifyListeners();
    await ApiClient2.SimpleRequest(context,
        url: url,
        onSuccess: (data){
            childCategoryModel=ChildCategoryModel.fromJson(data);
        },
        onError: (data){
        }
    );
    childCategoryLoading=false;
    notifyListeners();
  }
  Future<Attributes> getAttributes(String url) async {
    Attributes response;
    await ApiClient2.Request(context,
        url: url,
        onSuccess: (data){
          response= Attributes.fromJson(data);
        },
        onError: (data){
          response =null;
        }
    );
    return response;
  }
  Future uploadProduct() async {
    if(selectedCategory!=null) {
      Loading = true;
      notifyListeners();
      await ApiClient2.RequestWithFile(
          context,
          url: URL.Store_Product,
          body: {
            AppConstant.category_id: selectedCategory.id.toString(),
            AppConstant.name: name.text,
            //AppConstant.price: price.text,
            AppConstant.sku: sku.text,
            AppConstant.type: type,
            AppConstant.product_type: product_type,
          },
          fileKey: [AppConstant.photo],
          files: [image],
          enableShowError: false,
          onSuccess: (data) {
              SuccessMessage(context,message: language.Product_upload_successfully);
          },
          onError: (Map <String,dynamic> data) {
            if(data.containsKey(AppConstant.Error)){
              Map<String,dynamic> error=data[AppConstant.Error];
              if(error.containsKey(AppConstant.sku)){
                ErrorMessage(context,message: error[AppConstant.sku][0]);
              }
              else
                ErrorMessage(context,message: language.Something_went_wrong);
            }
            else
              ErrorMessage(context,message: language.Something_went_wrong);
          }
      );
      Loading = false;
      notifyListeners();
    }
    else
      ErrorMessage(context,message: language.Select_Category);
  }

  void setCategory(CategoryData newValue) async{
    bool needReload=false;
    if(selectedCategory==null) {
      needReload=true;
      selectedCategory = newValue;
    }
    else if(selectedCategory.name!=newValue.name){
      needReload=true;
      selectedCategory = newValue;
    }
    if(needReload){
      categoryAttributes=null;
      subCategoryAttributes=null;
      childCategoryAttributes=null;
      notifyListeners();
      getSubCategory(selectedCategory.subcategories);
      await getAttributes(URL.Get_Attribute+'${selectedCategory.id}&type=category').then((value) =>
        categoryAttributes=value
      );
      notifyListeners();
    }
  }

  void refresh() {
    notifyListeners();
  }

  void setSubCategory(SubCategoryData newValue)async {
    bool needReload=false;
    if(selectedSubCategory==null) {
      needReload=true;
      selectedSubCategory = newValue;
    }
    else if(selectedSubCategory.name!=newValue.name){
      needReload=true;
      selectedSubCategory = newValue;
    }
    if(needReload){
      subCategoryAttributes=null;
      childCategoryAttributes=null;
      notifyListeners();
      getChildCategory(selectedSubCategory.childCategories);
      await getAttributes(URL.Get_Attribute+'${selectedSubCategory.id}&type=subcategory').then((value) =>
        subCategoryAttributes=value
      );
      notifyListeners();
    }
  }

  void setChildCategory(ChildCategotyData newValue)async {
    bool needReload=false;
    if(selectedChildCategory==null) {
      needReload=true;
      selectedChildCategory = newValue;
    }
    else if(selectedChildCategory.name!=newValue.name){
      needReload=true;
      selectedChildCategory = newValue;
    }
    if(needReload){
      childCategoryAttributes=null;
      notifyListeners();
      await getAttributes(URL.Get_Attribute+'${selectedChildCategory.id}&type=childcategory').then((value) =>
        childCategoryAttributes=value
      );
      notifyListeners();
    }
  }

  void changeCondition(bool value) {
    allowCondition=value;
    notifyListeners();
  }
  void setCondition(String value) {
    condition=value;
    notifyListeners();
  }

  void changeProductMeasurement(bool value) {
    allowProductMeasurement=value;
    notifyListeners();
  }

  void setProductMeasurement(String value) {
    productMeasurement=value;
    if(value==AppConstant.Product_Measurement[AppConstant.Product_Measurement.length-1])
      isCustomProductMeasurement=true;
    else
      isCustomProductMeasurement=false;
    notifyListeners();
  }


  void changeEstimatedShippingTime(bool value) {
    allowEstimatedShippingTime=value;
    notifyListeners();
  }

  void changeProductSize(bool value) {
    allowProductSize=value;
    notifyListeners();
  }

  void addMoreProductSize() {
    allProductSize.add(ProductSize());
    notifyListeners();
  }

  void removeProductSize(int index) {
    allProductSize.removeAt(index);
    notifyListeners();
  }


  void changeProductWholeSale(bool value) {
    allowWholeSale=value;
    notifyListeners();
  }

  void addMoreWholeSale() {
    allWholeSale.add(ProductWholeSale());
    notifyListeners();
  }

  void removeWholeSale(int index) {
    allWholeSale.removeAt(index);
    notifyListeners();
  }

  void changeColorEnable(bool value) {
    allowColor=value;
    notifyListeners();
  }

  void addMoreColor() {
    allColor.add(TextEditingController());
    notifyListeners();
  }

  void removeColor(int index) {
    allColor.removeAt(index);
    notifyListeners();
  }

  void setColor(int index,Color color) {
    allColor[index].text='#${color.value.toRadixString(16).substring(2, 8)}';
    notifyListeners();
  }

  void setFeatureColor(int index,Color color) {
    allFeatureTags[index].tagColor.text='#${color.value.toRadixString(16).substring(2, 8)}';
    notifyListeners();
  }


  void changeProductSEO(bool value) {
    allowSEO=value;
    notifyListeners();
  }

  void addMoreFeatureTags() {
    allFeatureTags.add(FeatureTag());
    notifyListeners();
  }

  void removeFeatureColor(int index) {
    allFeatureTags.removeAt(index);
    notifyListeners();
  }
}

class ProductSize{
  TextEditingController sizeName=TextEditingController();
  TextEditingController sizeQuantity=TextEditingController(text: '1');
  TextEditingController sizePrice=TextEditingController();
}

class ProductWholeSale{
  TextEditingController salePercentage=TextEditingController();
  TextEditingController saleQuantity=TextEditingController();
}

class FeatureTag{
  TextEditingController keyword=TextEditingController();
  TextEditingController tagColor=TextEditingController();
}

