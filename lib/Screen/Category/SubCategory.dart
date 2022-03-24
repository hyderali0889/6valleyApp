import 'package:flutter/material.dart';
import 'package:geniouscart/Class/CategoryModel.dart';
import 'package:geniouscart/Class/SubCategoryModel.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Providers/SubCategoryProvider.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/Widgets/DividerList.dart';
import 'package:geniouscart/Widgets/EmptyView.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/SubCategorySkeleton.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class SubCategory extends StatefulWidget {

  CategoryData data;

  SubCategory(this.data);

  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> with AutomaticKeepAliveClientMixin{
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  SubCategoryProvider subCategoryProvider;



  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SubCategoryProvider>(
      create: (_)=>SubCategoryProvider()..setViewAndUrl(context, widget.data.subcategories),
      child: Consumer<SubCategoryProvider>(
        builder: (context,model,child){
          subCategoryProvider=model;
          return Container(
            color: Themes.Primary.withAlpha(15),
            margin: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(0),
              physics: NeverScrollableScrollPhysics(),
              children: [
                subCategoryProvider.Loading ? SubCategorySkeleton(context: context) :
                subCategoryProvider.subCategoryModel!=null ? subCategoryProvider.subCategoryModel.data.length>0 ? ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(0),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: subCategoryProvider.subCategoryModel.data.length,
                    itemBuilder: (context,index){
                      return ListAnimation(
                          child: subCategoryList(subCategoryProvider.subCategoryModel.data[index], index),
                          index: index
                      );
                    }
                ): subcategoryEmpty():subcategoryEmpty()
              ],
            ),
          );
        },
      ),
    );
  }

  subcategoryEmpty(){
    return Container(
      height: 150,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/sub-category.png',height: 100,),
          Text(language.No_Subcategory,style: TextStyle(color: Themes.Grey,fontSize: Dimension.Text_Size_Big,fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }

  Widget subCategoryList(SubCategoryData data,int index){
    return DividerList(
      child: InkWell(
        onTap: (){
          Navigator.of(context).pushNamed(SHOW_PRODUCT,arguments: data.products);
        },
        child: Container(
          margin: EdgeInsets.only(top: Dimension.Padding/2,left: 10,bottom: Dimension.Padding/2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(data.name,style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size_Small,fontWeight: Dimension.textBold),),
                ),
              ),
              IconButton(
                onPressed: (){

                },
                icon: Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
