import 'package:flutter/material.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/main.dart';

import 'DefaultDialog.dart';

Future MessageDialog(BuildContext context,{String title,String message}) async{
  return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return DefaultDialog(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                Text(message, style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FlatButton(
                      child: Text(language.OK, style: TextStyle(
                          color: Themes.Green,
                          fontSize: Dimension.Text_Size_Small_Extra,
                          fontWeight: Dimension.textBold),),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ],
                )
              ],
            ),
            title: title,
            isError: true,
          );
        }
  );
}