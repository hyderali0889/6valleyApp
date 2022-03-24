import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:geniouscart/Class/DetailsProduct.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Screen/DetailsProduct/PhotoVIew.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/main.dart';

class ProductImageSlider extends StatefulWidget {
  List<ProductImages> productImages;
  String firstImage;

  ProductImageSlider(this.productImages,this.firstImage);

  @override
  _ProductImageSliderState createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  final CarouselController controller = CarouselController();
  PageController pageController=PageController(initialPage: 0,viewportFraction: 1.0,keepPage: true);
  int currentIndex=0;


  @override
  void initState() {
    super.initState();
    ProductImages img=widget.productImages[0];
    widget.productImages[0]=ProductImages(id:0,image: widget.firstImage);
    widget.productImages.add(img);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mainHeight*0.4,
     /* child: ImagesSlider(
        pageController: PageController(viewportFraction: 1.0,initialPage: 0,keepPage: true),
        height: mainHeight*0.4,
        items: widget.productImages.asMap().map((index,e) => MapEntry(
            index,
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PhotoView(
                      initialIndex: index,
                      images: widget.productImages,
                    ),
                  ),
                );
              },
              child: Container(
                height: mainHeight*0.4,
                alignment: Alignment.bottomCenter,
                width: mainWidth,
                child: Image.network(widget.productImages[index].image,width: mainWidth,fit: BoxFit.cover,),
              ),
            )
        )).values.toList(),
        autoPlay: true,
        realPage: 0,
        viewportFraction: 1.0,
        indicatorColor: Themes.Primary,
        indicatorBackColor: Themes.Grey.withAlpha(Dimension.Alpha),
        aspectRatio: 2.0,
        align: IndicatorAlign.bottom,
        indicatorWidth: 5,
        updateCallback: (index) {

        },
        distortion: false,
      ),*/
      child: Stack(
        children: [
          Positioned.fill(
            child: CarouselSlider(
              items: widget.productImages.asMap().map((index,e) => MapEntry(
                  index,
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhotoView(
                            initialIndex: index,
                            images: widget.productImages,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: mainHeight*0.4,
                      alignment: Alignment.bottomCenter,
                      width: mainWidth,
                      child: Image.network(widget.productImages[index].image,width: mainWidth,fit: BoxFit.cover,),
                    ),
                  )
              )).values.toList(),
              options: CarouselOptions(
                  height:  mainHeight*0.4,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 2.0,
                  onPageChanged: (index, reason) {
                    currentIndex=index;
                    setState(() {

                    });
                  }
              ),
              carouselController: controller,
            ),
          ),
          Positioned(
            bottom: 0,
            width: mainWidth,
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.productImages.map((url) {
                int index = widget.productImages.indexOf(url);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == index
                        ? Color.fromRGBO(0, 0, 0, 0.9)
                        : Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                );
              }).toList(),
            )
          )
        ],
      ),
    );
  }
}
