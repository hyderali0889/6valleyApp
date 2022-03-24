import 'package:flutter/material.dart';
import 'package:geniouscart/Class/Product.dart';
import 'package:geniouscart/Class/Services.dart';
import 'package:geniouscart/Class/VendorProductModel.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Providers/Vendor/AddServiceProvider.dart';
import 'package:geniouscart/Providers/Vendor/VendorServicesProvider.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/Widgets/CircularProgress.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/DefaultDialog.dart';
import 'package:geniouscart/Widgets/DefaultTextField.dart';
import 'package:geniouscart/Widgets/EmptyView.dart';
import 'package:geniouscart/Widgets/GetImage.dart';
import 'package:geniouscart/Widgets/HomePopularProductSkeleton.dart';
import 'package:geniouscart/Widgets/HomeServiceSkeleton.dart';
import 'package:geniouscart/Widgets/ImageFormNetwork.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/RatingVIew.dart';
import 'package:geniouscart/Widgets/RemoveDialog.dart';
import 'package:geniouscart/Widgets/ServiceSkeleton.dart';
import 'package:geniouscart/Widgets/SwipeRefresh.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';

class VendorServices extends StatefulWidget {
  @override
  _VendorServicesState createState() => _VendorServicesState();
}

class _VendorServicesState extends State<VendorServices> {

  VendorServicesProvider provider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VendorServicesProvider>(
      create: (_)=>VendorServicesProvider()..setView(context),
      child: Consumer<VendorServicesProvider>(
        builder: (context,model,child){
          provider=model;
          return Scaffold(
            appBar: DefaultAppbar(context: context,title: ModalRoute.of(context).settings.arguments.toString()),
            body: SwipeRefresh(
                controller: provider.controller,
                onRefresh: provider.refreshData,
                children: [
                  provider.Loading ? ServiceSkeleton(context: context,count: 10) :
                  provider.services!=null ? provider.services.data.isNotEmpty ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: provider.services.data.length,
                    padding: EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      return ListAnimation(
                          index: index,
                          child: servicesList(provider.services.data[index],index)
                      );
                    } ,
                  ) : EmptyView():EmptyView(),
                  Padding(
                      padding: EdgeInsets.only(bottom:Dimension.Padding)
                  )
                ]
            ),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: ()=>serviceDialog(),
                backgroundColor: Themes.Primary,
                label: Text(language.Add_Service),
                icon: Icon(Icons.add_circle_outline),
            ),
          );
        },
      ),
    );
  }

  Widget servicesList(ServicesData date,int index,{bool isDialog=false}){
    return Card(
      margin: EdgeInsets.all(10).copyWith(bottom: 0),
      elevation: Dimension.card_elevation,
      clipBehavior: Clip.antiAlias,
      child: AbsorbPointer(
        absorbing: isDialog,
        child: ListTile(
          onTap: ()=>serviceDialog(isUpdate: true,service: date,index: index),
          leading: Image.network(date.photo,height: 30,width: 30,),
          trailing: Visibility(
            visible: !isDialog,
            child: IconButton(
              icon: provider.serviceLoading[index] ? CircularProgress(size: 20) : Icon(Icons.delete_outline,color: Themes.Red,),
              onPressed: (){
                if(!provider.serviceLoading[index])
                   removeDialog(index);
              },
            ),
          ),
          title: Text(date.title,style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size,fontWeight: Dimension.textMedium),),
          subtitle: Text(date.details,style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size_Small_Extra,fontWeight: Dimension.textNormal)),
        ),
      ),
    );
  }

  void removeDialog(int index)async{
      bool data=await RemoveDialog(
          context: context,
          child: servicesList(provider.services.data[index], index,isDialog: true),
          message: language.Delete_Service
      );
      if(data) provider.removeServices(index);
  }

  void serviceDialog({bool isUpdate=false,ServicesData service,int index})async{
      ServicesData data = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return DefaultDialog(
            title: language.Add_Service,
            child: ServiceDialog(isUpdate, service),
          );
        }
      );
      if(data!=null)
        provider.addService(data,isUpdate : isUpdate,index: index);
  }
}

class ServiceDialog extends StatefulWidget {
  bool isUpdate; ServicesData service;
  ServiceDialog(this.isUpdate, this.service);

  @override
  _ServiceDialogState createState() => _ServiceDialogState(isUpdate, service);
}

class _ServiceDialogState extends State<ServiceDialog> {
  bool isUpdate; ServicesData service;
  _ServiceDialogState( this.isUpdate, this.service);

  AddServiceProvider provider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddServiceProvider>(
      create: (_)=>AddServiceProvider()..setView(context,isUpdate: isUpdate,data: service),
      child: Consumer<AddServiceProvider>(
        builder: (context,model,child){
          provider=model;
          return AbsorbPointer(
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
                      controller: provider.details,
                      label: language.Details,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: Dimension.Padding, right: Dimension.Padding,top: 10,bottom: 10),
                    padding: EdgeInsets.all(Dimension.Padding),
                    decoration: BoxDecoration(
                        color: Themes.Primary.withAlpha(15),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          language.Image_Upload,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Card(
                              elevation: 0,
                              clipBehavior: Clip.antiAlias,
                              child: GestureDetector(
                                onTap: () async {
                                  provider.image = await getImage(context);
                                  provider.ChangeState();
                                },
                                child: Container(
                                    height: 80,
                                    width: 100,
                                    color: Themes.White,
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: provider.image == null
                                            ? ImageFromNetwork(
                                          url: service != null ? service.photo : "",
                                          color: Themes.Text_Color,
                                          height: 80,
                                        )
                                            : Image.file(
                                          provider.image,
                                          fit: BoxFit.fill,
                                          scale: 1.0,
                                        ))),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 5),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      language.Upload_Image,
                                      style: Theme.of(context).textTheme.bodyText2,
                                    ),
                                    Text(
                                      language.Upload_Image_Message,
                                      style: TextStyle(
                                          color:
                                          Themes.Primary.withAlpha(Dimension.Alpha),
                                          fontSize: Dimension.Text_Size_Small_Extra),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
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
                            provider.addService();
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
