import 'dart:io';
import 'dart:typed_data';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/Widgets/DefaultDialog.dart';
import 'package:geniouscart/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

Future getImage(BuildContext context) async {
  var source = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return DefaultDialog(
            title: language.Choose,
            child: Container(
              padding: EdgeInsets.only(left: Dimension.Padding,
                  right: Dimension.Padding,
                  top: Dimension.Padding),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(0),
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(ImageSource.camera);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/camera.png', height: 50,
                                width: 70,),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(language.Camera, style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyText1,),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(ImageSource.gallery);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/gallery.png', height: 50,
                                width: 70,),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(language.Gallery, style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyText1,),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop(null);
                        },
                        child: Text(language.Close, style: TextStyle(
                            color: Themes.Primary,
                            fontSize: Dimension.Text_Size_Small,
                            fontWeight: FontWeight.bold),),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        }
  );
  if(source!=null){
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);
    if(pickedFile!=null)
     return File(pickedFile.path);
    else
      return null;
  }
  else
    return null;
}


Future<File> writeToFile(ByteData data, String path) {
  final buffer = data.buffer;
  return File(path).writeAsBytes(
      buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
}

