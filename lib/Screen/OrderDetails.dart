import 'dart:async';
import 'dart:math';
import 'dart:ui';


import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:geniouscart/AppHelper/Helper.dart';
import 'package:geniouscart/Class/SingleOrder.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Providers/DemoProvider.dart';
import 'package:geniouscart/Providers/OrderDetailsProvider.dart';
import 'package:geniouscart/Providers/OrderDetailsProvider.dart';
import 'package:geniouscart/Providers/OrderDetailsProvider.dart';
import 'package:geniouscart/Providers/OrderDetailsProvider.dart';
import 'package:geniouscart/Providers/SplashProvider.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/Widgets/BackButton.dart';
import 'package:geniouscart/Widgets/CircularProgress.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/DefaultDialog.dart';
import 'package:geniouscart/Widgets/ImagePlaceHolder.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/LoadingView.dart';
import 'package:geniouscart/Widgets/RatingVIew.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';



class OrderDetails extends StatefulWidget {
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> with TickerProviderStateMixin {
  OrderDetailsProvider provider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OrderDetailsProvider>(
      create: (_) => OrderDetailsProvider()..setView(context),
      child: Consumer<OrderDetailsProvider>(
        builder: (context, model, child) {
          provider = model;
          return Scaffold(
            appBar: DefaultAppbar(context: context,title: language.Order_Details),
            body: provider.Loading || provider.orderDetails==null ? LoadingView() : mainView(),
          );
        },
      ),
    );
  }

  Widget mainView() {
    return Stack(
      children: [
        Positioned.fill(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 160),
            children: [
              SizedBox(height: Dimension.Size_10,),
              Container(
                color: Themes.White,
                padding: EdgeInsets.all(Dimension.Size_10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: Dimension.Size_20),
                              text: language.Invoice.toUpperCase(),
                              children: [
                                TextSpan(
                                  text: '  #${provider.orderDetails.data.number.toUpperCase()}',
                                  recognizer: TapGestureRecognizer()..onTap=(){
                                    Helper.copyText(context: context, text: provider.orderDetails.data.number);
                                  },
                                  style: Theme.of(context).textTheme.bodyText1.copyWith(color: Themes.Primary,fontSize: Dimension.Size_20),
                                )
                              ]
                          )
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(Helper.getDateTime(provider.orderDetails.data.createdAt,withYear: true),style: Theme.of(context).textTheme.bodyText1,textAlign: TextAlign.end,),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: Dimension.Size_10),
                color: Themes.White,
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(Dimension.Size_10),
                      child: Text(language.Product,style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: Dimension.Size_20),),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(left:Dimension.Size_10),
                      itemCount: provider.orderDetails.data.orderedProducts.length,
                      itemBuilder: (context,index){
                        return ListAnimation(child: productList(provider.orderDetails.data.orderedProducts[index], index), index: index);
                      }
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: Dimension.Size_10),
                color: Themes.White,
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(left:Dimension.Size_10,right: Dimension.Size_10),
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: Dimension.Size_10,top: Dimension.Size_10),
                      child: Text(language.Order_Summary,style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: Dimension.Size_20),),
                    ),
                    singleRow(language.Sub_Total, provider.orderDetails.data.total),
                    singleRow(language.Paid_Amount, provider.orderDetails.data.paidAmount),
                    singleRow(language.Shipping_Cost, provider.orderDetails.data.shippingCost),
                    singleRow(language.Packageing_Cost, provider.orderDetails.data.packingCost),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: Dimension.Size_10),
                color: Themes.White,
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(left:Dimension.Size_10,right: Dimension.Size_10),
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: Dimension.Size_10,top: Dimension.Size_10),
                      child: Row(
                        children: [
                          Expanded(child: Text(language.Payment_Status,style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: Dimension.Size_20),)),
                          Container(
                            decoration: BoxDecoration(
                              color:provider.orderDetails.data.paymentStatus==AppConstant.Completed ? Themes.Green : Themes.Red,
                              borderRadius: BorderRadius.circular(Dimension.Size_5)
                            ),
                            padding: EdgeInsets.all(Dimension.Size_10).copyWith(top: Dimension.Size_5,bottom: Dimension.Size_5),
                            child: Text(provider.orderDetails.data.paymentStatus==AppConstant.Completed ? language.Paid : language.Unpaid,style: Theme.of(context).textTheme.bodyText1.copyWith(color: Themes.White),),
                          ),
                        ],
                      ),
                    ),
                    provider.orderDetails.data.paymentMethod!=null && provider.orderDetails.data.paymentStatus==AppConstant.Completed?
                    Column(
                      children: [
                        singleRow(language.Payment_Method, provider.orderDetails.data.paymentMethod),
                        singleRow(language.Transaction_Id, provider.orderDetails.data.transactionId,valueFlex: 2),
                      ],
                    ) :
                    InkWell(
                      onTap: ()async{
                        var response = await Navigator.of(context).pushNamed(PAYMENT_PAGE, arguments: {
                          AppConstant.url:provider.arg[AppConstant.payment_url],
                        });
                        if(response!=null)if(response==true) {
                          provider.getData();
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: Dimension.Size_10),
                        padding: EdgeInsets.all(Dimension.Size_10).copyWith(left: Dimension.Size_20,right: Dimension.Size_20),
                        decoration: BoxDecoration(
                            color: Themes.Primary,
                            borderRadius: BorderRadius.circular(Dimension.Size_5)
                        ),
                        child: Text(language.Pay_Now,style: Theme.of(context).textTheme.bodyText1.copyWith(color: Themes.White),textAlign: TextAlign.center,),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: Dimension.Size_10),
                color: Themes.White,
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(left:Dimension.Size_10,right: Dimension.Size_10),
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: Dimension.Size_10,top: Dimension.Size_10),
                      child: Text(language.Billing_Address,style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: Dimension.Size_20),),
                    ),
                    singleRow(language.Email, provider.orderDetails.data.customerEmail),
                    singleRow(language.Phone, provider.orderDetails.data.customerPhone),
                    singleRow(language.Address, provider.orderDetails.data.customerAddress),
                    singleRow(language.City, provider.orderDetails.data.customerCity),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: Dimension.Size_10),
                color: Themes.White,
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(left:Dimension.Size_10,right: Dimension.Size_10),
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: Dimension.Size_10,top: Dimension.Size_10),
                      child: Text(language.Shipping_Address,style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: Dimension.Size_20),),
                    ),
                    singleRow(language.Email, provider.orderDetails.data.shippingEmail),
                    singleRow(language.Phone, provider.orderDetails.data.shippingPhone),
                    singleRow(language.Address, provider.orderDetails.data.shippingAddress),
                    singleRow(language.City, provider.orderDetails.data.shippingCity),
                  ],
                ),
              ),
              SizedBox(height: Dimension.Padding,)
            ],
          ),
        ),
        IgnorePointer(
          ignoring: true,
          child: Container(
            height: 160,
            color: Themes.White,
          ),
        ),
        IgnorePointer(
          ignoring: true,
          child: timeLineView(),
        ),
      ],
    );
  }
  Widget singleRow(String key,String value,{int keyFlex=1,int valueFlex=1}){
    return Container(
      padding: EdgeInsets.only(bottom: Dimension.Size_10,),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: keyFlex,
            child: Text('$key : ',style: Theme.of(context).textTheme.bodyText1,),
          ),
          Expanded(
            flex: valueFlex,
            child: Text(value,style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: Dimension.textBold),textAlign: TextAlign.right,),
          ),
        ],
      ),
    );
  }

  Widget productList(OrderedProducts date,int index){
    return Container(
        child: Stack(
          children: [
            Card(
              elevation: Dimension.card_elevation,
              clipBehavior: Clip.antiAlias,
              color: Themes.White,
              margin: EdgeInsets.only(bottom: Dimension.Size_10),
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(date.featureImage,height: 120,),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5).copyWith(right: Dimension.Size_10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text('${AppConstant.currencySymbol} ${date.itemPrice}',style: TextStyle(fontSize: Dimension.Text_Size_Big,color: Themes.Text_Color,fontWeight: FontWeight.bold),),
                                ),
                                Visibility(
                                  visible: date.size!='',
                                  child: Container(
                                    height: Dimension.Size_20,
                                    padding: EdgeInsets.only(left: 5,right: 5),
                                    margin: EdgeInsets.only(left: 5,right: 5),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Themes.White,
                                        border: Border.all(color: Themes.Primary ,width: 1)
                                    ),
                                    child: Text(date.size,style: TextStyle(color: Themes.Primary,fontSize: Dimension.Text_Size_Small,fontWeight: Dimension.textMedium),),
                                  ),
                                ),
                                date.color!='' ? Container(
                                  height: 20,
                                  width: 20,
                                  margin: EdgeInsets.only(left: 5,right: 5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Themes.getColorFromColorCode('#${date.color}'),
                                      shape: BoxShape.circle
                                  ),
                                ) : Container()

                              ],
                            ),
                            SizedBox(height: Dimension.Size_5,),
                            Text(date.name,style: TextStyle(fontSize: Dimension.Text_Size,color: Themes.Text_Color,fontWeight: Dimension.textMedium),maxLines: 2,overflow: TextOverflow.ellipsis,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                right: Dimension.Size_10,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.all(Dimension.Size_10),
                  decoration: BoxDecoration(
                      color: Themes.White,
                      shape: BoxShape.circle,
                      border: Border.all(color: Themes.Green,width: 1)
                  ),
                  child: Text('${date.qty}',style: Theme.of(context).textTheme.bodyText1.copyWith(color: Themes.Green),),
                )
            )
          ],
        )
    );
  }

  Widget timeLineView(){
    return Timeline.tileBuilder(
      theme: TimelineThemeData(
        direction: Axis.horizontal,
        nodePosition: 0.1,
        connectorTheme: ConnectorThemeData(
          space: Dimension.Size_30,
          thickness: Dimension.Size_5,
        ),
      ),
      builder: TimelineTileBuilder.connected(
          connectionDirection: ConnectionDirection.before,
            itemExtentBuilder: (_, __) =>
            MediaQuery.of(context).size.width / provider.processes.length,
            oppositeContentsBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: Dimension.Padding),
                child: WebsafeSvg.asset(
                  'assets/process_timeline/status${index + 1}.svg',
                  width: 50.0,
                  color: provider.getColor(index),
                ),
              );
            },
        contentsBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: Dimension.Size_15),
            child: Text(
              provider.processes[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: provider.getColor(index),
              ),
            ),
          );
        },
        indicatorBuilder: (_, index) {
          var color;
          var child;
          if(!provider.isCanceled){
            if (index == provider.processIndex) {
              color = provider.isCanceled ? Colors.red : Themes.Primary;
              child = Padding(
                padding: EdgeInsets.all(Dimension.Size_8),
                child: provider.processIndex<3 ? CircularProgressIndicator(
                  strokeWidth: Dimension.Size_3,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ) : Icon(
                  Icons.check,
                  color: Colors.white,
                  size: Dimension.Size_14,
                ),
              );
            } else if (index < provider.processIndex) {
              color = provider.completeColor;
              child = Icon(
                Icons.check,
                color: Colors.white,
                size: Dimension.Size_14,
              );
            } else {
              color = provider.todoColor;
            }
          }
          else{
            color = Colors.red;
            child = Icon(
              Icons.close,
              color: Colors.white,
              size: Dimension.Size_14,
            );
          }


          if (index <= provider.processIndex) {
            return Stack(
              children: [
                CustomPaint(
                  size: Size(Dimension.Size_30, Dimension.Size_30),
                  painter: _BezierPainter(
                    color: color,
                    drawStart: index > 0,
                    drawEnd: index < provider.processIndex,
                  ),
                ),
                DotIndicator(
                  size: 30.0,
                  color: color,
                  child: child,
                ),
              ],
            );
          } else {
            return Stack(
              children: [
                CustomPaint(
                  size: Size(Dimension.Size_15, Dimension.Size_15),
                  painter: _BezierPainter(
                    color: color,
                    drawEnd: index < provider.processes.length - 1,
                  ),
                ),
                OutlinedDotIndicator(
                  borderWidth: Dimension.Size_4,
                  color: color,
                ),
              ],
            );
          }
        },
        connectorBuilder: (_, index, type) {
          if (index > 0) {
            if (index == provider.processIndex) {
              final prevColor = provider.getColor(index - 1);
              final color = provider.getColor(index);
              var gradientColors;
              if (type == ConnectorType.start) {
                gradientColors = [Color.lerp(prevColor, color, 0.5), color];
              } else {
                gradientColors = [
                  prevColor,
                  Color.lerp(prevColor, color, 0.5)
                ];
              }
              return DecoratedLineConnector(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradientColors,
                  ),
                ),
              );
            } else {
              return SolidLineConnector(
                color: provider.getColor(index),
              );
            }
          } else {
            return null;
          }
        },
        itemCount: provider.processes.length,
      ),
    );
  }
}

/// hardcoded bezier painter
/// TODO: Bezier curve into package component
class _BezierPainter extends CustomPainter {
  const _BezierPainter({
    @required this.color,
    this.drawStart = true,
    this.drawEnd = true,
  });

  final Color color;
  final bool drawStart;
  final bool drawEnd;

  Offset _offset(double radius, double angle) {
    return Offset(
      radius * cos(angle) + radius,
      radius * sin(angle) + radius,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final radius = size.width / 2;

    var angle;
    var offset1;
    var offset2;

    var path;

    if (drawStart) {
      angle = 3 * pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);
      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(0.0, size.height / 2, -radius,
            radius) // TODO connector start & gradient
        ..quadraticBezierTo(0.0, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
    if (drawEnd) {
      angle = -pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);

      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(size.width, size.height / 2, size.width + radius,
            radius) // TODO connector end & gradient
        ..quadraticBezierTo(size.width, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_BezierPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.drawStart != drawStart ||
        oldDelegate.drawEnd != drawEnd;
  }
}
