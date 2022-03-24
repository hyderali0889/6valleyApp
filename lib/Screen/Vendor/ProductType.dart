import 'package:flutter/material.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/main.dart';
import 'package:geniouscart/CustomIcon/my_flutter_app_icons.dart' as CustomIcon;

class ProductType extends StatefulWidget {
  @override
  _ProductTypeState createState() => _ProductTypeState();
}

class _ProductTypeState extends State<ProductType> {

  List<Type> types()=>[
    Type(
      name: language.Create_Product_Types[0],
      value: AppConstant.Create_Product_Type_Value[0],
      icon: CustomIcon.MyFlutterApp.physical,
      startColor: Themes.getColorFromColorCode('#464EE4'),
      endColor: Themes.getColorFromColorCode('#804EFE'),
      route: ADD_PHYSICAL_PRODUCT
    ),
    Type(
        name: language.Create_Product_Types[1],
        value: AppConstant.Create_Product_Type_Value[1],
        icon: CustomIcon.MyFlutterApp.digital,
        startColor: Themes.getColorFromColorCode('#F44E75'),
        endColor: Themes.getColorFromColorCode('#F57858'),
    ),
    Type(
        name: language.Create_Product_Types[2],
        value: AppConstant.Create_Product_Type_Value[2],
        icon: CustomIcon.MyFlutterApp.license,
        startColor: Themes.getColorFromColorCode('#2654FC'),
        endColor: Themes.getColorFromColorCode('#5581F1')
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppbar(context: context,title: language.Product_Type),
      body: Container(
        child: ListView.builder(
            padding: EdgeInsets.all(0),
            itemCount: types().length,
            itemBuilder: (context,index){
              return ListAnimation(
                  child: typeList(types()[index],index),
                  index: index
              );
            }
        ),
      ),
    );
  }

  Widget typeList(Type type,int index){
    return InkWell(
      onTap: (){
        if(type.route!=null){
          Navigator.of(context).pushNamed(type.route);
        }
      },
      child: Card(
        margin: EdgeInsets.all(Dimension.Padding).copyWith(bottom: types().length-1==index ? Dimension.Padding : 0),
        elevation: Dimension.card_elevation,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: mainHeight*0.5,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [type.startColor, type.endColor],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(0.5, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: mainHeight*0.18,
                    width: mainHeight*0.18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Themes.Text_Color.withAlpha(50)
                    ),
                    child: Icon(type.icon,size: 50,color: Themes.White,)
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(type.name,style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 24,color: Themes.White),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
class Type{
  String name,value,route;
  IconData icon;
  Color startColor,endColor;
  Type({this.name, this.value,this.route, this.icon,this.startColor,this.endColor});
}
