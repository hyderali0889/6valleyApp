import 'package:flutter/material.dart';
import 'package:geniouscart/Class/Product.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Packege/Loading_Button/Loading_Button.dart';
import 'package:geniouscart/Providers/PlaceOrderProvider.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/Widgets/DefaultTextField.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/RatingVIew.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
class PaymentDetails extends StatefulWidget {
  @override
  _PaymentDetailsState createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {

  PlaceOrderProvider provider;

  @override
  Widget build(BuildContext context) {
    if(provider==null)
      provider=Provider.of<PlaceOrderProvider>(context);
    return Container(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: Dimension.Size_10,right: Dimension.Size_10),
        children: [
          InkWell(
            onTap: ()=>provider.changeCouponCodeState(),
            child: Container(
              margin: EdgeInsets.all(Dimension.Padding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/tag.png',color: Themes.Text_Color,height: Dimension.Size_24,width: Dimension.Size_24,),
                  SizedBox(width: Dimension.Size_5,),
                  Text(language.Have_Promotion_code,style: Theme.of(context).textTheme.bodyText1.copyWith(decoration: TextDecoration.underline),),
                ],
              ),
            ),
          ),
          SizedBox(height: Dimension.Size_10,),
          Visibility(
            visible: provider.haveCouponCode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width:mainWidth*0.5,
                      margin: EdgeInsets.only(right: Dimension.Size_10),
                      child: DefaultTextField(
                        controller: provider.couponCode,
                        label: language.Coupon_Code,
                      ),
                    ),
                    LoadingButton(
                      isLoading: provider.couponLoading,
                      onPressed: (){
                        provider.checkCoupon();
                      },
                      defaultStyle: true,
                      backgroundColor: Colors.transparent,
                      child: Container(
                        height: Dimension.Size_54,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(Dimension.Size_5),
                            border: Border.all(width: 2,color: Themes.TexftFieldBorder)
                        ),
                        child: Text(language.Apply,style: Theme.of(context).textTheme.headline1,),
                      ),
                    ),
                  ],
                ),
                provider.couponMessage!=null ? Padding(
                  padding: EdgeInsets.all(Dimension.Size_10).copyWith(top: 0),
                  child: Text(provider.couponMessage.message,style: Theme.of(context).textTheme.bodyText1.copyWith(color: provider.couponMessage.status ? Themes.Green : Themes.Red),),
                ) : Container()
              ],
            ),
          ),
          SizedBox(height: Dimension.Size_10,),
          Text(language.Price_Details,style: Theme.of(context).textTheme.headline1.copyWith(fontSize: Dimension.Text_Size_Small),),
          SizedBox(height: Dimension.Size_10,),
          singleRow(language.Total_MRP, actualPrice(provider.getTotalPrice())),
          Divider(),
          singleRow(language.Total, actualPrice(provider.getTotalPrice(withCoupon: true))),
          SizedBox(height: Dimension.Size_10,),
          DefaultTextField(
            controller: provider.orderNote,
            label: language.Order_Note,
            maxLine: 4,
            enableValidation: false
          ),
        ],
      ),
    );
  }

  Widget singleRow(String title,String message){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Text(title,style: Theme.of(context).textTheme.bodyText1,)),
        Expanded(child: Text(message,style: Theme.of(context).textTheme.bodyText1,textAlign: TextAlign.end,)),
      ],
    );
  }

}
