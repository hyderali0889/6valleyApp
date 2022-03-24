import 'dart:async';
import 'dart:io';
import 'dart:ui';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:geniouscart/Class/Attributes.dart';
import 'package:geniouscart/Class/CategoryModel.dart';
import 'package:geniouscart/Class/ChildCategoryModel.dart';
import 'package:geniouscart/Class/SubCategoryModel.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Packege/Loading_Button/Loading_Button.dart';
import 'package:geniouscart/Providers/AddPhysicalProductProvider.dart';
import 'package:geniouscart/Providers/SplashProvider.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/Widgets/BackButton.dart';
import 'package:geniouscart/Widgets/CircularProgress.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/DefaultDialog.dart';
import 'package:geniouscart/Widgets/DefaultTextField.dart';
import 'package:geniouscart/Widgets/GetImage.dart';
import 'package:geniouscart/Widgets/ImagePlaceHolder.dart';
import 'package:geniouscart/Widgets/KeyboardHandler.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';



class AddPhysicalProduct extends StatefulWidget {
  @override
  _AddPhysicalProductState createState() => _AddPhysicalProductState();
}

class _AddPhysicalProductState extends State<AddPhysicalProduct> with TickerProviderStateMixin {
  AddPhysicalProductProvider provider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddPhysicalProductProvider>(
      create: (_) => AddPhysicalProductProvider()..setView(context),
      child: Consumer<AddPhysicalProductProvider>(
        builder: (context, model, child) {
          provider = model;
          return Scaffold(
            appBar: DefaultAppbar(context: context,title: language.Create_Product_Types[0]),
            body: KeyboardHandler(
              config: provider.configuration(),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(child: Form(key: provider.formKey,child: mainView())),
                  Positioned(
                    bottom: Dimension.Padding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoadingButton(
                          isLoading: provider.Loading,
                          onPressed: (){
                            if(provider.formKey.currentState.validate()){
                              /*if(provider.image!=null){
                                provider.uploadProduct();
                              }
                              else
                                ErrorMessage(context,message: language.Image_Upload);*/
                            }
                          },
                          backgroundColor: Themes.Primary,
                          defaultStyle: true,
                          child: Container(
                            width: mainWidth-Dimension.Size_100,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding),
                            child: Text(language.Create_Product,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.White),),
                          ),
                        ),
                      ],
                    )
                  )
                ],
              )
            ),
          );
        },
      ),
    );
  }

  Widget mainView() {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: [
        Container(
          color: Themes.White,
          margin: EdgeInsets.all(Dimension.Padding).copyWith(bottom: 0),
          child: Row(
            children: [
              Visibility(
                  visible: provider.categoryLoading,
                  child: Padding(
                    padding: EdgeInsets.only(left: Dimension.Size_10),
                    child: CircularProgress(),
                  )
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: Dimension.Size_10,left: Dimension.Size_10),
                  child: DropdownButton<CategoryData>(
                    value: provider.selectedCategory,
                    underline: Container(),
                    isExpanded: true,
                    elevation: 5,
                    onChanged: (CategoryData newValue) {
                      provider.setCategory(newValue);
                    },
                    items: provider.categoryModel.data
                        .map<DropdownMenuItem<CategoryData>>((CategoryData value) {
                      return DropdownMenuItem<CategoryData>(
                        value: value,
                        child: Text(value.name,style: Theme.of(context).textTheme.bodyText1),
                      );
                    }).toList(),
                    hint: Text(language.Category,style: Theme.of(context).textTheme.bodyText1.copyWith(color: Themes.Grey),),
                  ),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: provider.selectedCategory!=null,
          child: Container(
            color: Themes.White,
            margin: EdgeInsets.all(Dimension.Padding).copyWith(bottom: 0),
            child: Row(
              children: [
                Visibility(
                    visible: provider.subCategoryLoading,
                    child: Padding(
                      padding: EdgeInsets.only(left: Dimension.Size_10),
                      child: CircularProgress(),
                    )
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: Dimension.Size_10,left: Dimension.Size_10),
                    child: DropdownButton<SubCategoryData>(
                      value: provider.selectedSubCategory,
                      underline: Container(),
                      isExpanded: true,
                      elevation: 5,
                      onChanged: (SubCategoryData newValue) {
                        provider.setSubCategory(newValue);
                      },
                      items: provider.subCategoryModel.data
                          .map<DropdownMenuItem<SubCategoryData>>((SubCategoryData value) {
                        return DropdownMenuItem<SubCategoryData>(
                          value: value,
                          child: Text(value.name,style: Theme.of(context).textTheme.bodyText1),
                        );
                      }).toList(),
                      hint: Text(language.Sub_Category,style: Theme.of(context).textTheme.bodyText1.copyWith(color: Themes.Grey),),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: provider.selectedSubCategory!=null,
          child: Container(
            color: Themes.White,
            margin: EdgeInsets.all(Dimension.Padding).copyWith(bottom: 0),
            child: Row(
              children: [
                Visibility(
                    visible: provider.childCategoryLoading,
                    child: Padding(
                      padding: EdgeInsets.only(left: Dimension.Size_10),
                      child: CircularProgress(),
                    )
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: Dimension.Size_10,left: Dimension.Size_10),
                    child: DropdownButton<ChildCategotyData>(
                      value: provider.selectedChildCategory,
                      underline: Container(),
                      isExpanded: true,
                      elevation: 5,
                      onChanged: (ChildCategotyData newValue) {
                        provider.setChildCategory(newValue);
                      },
                      items: provider.childCategoryModel.data
                          .map<DropdownMenuItem<ChildCategotyData>>((ChildCategotyData value) {
                        return DropdownMenuItem<ChildCategotyData>(
                          value: value,
                          child: Text(value.name,style: Theme.of(context).textTheme.bodyText1),
                        );
                      }).toList(),
                      hint: Text(language.Child_Category,style: Theme.of(context).textTheme.bodyText1.copyWith(color: Themes.Grey),),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            Checkbox(
              value: provider.allowCondition,
              onChanged: provider.changeCondition,
            ),
            Text(language.Allow_Condition,style: Theme.of(context).textTheme.headline1.copyWith(fontSize: Dimension.Text_Size_Small),),
          ],
        ),
        Visibility(
          visible: provider.allowCondition,
          child: Container(
            color: Themes.White,
            margin: EdgeInsets.all(Dimension.Padding).copyWith(top: 0),
            padding: EdgeInsets.only(right: Dimension.Size_10,left: Dimension.Size_10),
            child: DropdownButton<String>(
              value: provider.condition,
              underline: Container(),
              isExpanded: true,
              elevation: 5,
              onChanged: (String newValue) {
                provider.setCondition(newValue);
              },
              items: AppConstant.Product_Condition
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,style: Theme.of(context).textTheme.bodyText1),
                );
              }).toList(),
              hint: Text(language.Choose,style: Theme.of(context).textTheme.bodyText1.copyWith(color: Themes.Grey),),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(Dimension.Padding).copyWith(top: 0),
          child: DefaultTextField(
            controller: provider.name,
            label: language.Product_Name
          ),
        ),
        Padding(
          padding: EdgeInsets.all(Dimension.Padding).copyWith(top: 0),
          child: DefaultTextField(
            controller: provider.sku,
            label: language.Sku
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding),
          child: Text(language.Image_Upload,style: Theme.of(context).textTheme.headline1,),
        ),
        SizedBox(height: Dimension.Size_5,),
        Container(
          margin: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding),
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(Dimension.Size_10),
              border: Border.all(color: Themes.Text_Color)
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(Dimension.Size_10),
                child: provider.image==null ? Image.asset('assets/images/empty.png') :
                Image.file(provider.image),
              ),
              Positioned(
                  right: Dimension.Padding,
                  bottom: Dimension.Padding,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Themes.White,
                        borderRadius: BorderRadius.circular(Dimension.Size_10),
                        border: Border.all(color: Themes.Text_Color)
                    ),
                    child: IconButton(
                      onPressed: ()async{
                        File image=await getImage(context);
                        if(image!=null){
                          provider.image=image;
                          provider.refresh();
                        }
                      },
                      icon: Icon(Icons.add_a_photo_outlined,color: Themes.Primary,),
                    ),
                  )
              )
            ],
          ),
        ),Row(
          children: [
            Checkbox(
              value: provider.allowProductMeasurement,
              onChanged: provider.changeProductMeasurement,
            ),
            Text(language.Allow_Product_Measurement,style: Theme.of(context).textTheme.headline1.copyWith(fontSize: Dimension.Text_Size_Small),),
          ],
        ),
        Visibility(
          visible: provider.allowProductMeasurement,
          child: Container(
            margin: EdgeInsets.all(Dimension.Padding).copyWith(top: 0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: Themes.White,
                    padding: EdgeInsets.only(right: Dimension.Size_10,left: Dimension.Size_10),
                    child: DropdownButton<String>(
                      value: provider.productMeasurement,
                      underline: Container(),
                      isExpanded: true,
                      elevation: 5,
                      onChanged: (String newValue) {
                        provider.setProductMeasurement(newValue);
                      },
                      items: AppConstant.Product_Measurement
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,style: Theme.of(context).textTheme.bodyText1),
                        );
                      }).toList(),
                      hint: Text(language.Choose,style: Theme.of(context).textTheme.bodyText1.copyWith(color: Themes.Grey),),
                    ),
                  ),
                ),
                Visibility(
                  visible: provider.isCustomProductMeasurement,
                  child: Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left:Dimension.Size_10),
                      child: DefaultTextField(
                          controller: provider.customProductMeasurement,
                          label: language.Enter_Unit
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Row(
          children: [
            Checkbox(
              value: provider.allowEstimatedShippingTime,
              onChanged: provider.changeEstimatedShippingTime,
            ),
            Text(language.Allow_Estimated_Shipping_Time,style: Theme.of(context).textTheme.headline1.copyWith(fontSize: Dimension.Text_Size_Small),),
          ],
        ),
        Visibility(
          visible: provider.allowEstimatedShippingTime,
          child: Padding(
            padding: EdgeInsets.only(left:Dimension.Padding,right: Dimension.Padding),
            child: DefaultTextField(
                controller: provider.estimatedShippingTime,
                label: language.Product_Estimated_Shipping_Time
            ),
          ),
        ),
        Row(
          children: [
            Checkbox(
              value: provider.allowProductSize,
              onChanged: provider.changeProductSize,
            ),
            Text(language.Allow_Product_Sizes,style: Theme.of(context).textTheme.headline1.copyWith(fontSize: Dimension.Text_Size_Small),),
          ],
        ),
        Visibility(
          visible: provider.allowProductSize,
          child: ListView(
            padding: EdgeInsets.only(left:Dimension.Padding,right: Dimension.Padding),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: provider.allProductSize.length,
                itemBuilder: (context,index){
                  return ListAnimation(
                    child: productSizeInput(index),
                    index: index
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton.icon(
                    onPressed: ()=>provider.addMoreProductSize(),
                    icon: Icon(Icons.add_circle_outline_outlined,color: Themes.White,),
                    color: Themes.Primary,
                    label: Container(height:Dimension.Size_44,alignment:Alignment.center,child: Text(language.Add_More_Field,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.White),))
                  ),
                ],
              )
            ],
          ),
        ),
        Row(
          children: [
            Checkbox(
              value: provider.allowColor,
              onChanged: provider.changeColorEnable,
            ),
            Text(language.Allow_Product_Colors,style: Theme.of(context).textTheme.headline1.copyWith(fontSize: Dimension.Text_Size_Small),),
          ],
        ),
        Visibility(
          visible: provider.allowColor,
          child: ListView(
            padding: EdgeInsets.only(left:Dimension.Padding,right: Dimension.Padding),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: provider.allColor.length,
                itemBuilder: (context,index){
                  return ListAnimation(
                    child: productColor(index),
                    index: index
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton.icon(
                    onPressed: ()=>provider.addMoreColor(),
                    icon: Icon(Icons.add_circle_outline_outlined,color: Themes.White,),
                    color: Themes.Primary,
                    label: Container(height:Dimension.Size_44,alignment:Alignment.center,child: Text(language.Add_More_Color,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.White),))
                  ),
                ],
              )
            ],
          ),
        ),
        Row(
          children: [
            Checkbox(
              value: provider.allowWholeSale,
              onChanged: provider.changeProductWholeSale,
            ),
            Text(language.Allow_Product_Whole_Sell,style: Theme.of(context).textTheme.headline1.copyWith(fontSize: Dimension.Text_Size_Small),),
          ],
        ),
        Visibility(
          visible: provider.allowWholeSale,
          child: ListView(
            padding: EdgeInsets.only(left:Dimension.Padding,right: Dimension.Padding),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: provider.allWholeSale.length,
                itemBuilder: (context,index){
                  return ListAnimation(
                      child: productWholeSaleInput(index),
                      index: index
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton.icon(
                      onPressed: ()=>provider.addMoreWholeSale(),
                      icon: Icon(Icons.add_circle_outline_outlined,color: Themes.White,),
                      color: Themes.Primary,
                      label: Container(height:Dimension.Size_44,alignment:Alignment.center,child: Text(language.Add_More_Field,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.White),))
                  ),
                ],
              )
            ],
          ),
        ),
        Row(
          children: [
            Checkbox(
              value: provider.allowSEO,
              onChanged: provider.changeProductSEO,
            ),
            Text(language.Allow_Product_SEO,style: Theme.of(context).textTheme.headline1.copyWith(fontSize: Dimension.Text_Size_Small),),
          ],
        ),
        Visibility(
          visible: provider.allowSEO,
          child: productSEO(),
        ),
        Padding(
          padding: EdgeInsets.only(top:Dimension.Padding,left: Dimension.Padding,right: Dimension.Padding),
          child: DefaultTextField(
              controller: provider.currentPrice,
              label: language.Product_Current_Price,
              hint: language.Product_Current_Hint,
              textInputType: TextInputType.number
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top:Dimension.Size_10,left: Dimension.Padding,right: Dimension.Padding),
          child: DefaultTextField(
              controller: provider.prevPrice,
              label: language.Product_Previous_Price,
              hint: language.Optional,
              enableValidation: false,
              textInputType: TextInputType.number
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top:Dimension.Size_10,left: Dimension.Padding,right: Dimension.Padding),
          child: DefaultTextField(
              controller: provider.productStock,
              label: language.Product_Stock,
              hint: language.Product_Stock_Hint,
              textInputType: TextInputType.number
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top:Dimension.Size_10,left: Dimension.Padding,right: Dimension.Padding),
          child: DefaultTextField(
              controller: provider.productDescription,
              label: language.Product_Description,
              maxLine: 4
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top:Dimension.Size_10,left: Dimension.Padding,right: Dimension.Padding),
          child: DefaultTextField(
              controller: provider.productReturnPolicy,
              label: language.Product_Buy_Return_Policy,
              maxLine: 4
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top:Dimension.Size_10,left: Dimension.Padding,right: Dimension.Padding),
          child: DefaultTextField(
              controller: provider.youtubeVideoUrl,
              label: language.Youtube_Video_URL,
              hint: language.Optional,
              enableValidation: false
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top:Dimension.Size_10,left: Dimension.Padding,right: Dimension.Padding),
          child: DefaultTextField(
              controller: provider.tags,
              label: language.Tags
          ),
        ),
        SizedBox(height: Dimension.Padding,),
        provider.categoryAttributes!=null ?
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: provider.categoryAttributes.data.length,
            itemBuilder: (context,index){
              return ListAnimation(
                  child: attributeView(
                    provider.categoryAttributes.data[index],index,
                    onChange: (pos){
                      provider.categoryAttributes.data[index].selectedOption=pos;
                      provider.refresh();
                    }
                  ),
                  index: index
              );
            },
          ) : Container(),
        SizedBox(height: provider.subCategoryAttributes!=null ? Dimension.Padding : 0,),
        provider.subCategoryAttributes!=null ?
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: provider.subCategoryAttributes.data.length,
          itemBuilder: (context,index){
            return ListAnimation(
                child: attributeView(
                    provider.subCategoryAttributes.data[index],index,
                    onChange: (pos){
                      provider.subCategoryAttributes.data[index].selectedOption=pos;
                      provider.refresh();
                    }
                ),
                index: index
            );
          },
        ) : Container(),
        SizedBox(height: provider.childCategoryAttributes!=null ? Dimension.Padding : 0,),
        provider.childCategoryAttributes!=null ?
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: provider.childCategoryAttributes.data.length,
          itemBuilder: (context,index){
            return ListAnimation(
                child: attributeView(
                    provider.childCategoryAttributes.data[index],index,
                    onChange: (pos){
                      provider.childCategoryAttributes.data[index].selectedOption=pos;
                      provider.refresh();
                    }
                ),
                index: index
            );
          },
        ) : Container(),
        Padding(
          padding: EdgeInsets.only(left: Dimension.Padding,bottom: Dimension.Size_10),
          child: Text(language.Feature_Tags,style: Theme.of(context).textTheme.headline1,),
        ),
        ListView(
          padding: EdgeInsets.only(left:Dimension.Padding,right: Dimension.Padding),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: provider.allFeatureTags.length,
              itemBuilder: (context,index){
                return ListAnimation(
                    child: featureTagItem(index),
                    index: index
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton.icon(
                    onPressed: ()=>provider.addMoreFeatureTags(),
                    icon: Icon(Icons.add_circle_outline_outlined,color: Themes.White,),
                    color: Themes.Primary,
                    label: Container(height:Dimension.Size_44,alignment:Alignment.center,child: Text(language.Add_More_Field,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.White),))
                ),
              ],
            )
          ],
        ),
        SizedBox(height: Dimension.Size_70,),
      ],
    );
  }

  Widget attributeView(AttributeData data, int index,{Function(int) onChange}) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        Padding(
          padding: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding),
          child: Text(data.attribute.name,style: Theme.of(context).textTheme.headline1,),
        ),
        SizedBox(height: Dimension.Size_10,),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: data.options.length,
          itemBuilder: (context,position){
            return ListAnimation(
                child: optionView(
                  data.options[position],data,position,
                  onChange: onChange
                ),
                index: index
            );
          },
        )
      ],
    );
  }

  Widget optionView(Options option, AttributeData data,int position,{Function(int) onChange}) {
    return Padding(
      padding:  EdgeInsets.only(bottom: Dimension.Size_10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Checkbox(
                value: data.selectedOption==position,
                onChanged: (value) {
                  onChange(position);
                },
              ),
              Text(option.name,style: Theme.of(context).textTheme.bodyText1,),
            ],
          ),
          SizedBox(height: Dimension.Size_10,),
          Container(
            margin: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding),
            child: DefaultTextField(
                controller: null,
                hint: language.Additional_Price,
                textInputType: TextInputType.number,
                enableValidation: data.selectedOption==position
            ),
          ),
        ],
      ),
    );
  }

  Widget productSizeInput(int index) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimension.Size_10),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            padding: EdgeInsets.all(Dimension.Size_10),
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(width: 2,color: Themes.TexftFieldBorder),
                borderRadius: BorderRadius.circular(5)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextField(
                    controller: provider.allProductSize[index].sizeName,
                    label: language.Size_Name,
                    hint: language.Size_Name_Hint
                ),
                SizedBox(height: Dimension.Size_10,),
                DefaultTextField(
                    controller: provider.allProductSize[index].sizeQuantity,
                    label: language.Size_Qty,
                    hint: language.Size_Qty_Hint,
                    textInputType: TextInputType.number
                ),
                SizedBox(height: Dimension.Size_10,),
                DefaultTextField(
                    controller: provider.allProductSize[index].sizePrice,
                    label: language.Size_Price,
                    hint: language.Size_Price_Hint,
                    textInputType: TextInputType.number
                ),
              ],
            ),
          ),
          Visibility(
            visible: index!=0,
            child: Positioned(
                right: -Dimension.Size_20,
                top: -Dimension.Size_20,
                child: IconButton(
                  icon: Icon(Icons.cancel,color: Themes.Red,),
                  onPressed: ()=>provider.removeProductSize(index),
                )
            ),
          )
        ],
      ),
    );
  }


  Widget productWholeSaleInput(int index) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimension.Size_10),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            padding: EdgeInsets.all(Dimension.Size_10),
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(width: 2,color: Themes.TexftFieldBorder),
                borderRadius: BorderRadius.circular(5)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextField(
                    controller: provider.allWholeSale[index].saleQuantity,
                    label: language.Enter_Quantity,
                    textInputType: TextInputType.number
                ),
                SizedBox(height: Dimension.Size_10,),
                DefaultTextField(
                    controller: provider.allWholeSale[index].salePercentage,
                    label: language.Enter_Discount_Percentage,
                    textInputType: TextInputType.number
                ),
              ],
            ),
          ),
          Visibility(
            visible: index!=0,
            child: Positioned(
                right: -Dimension.Size_20,
                top: -Dimension.Size_20,
                child: IconButton(
                  icon: Icon(Icons.cancel,color: Themes.Red,),
                  onPressed: ()=>provider.removeWholeSale(index),
                )
            ),
          )
        ],
      ),
    );
  }


  Widget productSEO() {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimension.Size_10,left: Dimension.Padding,right: Dimension.Padding),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            padding: EdgeInsets.all(Dimension.Size_10),
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(width: 2,color: Themes.TexftFieldBorder),
                borderRadius: BorderRadius.circular(5)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextField(
                    controller: provider.seoMetaTags,
                    label: language.Meta_Tags,
                ),
                SizedBox(height: Dimension.Size_10,),
                DefaultTextField(
                    controller: provider.seoDescription,
                    label: language.Meta_Description,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget productColor(int index) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimension.Size_10),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            padding: EdgeInsets.all(Dimension.Size_10),
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(width: 2,color: Themes.TexftFieldBorder),
                borderRadius: BorderRadius.circular(5)
            ),
            child: DefaultTextField(
                controller: provider.allColor[index],
                label: language.Product_Colors,
                hint: language.Product_Colors_Hint,
                onTap: (){
                    colorPickerDialog(
                        colorCode: provider.allColor[index].text,
                        onChange: (Color color)=>provider.setColor(index,color)
                    );
                },
              suffixIcon: provider.allColor[index].text.isNotEmpty ?
              SizedBox(
                height: Dimension.Size_34,
                width: Dimension.Size_34,
                child: Row(
                  children: [
                    Container(
                      height: Dimension.Size_34,
                      width: Dimension.Size_34,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Themes.getColorFromColorCode(provider.allColor[index].text)
                      ),
                    ),
                  ],
                ),
              ) : null
            ),
          ),
          Visibility(
            visible: index!=0,
            child: Positioned(
                right: -Dimension.Size_20,
                top: -Dimension.Size_20,
                child: IconButton(
                  icon: Icon(Icons.cancel,color: Themes.Red,),
                  onPressed: ()=>provider.removeColor(index),
                )
            ),
          )
        ],
      ),
    );
  }

  Widget featureTagItem(int index) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimension.Size_10),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            padding: EdgeInsets.all(Dimension.Size_10),
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(width: 2,color: Themes.TexftFieldBorder),
                borderRadius: BorderRadius.circular(5)
            ),
            child: Column(
              children: [
                DefaultTextField(
                  controller: provider.allFeatureTags[index].keyword,
                  label: language.Enter_Your_Keyword,
                ),
                SizedBox(height: Dimension.Size_10,),
                DefaultTextField(
                    controller: provider.allFeatureTags[index].tagColor,
                    label: language.Color,
                    onTap: (){
                        colorPickerDialog(
                            colorCode: provider.allFeatureTags[index].tagColor.text,
                            onChange: (Color color)=>provider.setFeatureColor(index,color)
                        );
                    },
                  suffixIcon: provider.allFeatureTags[index].tagColor.text.isNotEmpty ?
                  SizedBox(
                    height: Dimension.Size_34,
                    width: Dimension.Size_34,
                    child: Row(
                      children: [
                        Container(
                          height: Dimension.Size_34,
                          width: Dimension.Size_34,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Themes.getColorFromColorCode(provider.allFeatureTags[index].tagColor.text)
                          ),
                        ),
                      ],
                    ),
                  ) : null
                ),
              ],
            ),
          ),
          Visibility(
            visible: index!=0,
            child: Positioned(
                right: -Dimension.Size_20,
                top: -Dimension.Size_20,
                child: IconButton(
                  icon: Icon(Icons.cancel,color: Themes.Red,),
                  onPressed: ()=>provider.removeFeatureColor(index),
                )
            ),
          )
        ],
      ),
    );
  }

  Future<bool> colorPickerDialog({String colorCode,Function(Color) onChange}) async {
    return ColorPicker(
      color: colorCode.isNotEmpty ? Themes.getColorFromColorCode(colorCode) : Colors.blue,
      onColorChanged: (Color color) =>onChange(color),
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      materialNameTextStyle: Theme.of(context).textTheme.caption,
      colorNameTextStyle: Theme.of(context).textTheme.caption,
      colorCodeTextStyle: Theme.of(context).textTheme.caption,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
        ColorPickerType.wheel: true,
        ColorPickerType.primary: true,
      },
      customColorSwatchesAndNames: provider.colorsNameMap,
    ).showPickerDialog(
      context,
      constraints: BoxConstraints(minHeight: mainHeight*0.5, minWidth: mainWidth*0.7, maxWidth: mainWidth*0.8),
    );
  }

}
