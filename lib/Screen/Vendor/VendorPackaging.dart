import 'package:flutter/material.dart';
import 'package:geniouscart/Class/Packaging.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Providers/Vendor/AddPackagingProvider.dart';
import 'package:geniouscart/Providers/Vendor/VendorPackagingProvider.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/Widgets/CircularProgress.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/DefaultDialog.dart';
import 'package:geniouscart/Widgets/DefaultTextField.dart';
import 'package:geniouscart/Widgets/EmptyView.dart';
import 'package:geniouscart/Widgets/GetImage.dart';
import 'package:geniouscart/Widgets/ImageFormNetwork.dart';
import 'package:geniouscart/Widgets/KeyboardHandler.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/PackagingSkeleton.dart';
import 'package:geniouscart/Widgets/RemoveDialog.dart';
import 'package:geniouscart/Widgets/ServiceSkeleton.dart';
import 'package:geniouscart/Widgets/SwipeRefresh.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';

class VendorPackaging extends StatefulWidget {
  @override
  _VendorPackagingState createState() => _VendorPackagingState();
}

class _VendorPackagingState extends State<VendorPackaging> {

  VendorPackagingProvider provider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VendorPackagingProvider>(
      create: (_)=>VendorPackagingProvider()..setView(context),
      child: Consumer<VendorPackagingProvider>(
        builder: (context,model,child){
          provider=model;
          return Scaffold(
            appBar: DefaultAppbar(context: context,title: ModalRoute.of(context).settings.arguments.toString()),
            body: SwipeRefresh(
                controller: provider.controller,
                onRefresh: provider.refreshData,
                children: [
                  provider.Loading ? PackagingSkeleton(context: context,count: 10) :
                  provider.packages!=null ? provider.packages.data.isNotEmpty ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: provider.packages.data.length,
                    padding: EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      return ListAnimation(
                          index: index,
                          child: packagesList(provider.packages.data[index],index)
                      );
                    } ,
                  ) : EmptyView():EmptyView(),
                  Padding(
                      padding: EdgeInsets.only(bottom:Dimension.Padding)
                  )
                ]
            ),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: ()=>packageDialog(),
                backgroundColor: Themes.Primary,
                label: Text(language.Add_Packaging),
                icon: Icon(Icons.add_circle_outline),
            ),
          );
        },
      ),
    );
  }

  Widget packagesList(PackagingData date,int index,{bool isDialog=false}){
    return Card(
      margin: EdgeInsets.all(10).copyWith(bottom: 0),
      elevation: Dimension.card_elevation,
      clipBehavior: Clip.antiAlias,
      child: AbsorbPointer(
        absorbing: isDialog,
        child: ListTile(
          onTap: ()=>packageDialog(isUpdate: true,packaging: date,index: index),
          trailing: Visibility(
            visible: !isDialog,
            child: IconButton(
              icon: provider.packageLoading[index] ? CircularProgress(size: 20) : Icon(Icons.delete_outline,color: Themes.Red,),
              onPressed: (){
                if(!provider.packageLoading[index])
                   removeDialog(index);
              },
            ),
          ),
          title: Text(date.title,style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size,fontWeight: Dimension.textBold),),
          subtitle: RichText(
            text: TextSpan(
              text: '(${AppConstant.currencySymbol} ${date.price})  ',
              style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size_Small,fontWeight: Dimension.textMedium),
              children: [
                TextSpan(
                  text: date.subtitle,
                  style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size_Small_Extra,fontWeight: Dimension.textNormal)
                )
              ]
            ),
          )
        ),
      ),
    );
  }

  void removeDialog(int index)async{
      bool data=await RemoveDialog(
          context: context,
          child: packagesList(provider.packages.data[index], index,isDialog: true),
          message: language.Delete_Packaging
      );
      if(data) provider.removePackaging(index);
  }

  void packageDialog({bool isUpdate=false,PackagingData packaging,int index})async{
      PackagingData data = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return DefaultDialog(
            title: language.Add_Packaging,
            child: PackageDialog(isUpdate, packaging),
          );
        },
      );
      if(data!=null)
        provider.addPackage(data,isUpdate : isUpdate,index: index);
  }
}

class PackageDialog extends StatefulWidget {
  bool isUpdate; PackagingData packaging;
  PackageDialog(this.isUpdate, this.packaging);

  @override
  _PackageDialogState createState() => _PackageDialogState(isUpdate, packaging);
}

class _PackageDialogState extends State<PackageDialog> {
  bool isUpdate; PackagingData packaging;
  _PackageDialogState( this.isUpdate, this.packaging);

  AddPackagingProvider provider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddPackagingProvider>(
      create: (_)=>AddPackagingProvider()..setView(context,isUpdate: isUpdate,data: packaging),
      child: Consumer<AddPackagingProvider>(
        builder: (context,model,child){
          provider=model;
          return KeyboardHandler(
            config: provider.configuration(),
            child: AbsorbPointer(
              absorbing: provider.Loading,
              child: Form(
                key: provider.fromKey,
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(0),
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding),
                      child: DefaultTextField(
                        controller: provider.title,
                        label: language.Title,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding,top: 10),
                      child: DefaultTextField(
                        controller: provider.subtitle,
                        label: language.Subtitle,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding,top: 10),
                      child: DefaultTextField(
                        controller: provider.price,
                        label: language.Price,
                        textInputType: TextInputType.number,
                        focusNode: provider.priceFocus
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FlatButton(
                          child: Text(language.Close,style: TextStyle(color: Themes.Primary,fontSize: Dimension.Text_Size_Small_Extra,fontWeight: Dimension.textBold),),
                          onPressed: ()=>Navigator.pop(context),
                        ),
                        provider.Loading ? Padding(
                          padding: EdgeInsets.only(right: Dimension.Padding),
                          child: CircularProgress(size: 20),
                        ) : FlatButton(
                          child: Text(isUpdate ? language.Update : language.Save,style: TextStyle(color: Themes.Green,fontSize: Dimension.Text_Size_Small_Extra,fontWeight: Dimension.textBold),),
                          onPressed: (){
                            if(provider.fromKey.currentState.validate()){
                              provider.addPackaging();
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
