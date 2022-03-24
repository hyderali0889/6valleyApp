import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Widgets/DefaultDialog.dart';
import 'package:geniouscart/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future <bool> RemoveDialog({Widget child,BuildContext context,String message}) async{
  if(message==null)
    message=language.Remove_Alert;
  bool status =false;
   await showDialog<bool>(
       context: context,
       builder: (BuildContext context){
         return DefaultDialog(
           title: language.Alert,
           isError: true,
           child: ListView(
             shrinkWrap: true,
             physics: NeverScrollableScrollPhysics(),
             children: <Widget>[
               child,
               Padding(
                 padding: EdgeInsets.all(Dimension.Padding),
                 child: Text(message,style: Theme.of(context).textTheme.bodyText1,),
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: <Widget>[
                   FlatButton(
                     onPressed: () {
                       status= false;
                       Navigator.of(context).pop();
                     },
                     child: Text(
                       language.No,
                       style: TextStyle(color: Colors.redAccent),
                     ),
                   ),
                   FlatButton(
                     onPressed: () {
                       status= true;
                       Navigator.of(context).pop();
                     },
                     child: Text(
                       language.Yes,
                       style: TextStyle(color: Colors.teal),
                     ),
                   )
                 ],
               )
             ],
           ),
         );
       }
   );
   return status;
}