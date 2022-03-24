import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geniouscart/AppHelper/Helper.dart';
import 'package:geniouscart/Class/HoleSlider.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/Widgets/CircularProgress.dart';
import 'package:geniouscart/main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'HomePageSliderSkeleton.dart';

class HomePageSlider extends StatefulWidget {
  HomeSlider productes;

  HomePageSlider(this.productes);

  @override
  _HomePageSliderState createState() => _HomePageSliderState();
}

class _HomePageSliderState extends State<HomePageSlider> {
  final controller = PageController(viewportFraction: 0.8);

  int _currentPage=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }
  void startTimer() {
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if(widget.productes!=null){
        if (_currentPage < widget.productes.data.length-1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
        try{
          controller.animateToPage(
            _currentPage,
            duration: Duration(milliseconds: 350),
            curve: Curves.easeIn,
          );
        }catch(e){
        }
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.productes!=null ?
    Container(
      height: 220,
      width: mainWidth,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            controller: controller,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                elevation: Dimension.card_elevation,
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.only(right: Dimension.Padding,top: Dimension.Padding,bottom: Dimension.Padding),
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.productes.data[index].image),
                        fit: BoxFit.cover
                      )
                  ),
                  child: Container(
                    padding: EdgeInsets.only(left: Dimension.Padding),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${widget.productes.data[index].subtitle}',style: TextStyle(color: Themes.White,fontSize: Dimension.Text_Size_Small,fontWeight: FontWeight.bold),),
                        Text('${widget.productes.data[index].title}',style: TextStyle(color: Themes.White,fontSize: Dimension.Text_Size_Big,fontWeight: FontWeight.bold),),
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Text('${widget.productes.data[index].smallText}',style: TextStyle(color: Themes.White,fontSize: Dimension.Text_Size,fontWeight: FontWeight.normal),),
                        ),
                        GestureDetector(
                          onTap: (){
                            Helper.goBrowser(widget.productes.data[index].redirectUrl);
                          },
                          child: Container(
                            height: 30,
                            width: 110,
                            margin: EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Themes.Primary
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10,right: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(child: Text(language.Shop_Now.toUpperCase(),style: TextStyle(color: Themes.White,fontSize: Dimension.Text_Size_Small,fontWeight: FontWeight.bold),)),
                                  Icon(Icons.arrow_forward_ios,color: Themes.Icon_Color,size: 14,)
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: widget.productes.data.length,
          ),
          Positioned(
            bottom: (Dimension.Padding+5),
            child: Container(
              padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Themes.White.withAlpha(Dimension.Alpha)
              ),
              child: SmoothPageIndicator(
                controller: controller,
                count: widget.productes.data.length,
                effect: WormEffect(
                  dotColor: Colors.grey.withAlpha(70),
                  activeDotColor: Themes.Primary,
                  dotHeight: 10,
                  dotWidth: 10,
                ),
              ),
            ),
          ),
        ],
      ) ,
    ): HomePageSliderSkeleton(context: context,height: 200);
  }


}