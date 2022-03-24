import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/main.dart';

class OrderStep extends StatelessWidget {
  String image,index,title;
  bool isSelected;


  OrderStep({this.image, this.index, this.title, this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: CustomPaint(
              size: Size(mainWidth*0.32,Dimension.Size_50), //You can Replace this with your desired WIDTH and HEIGHT
              painter: RPSCustomPainter(color: isSelected ? Themes.Primary : Color(0xFFDEE0E4)),
            ),
          ),
          Positioned(
            right: Dimension.Size_20,
            child: WebsafeSvg.asset(image,height: Dimension.Size_24,width: Dimension.Size_24,color: isSelected ? Themes.White.withOpacity(0.2) : Themes.Grey.withOpacity(0.5),),
          ),
          Positioned(
            left: Dimension.Size_20,
            right: Dimension.Padding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimension.Size_10)
                  ),
                  color: Themes.Text_Color,
                  elevation: 10,
                  margin: EdgeInsets.only(right: Dimension.Size_5),
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    height: Dimension.Size_20,
                    width: Dimension.Size_20,
                    alignment: Alignment.center,
                    child: Text(index,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.White,fontSize: Dimension.Size_10),),
                  ),
                ),
                Text(title,style: Theme.of(context).textTheme.headline1.copyWith(color: isSelected ?  Themes.White : Themes.Text_Color,fontSize: Dimension.Size_10),)
              ],
            ),
          )
        ],
      ),
    );
  }



}
class RPSCustomPainter extends CustomPainter{

  Color color;


  RPSCustomPainter({this.color});

  @override
  void paint(Canvas canvas, Size size) {



    Paint paint_0 = new Paint()
      ..color = color ?? Themes.Primary
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;


    Path path_0 = Path();
    path_0.moveTo(size.width*0.10,size.height*0.50);
    path_0.lineTo(0,0);
    path_0.lineTo(size.width*0.90,0);
    path_0.lineTo(size.width,size.height*0.50);
    path_0.lineTo(size.width*0.90,size.height);
    path_0.lineTo(0,size.height);
    path_0.lineTo(size.width*0.10,size.height*0.50);
    path_0.close();

    canvas.drawPath(path_0, paint_0);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
