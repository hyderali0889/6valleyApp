
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:flutter/material.dart';
import 'package:geniouscart/URL/URL.dart';

import '../main.dart';

class DefaultDialog extends StatefulWidget {
  Widget child;
  String title;
  bool isError;
  Alignment alignment;
  bool showCancelButton;

  DefaultDialog({@required this.child,@required this.title,this.isError=false,this.alignment=Alignment.center,this.showCancelButton=true});
  @override
  _DefaultDialogState createState() => _DefaultDialogState(child: child,title: title,isError: isError);
}

class _DefaultDialogState extends State<DefaultDialog> with SingleTickerProviderStateMixin {

  Widget child;
  String title;
  bool isError;

  _DefaultDialogState({@required this.child,@required this.title,this.isError=false});

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: widget.alignment,
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
                  width: mainWidth*0.8,
                  margin: EdgeInsets.only(top: 20),
                  child: child,
                ),
              ),
              Positioned(
                top:0,
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
                      width: (mainWidth*0.8)-80,
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
                            visible: widget.showCancelButton,
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
  }
}
/*
class DefaultDialog extends StatelessWidget {

  Widget child;
  String title;
  bool isError;

  DefaultDialog({@required this.child,@required this.title,this.isError=false});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Stack(
        overflow: Overflow.visible,
        fit: StackFit.loose,
        alignment: Alignment.topCenter,
        children: <Widget>[
            Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              margin: EdgeInsets.all(0),
              elevation: 0,
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 30),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding,bottom: 10),
                    child: Text(title,style: TextStyle(color: isError ? Colors.redAccent:Themes.Text_Color,fontSize: Dimension.Text_Size_Big,fontWeight: FontWeight.bold ),maxLines: 1,overflow: TextOverflow.ellipsis,),
                  ),
                  child
                ],
              ),
            ),
          Positioned(
            top: -30,
            child: Container(
              height: 60,
              width: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(width: 2,color: Themes.Primary)
              ),
              child: Image.asset('assets/images/logo_transparent.png',height: 40,width: 40),
            ),
          )
        ],
      ),
    );
  }
}
*/

