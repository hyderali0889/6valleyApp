import 'package:flutter/material.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/URL.dart';

import '../main.dart';

Future BottomDialog({@required BuildContext context,@required Widget child,@required String title,bool barrierDismissible=true,double width,bool isError=false,bool showCancelButton=true}) async{
  return await showGeneralDialog(
    barrierLabel: "Label",
    barrierDismissible: barrierDismissible,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 700),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            color: Colors.transparent,
            child: Stack(
              overflow: Overflow.visible,
              fit: StackFit.loose,
              alignment: Alignment.topCenter,
              children: <Widget>[
                Card(
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.only(top: 50),
                  shape: RoundedRectangleBorder(
                    //borderRadius: BorderRadius.all(Radius.circular(15))
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15),)
                  ),
                  elevation: 0,
                  color: Colors.white,
                  child: Container(
                    width: width ?? mainWidth*0.8,
                    margin: EdgeInsets.only(top: 20),
                    child: child,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Themes.Primary,
                            image: DecorationImage(
                                image: NetworkImage('${URL.assets}${appSetting.data.favicon}'),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      Container(
                        height: 30,
                        width: (width ?? mainWidth*0.8)-80,
                        margin: EdgeInsets.only(left: 10),
                        padding: EdgeInsets.only(left: 10,right: 10),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            //borderRadius: BorderRadius.all(Radius.circular(5))
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5),topRight: Radius.circular(15),)
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                                child: Text(title,style: TextStyle(color: isError ? Colors.redAccent:Themes.Text_Color,fontSize: Dimension.Text_Size,fontWeight: FontWeight.bold ),maxLines: 1,overflow: TextOverflow.ellipsis,)
                            ),
                            Visibility(
                              visible: showCancelButton,
                              child: InkWell(
                                onTap: (){
                                    Navigator.of(context).pop();
                                },
                                child: Icon(Icons.cancel,color: Themes.Red,),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
        child: child,
      );
    },
  );
}