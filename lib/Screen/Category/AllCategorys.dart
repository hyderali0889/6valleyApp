import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geniouscart/Class/CategoryModel.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Packege/Expandable/Expandable.dart';
import 'package:geniouscart/Providers/MainPageProvider.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/Screen/Category/SubCategory.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/Widgets/CategorySkeleton.dart';
import 'package:geniouscart/Widgets/ImagePlaceHolder.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/SwipeRefresh.dart';
import 'package:provider/provider.dart';

class AllCategories extends StatefulWidget {
  @override
  _AllCategoriesState createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> with AutomaticKeepAliveClientMixin{
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  MainPageProvider mainPageProvider;

  @override
  Widget build(BuildContext context) {
    mainPageProvider=Provider.of<MainPageProvider>(context);
    return Scaffold(
      body: SwipeRefresh(
          controller: mainPageProvider.categoryRefreshController, 
          onRefresh: mainPageProvider.getAgainCategory,
          children: [
            mainPageProvider.categoryLoading ? CategorySkeleton(context: context) :
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: mainPageProvider.categoryModel.data.length,
                itemBuilder: (context,index){
                  return ListAnimation(
                      child: categoryItem(mainPageProvider.categoryModel.data[index],index,mainPageProvider.categoryClickController[index]),
                      index: index
                  );
                }
            ),
            Padding(
              padding: EdgeInsets.only(bottom: Dimension.Padding),
            )
          ]
      ),
    );
  }




}

class expendControll with ChangeNotifier{
  void refresh(){
    notifyListeners();
  }
}

class categoryItem extends StatefulWidget{

  CategoryData data;
  int index;
  ExpandableController controller;


  categoryItem(this.data, this.index,this.controller);

  @override
  _categoryItemState createState() => _categoryItemState();
}

class _categoryItemState extends State<categoryItem> with AutomaticKeepAliveClientMixin{

  expendControll controll;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<expendControll>(
      create: (_)=>expendControll(),
      child: Consumer<expendControll>(
        builder: (context,model,child){
          controll=model;
          return Container(
            child: ExpandablePanel(
              tapBodyToCollapse: false,
              header: categoryHeader(widget.data,widget.index),
              expanded: widget.controller.expanded ? SubCategory(widget.data) : Container(),
              tapHeaderToExpand: false,
              hasIcon: false,
              iconColor: Themes.Icon_Color,
              controller: widget.controller,
            ),
          );
        },
      ),
    );
  }

  Widget categoryHeader(CategoryData data,int index){
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(SHOW_PRODUCT,arguments: data.products);
      },
      child: Card(
        elevation: Dimension.card_elevation,
        color: Themes.White,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding,top: Dimension.Padding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: CachedNetworkImage(
                imageUrl: data.icon,
                fit: BoxFit.cover,
                width: 40,
                height: 40,
                progressIndicatorBuilder: (context, url, downloadProgress) =>ImagePlaceHolder(height: 40),
                errorWidget: (context, url, error) => ImagePlaceHolder(isError: true,height: 40),
              ),
            ),
            Expanded(
              child: Text(data.name,style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size_Big,fontWeight: Dimension.textBold),maxLines: 1,overflow: TextOverflow.ellipsis,),
            ),
            IconButton(
              onPressed: (){
                widget.controller.toggle();
                controll.refresh();
              },
              icon: Icon(widget.controller.expanded ? Icons.remove : Icons.add,color: Themes.Primary,),
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

