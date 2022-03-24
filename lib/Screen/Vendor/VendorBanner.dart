import 'package:flutter/material.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Packege/Loading_Button/Loading_Button.dart';
import 'package:geniouscart/Providers/Vendor/VendorBannerProvider.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/ImageFormNetwork.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';

class VendorBanner extends StatefulWidget {
  @override
  _VendorBannerState createState() => _VendorBannerState();
}

class _VendorBannerState extends State<VendorBanner> {

  VendorBannerProvider provider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VendorBannerProvider>(
      create: (_)=>VendorBannerProvider()..setView(context),
      child: Consumer<VendorBannerProvider>(
        builder: (context,model,child){
          provider=model;
          return Scaffold(
            appBar: DefaultAppbar(context: context,title: ModalRoute.of(context).settings.arguments.toString()),
            body: ListView(
              padding: EdgeInsets.all(0),
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(language.Current_Banner,style: Theme.of(context).textTheme.headline1,),
                ),
                Container(
                  height: mainHeight*0.3,
                  alignment: Alignment.center,
                  child: provider.image == null
                      ? ImageFromNetwork(
                    url: user.shopImage,
                    color: Themes.Text_Color,
                    height: mainHeight*0.3,
                  ) : Image.file(
                    provider.image,
                    fit: BoxFit.fill,
                    scale: 1.0,
                  )),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(language.Banner_Upload_Meaase,style: Theme.of(context).textTheme.bodyText2,),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton.icon(
                        onPressed: ()=>provider.setImage(),
                        color: Themes.Grey,
                        icon: Icon(Icons.file_upload,color: Themes.Text_Color,),
                        label: Text(language.Upload_Banner,)
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      LoadingButton(
                        isLoading: provider.Loading,
                        onPressed: (){

                        },
                        defaultStyle: true,
                        decoration: BoxDecoration(
                            color: Themes.Primary,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10,right: 10),
                          child: Text(language.Save,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.White),),
                        ),
                      ),
                    ],
                  ),
                )
              ]
            ),
          );
        },
      ),
    );
  }
}
