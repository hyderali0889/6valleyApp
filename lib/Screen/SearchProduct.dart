
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:geniouscart/Class/Product.dart';
import 'package:geniouscart/Class/SearchResult.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Providers/SearchFilterProvider.dart';
import 'package:geniouscart/Providers/SearchProductProvider.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/Widgets/CircularProgress.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/DefaultDialog.dart';
import 'package:geniouscart/Widgets/DefaultTextField.dart';
import 'package:geniouscart/Widgets/DialogButton.dart';
import 'package:geniouscart/Widgets/DividerList.dart';
import 'package:geniouscart/Widgets/EmptyView.dart';
import 'package:geniouscart/Widgets/GridAnimation.dart';
import 'package:geniouscart/Widgets/HeroAnimation.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';

import 'package:geniouscart/Widgets/RatingVIew.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';


class SearchProduct extends StatefulWidget {
  @override
  _SearchProductState createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> with AutomaticKeepAliveClientMixin{

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  SearchProductProvider searchProductProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    searchProductProvider=Provider.of<SearchProductProvider>(context)..setView(context);
    return Scaffold(
      appBar: DefaultAppbar(context: context,title: language.Search_Product,
          action: IconButton(
            onPressed: ()=>showFilterDialog(),
            icon: Icon(Icons.filter_list,color: Themes.Icon_Color,),
          )
      ),
      body: Container(
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Container(
              margin: EdgeInsets.only(top: 70),
              child: searchProductProvider.searchLoading ? Container()
                  : searchProductProvider.searchResult!=null  ? searchProductProvider.searchResult.data.length >0 ?
              StaggeredGridView.countBuilder(
                primary: false,
                itemCount: searchProductProvider.searchResult.data.length,
                padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                crossAxisCount: 4,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                itemBuilder: (context, index) {
                  return GridAnimation(
                      index: index,
                      child: searchItem(searchProductProvider.searchResult.data[index],index)
                  );
                } ,
                staggeredTileBuilder: (index) =>  StaggeredTile.fit(2),
              ): EmptyView(image :'assets/images/empty-box.png',message: Text(language.Product_Not_Found,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.Grey),)):
              EmptyView(image :'assets/images/empty-box.png',message: Text(language.Product_Not_Found,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.Grey))),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size,fontWeight: Dimension.textNormal),
                controller: searchProductProvider.search,
                //focusNode: focusNode,
                keyboardType: TextInputType.text,
                cursorColor: Themes.Primary,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10,right: 10),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2,color: Themes.TexftFieldBorder),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2,color: Themes.Primary),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  hintText: language.Search,
                  prefixIcon: HeroAnimation(
                      tag: AppConstant.HeroTagSearch,
                      child: Icon(Icons.search,color: Themes.Grey,)
                  ),
                  suffixIcon: searchProductProvider.searchLoading ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Themes.Primary)),
                      ),
                    ],
                  ) : Container(height: 0,width: 0,),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  Widget searchItem(SearchData date,int index){
    return GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed(PRODUCT_DETAILS,arguments: ProductData.fromJson(date.toJson()));
        },
        child: Card(
          elevation: Dimension.card_elevation,
          clipBehavior: Clip.antiAlias,
          color: Themes.White,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(date.thumbnail,height: 120,fit: BoxFit.cover,),
                Container(
                  padding: EdgeInsets.all(Dimension.Size_10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(date.title,style: TextStyle(fontSize: Dimension.Text_Size_Small,color: Themes.Text_Color,fontWeight: Dimension.textMedium),maxLines: 2,overflow: TextOverflow.ellipsis,),
                      Row(
                        children: [
                          Text(actualPrice(date.currentPrice),style: TextStyle(fontSize: Dimension.Text_Size,color: Themes.Text_Color,fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(actualPrice(date.previousPrice),style: TextStyle(fontSize: Dimension.Text_Size_Small,color: Themes.Grey,fontWeight: FontWeight.normal,decoration: TextDecoration.lineThrough),),
                          ),
                        ],
                      ),
                      RatingView(rating: date.rating.toDouble())
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
  void showFilterDialog(){
    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: AppConstant.AnimationDelay),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return FilterData(max: searchProductProvider.max,min: searchProductProvider.min,selectedSort: searchProductProvider.selectedSort,returnData: filterReturn,);
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, -1),
            end: Offset.zero,
          ).animate(anim1),
          child: child,
        );
      },
    );
  }
  void filterReturn(var data){
    searchProductProvider.setData(data[AppConstant.min], data[AppConstant.max], data[AppConstant.sort]);
  }


}
class FilterData extends StatefulWidget {
  Function returnData;
  String selectedSort;
  double min,max;

  FilterData({this.returnData, this.selectedSort, this.min, this.max});

  @override
  _FilterDataState createState() => _FilterDataState();
}

class _FilterDataState extends State<FilterData> {

  SearchFilterProvider searchFilterProvider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchFilterProvider>(
      create: (_)=>SearchFilterProvider()..setData(widget.min,widget.max,widget.selectedSort),
      child: Consumer<SearchFilterProvider>(
        builder: (context,model,child){
          searchFilterProvider=model;
          return Align(
            alignment: Alignment.topCenter,
            child: Material(
              color: Themes.Primary_Lite,
              type: MaterialType.transparency,
              child: Container(
                padding: EdgeInsets.only(top: paddingTop),
                color: Colors.white,
                child: ListView(
                  padding: EdgeInsets.only(left:Dimension.Padding,right: Dimension.Padding,top: Dimension.Padding),
                  shrinkWrap: true,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(child: Text(language.Filter_By,style: TextStyle(color: Themes.Primary,fontSize: Dimension.Text_Size,fontWeight: FontWeight.bold),)),
                        Icon(Icons.loop,color: Themes.Primary,)
                      ],
                    ),
                    Container(
                      color: Themes.Primary.withAlpha(15),
                      padding: EdgeInsets.only(left: 10,right: 10),
                      margin: EdgeInsets.only(top: 10),
                      child: DropdownButton<String>(
                        value: searchFilterProvider.selectedSort,
                        isExpanded: true,
                        style: Theme.of(context).textTheme.bodyText1,
                        underline: Container(),
                        onChanged: (String newValue) {
                          searchFilterProvider.selectSort(newValue);
                        },
                        items: language.Product_SortList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,style: Theme.of(context).textTheme.bodyText1,),
                          );
                        }).toList(),
                        hint: Text(language.Select,style: Theme.of(context).textTheme.bodyText1,),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: Dimension.Padding),
                        child: Text(language.Amount_Between,style: TextStyle(color: Themes.Primary,fontSize: Dimension.Text_Size,fontWeight: FontWeight.bold),)),
                    /*Container(
                      child: RangeSlider(
                        min: 0.0,
                        max: 1000000.0,
                        values: searchFilterProvider.selectedRange,
                        inactiveColor: Themes.Grey,
                        activeColor: Themes.Primary,
                        divisions: 1000,
                        onChanged: (RangeValues value){
                            searchFilterProvider.changeRange(value);
                        },
                      ),
                    ),*/
                    Container(
                      margin: EdgeInsets.only(top: Dimension.Size_10),
                      width: mainWidth,
                      child: Row(
                        children: [
                          Container(
                            width: mainWidth*0.3,
                              child: DefaultTextField(
                                controller: searchFilterProvider.minAmount,
                                textInputType: TextInputType.number,
                                enableValidation: false,
                                label: language.Min_Amount,
                              )
                          ),
                          Expanded(
                            child: Container()
                          ),
                          Container(
                              width: mainWidth*0.3,
                              child: DefaultTextField(
                                controller: searchFilterProvider.maxAmount,
                                textInputType: TextInputType.number,
                                enableValidation: false,
                                label: language.Max_Amount,
                              )
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FlatButton(
                          child: Text(language.Close,style: TextStyle(color: Themes.Primary,fontSize: Dimension.Text_Size_Small,fontWeight: Dimension.textBold),),
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton(
                          child: Text(language.Apply,style: TextStyle(color: Themes.Green,fontSize: Dimension.Text_Size_Small,fontWeight: Dimension.textBold),),
                          onPressed: (){
                            if(searchFilterProvider.isValidData){
                              Navigator.of(context).pop();
                              widget.returnData({
                                AppConstant.sort:searchFilterProvider.selectedSort,
                                AppConstant.min:double.parse(searchFilterProvider.minAmount.text),
                                AppConstant.max:double.parse(searchFilterProvider.maxAmount.text)
                              });
                            }else {
                              ErrorMessage(context,
                                  message: language.Please_enter_valid_Amount);
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );

  }
}