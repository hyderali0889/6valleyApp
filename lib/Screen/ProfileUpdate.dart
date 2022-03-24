import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Packege/Loading_Button/Loading_Button.dart';
import 'package:geniouscart/Providers/ProfileUpdateProvider.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/DefaultTextField.dart';
import 'package:geniouscart/Widgets/ImagePlaceHolder.dart';
import 'package:geniouscart/Widgets/KeyboardHandler.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';

class ProfileUpdate extends StatefulWidget {
  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {

  ProfileUpdateProvider provider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileUpdateProvider>(
      create: (_)=>ProfileUpdateProvider()..setView(context),
      child: Consumer<ProfileUpdateProvider>(
        builder: (context,model,child){
          provider=model;
          return Scaffold(
            appBar: DefaultAppbar(context: context,title: language.Profile),
            body: KeyboardHandler(
              config: provider.configuration(),
              child: Form(
                key: provider.fromKey,
                child: Container(
                  child: ListView(
                    padding: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding),
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            ClipOval(
                              child: provider.image==null ? CachedNetworkImage(
                                imageUrl: user.propic,
                                fit: BoxFit.cover,
                                width: 120,
                                height: 120,
                                progressIndicatorBuilder: (context, url, downloadProgress) =>ImagePlaceHolder(height: 120),
                                errorWidget: (context, url, error) => ImagePlaceHolder(isError: true,height: 120),
                              ) : Image.file(provider.image,height: 120,width: 120,),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: Dimension.Padding*2),
                            ),
                            RaisedButton(
                              onPressed: ()=>provider.getProfileImage(),
                              color: Themes.Primary,
                              child: Text(language.Browse_File,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.White),),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Dimension.Padding),
                        child: DefaultTextField(
                          controller: provider.name,
                          label: language.Name
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Dimension.Padding),
                        child: DefaultTextField(
                          controller: provider.email,
                          label: language.Email,
                          textInputType: TextInputType.emailAddress,
                          enable: false
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Dimension.Padding),
                        child: DefaultTextField(
                          controller: provider.phone,
                          label: language.Phone_Number,
                          textInputType: TextInputType.phone,
                          focusNode: provider.phoneFocus,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Dimension.Padding),
                        child: DefaultTextField(
                          controller: provider.country,
                          label: language.Country,
                          onTap: ()=>provider.openCountryPickerDialog()
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Dimension.Padding),
                        child: DefaultTextField(
                          controller: provider.city,
                          label: language.City,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Dimension.Padding),
                        child: DefaultTextField(
                          controller: provider.fax,
                          label: language.Fax,
                          textInputType: TextInputType.phone,
                          focusNode: provider.faxFocus
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Dimension.Padding),
                        child: DefaultTextField(
                          controller: provider.address,
                          label: language.Address,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Dimension.Padding),
                        child: DefaultTextField(
                            controller: provider.zip,
                            label: language.Zip_Code,
                            textInputType: TextInputType.number,
                          focusNode: provider.zipFocus
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Dimension.Padding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LoadingButton(
                              isLoading: provider.Loading,
                              onPressed: (){
                                if(provider.fromKey.currentState.validate())
                                provider.requestUpdate();
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
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
