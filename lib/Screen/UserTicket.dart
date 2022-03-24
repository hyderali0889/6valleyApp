import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geniouscart/Class/FaqModel.dart';
import 'package:geniouscart/Class/Ticket.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Packege/Expandable/Expandable.dart';
import 'package:geniouscart/Packege/Loading_Button/Loading_Button.dart';
import 'package:geniouscart/Providers/DemoProvider.dart';
import 'package:geniouscart/Providers/FaqPageProvider.dart';
import 'package:geniouscart/Providers/MessageTicketProvider.dart';
import 'package:geniouscart/Providers/UserTicketProvider.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/Api_Client2.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/BottomDialog.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/DefaultDialog.dart';
import 'package:geniouscart/Widgets/DefaultTextField.dart';
import 'package:geniouscart/Widgets/DialogButton.dart';
import 'package:geniouscart/Widgets/DividerList.dart';
import 'package:geniouscart/Widgets/EmptyView.dart';
import 'package:geniouscart/Widgets/FaqSkeleton.dart';
import 'package:geniouscart/Widgets/ListAnimation.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';
import 'package:geniouscart/Widgets/SwipeRefresh.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';

class UserTicket extends StatefulWidget {
  @override
  _UserTicketState createState() => _UserTicketState();
}

class _UserTicketState extends State<UserTicket> {

  UserTicketProvider provider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserTicketProvider>(
      create: (_)=>UserTicketProvider()..setView(context),
      child: Consumer<UserTicketProvider>(builder: (context,model,child){
        provider=model;
        return Scaffold(
          appBar: DefaultAppbar(context: context,title: language.Messages),
          body: Container(
            child: SwipeRefresh(
                controller: provider.refreshController,
                onRefresh: provider.refreshPage,
                children: [
                  provider.Loading ? FaqSkeleton(context: context) :
                  provider.userMessages!=null ? provider.userMessages.data.length>0 ? ListView.builder(
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: provider.userMessages.data.length,
                      itemBuilder: (context,index){
                        return ListAnimation(
                            child: singleTicket(provider.userMessages.data[index],index),
                            index: index
                        );
                      }
                  ) : emptyView() : emptyView(),
                  Padding(
                    padding: EdgeInsets.only(bottom: 100),
                  )
                ]
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
              onPressed: (){
                showNewMessageDialog();
              },
              backgroundColor: Themes.Primary,
              label: Text(provider.isDisputes ? language.Add_Dispute : language.Add_Ticket,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.White),)
          ),
        );
      },),
    );
  }

  Widget emptyView(){
    return Container(
      width: mainWidth,
      height: mainHeight*0.8,
      padding: EdgeInsets.all(Dimension.Padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          WebsafeSvg.asset('assets/images/empty-inbox.svg',height: 200,),
          Padding(
            padding: EdgeInsets.only(top: Dimension.Padding),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: language.Empty_inbox,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(color: Themes.Primary,fontWeight: Dimension.textBold),
                  children: <TextSpan>[
                    TextSpan(
                        text: '\n${language.Empty_inbox_message}',
                        style: Theme.of(context).textTheme.bodyText1
                    )
                  ]
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget singleTicket(TicketData data, int index,{bool isDialog=false}) {
    return DividerList(
      child: InkWell(
        onTap: (){
          Navigator.of(context).pushNamed(TICKET_MESSAGE,arguments: data);
        },
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.all(Dimension.Size_10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.message,style: Theme.of(context).textTheme.headline1,),
                  Align(alignment: Alignment.bottomRight,child: Text(data.createdAt,style: Theme.of(context).textTheme.bodyText2,)),
                ],
              ),
            ),
            Visibility(
              visible: !isDialog,
              child: Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  onPressed: (){
                    deleteTicketDialog(singleTicket(data, index,isDialog: true),index);
                  },
                  icon: Icon(Icons.delete_outline,color: Themes.Red,),
                )
              ),
            )
          ],
        ),
      )
    );
  }

  void deleteTicketDialog(Widget child, int index)async{
    var data= await showDialog(
        context: context,
        builder: (BuildContext context){
          return DefaultDialog(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: EdgeInsets.all(Dimension.Padding).copyWith(top: 0),
              child: Column(
                children: [
                  Text(language.Remove_Alert,style: Theme.of(context).textTheme.bodyText1,),
                  Padding(
                    padding: EdgeInsets.only(top: Dimension.Padding),
                    child: child,
                  )
                ],
              ),
            ),
            DialogButton(
              negativeButton: language.No,
              positiveButton: language.Yes,
              onTap: (state){
                Navigator.of(context).pop(state);
              }
            )
          ],
        ),
        title: language.Delete_Message,
        isError: true,
      );
        }
    );
    if(data!=null)if(data){
      provider.deleteMessage(index);
    }
  }

  void showNewMessageDialog()async{
    var data = await BottomDialog(
      context: context,
      title: language.Add_Ticket,
      width: mainWidth,
      child: AddMessageDialog(provider.isDisputes)
    );
    if(data!=null)
      provider.refreshPage();
  }
}

class AddMessageDialog extends StatefulWidget {
  bool isDispute=false;

  AddMessageDialog(this.isDispute);

  @override
  _AddMessageDialogState createState() => _AddMessageDialogState();
}

class _AddMessageDialogState extends State<AddMessageDialog> {

  TextEditingController subject = TextEditingController();
  TextEditingController message = TextEditingController();
  TextEditingController orderNumber = TextEditingController();
  GlobalKey<FormState> formKey=GlobalKey();
  bool loading=false;

  changeState(){
    if(mounted)
      setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding),
          children: [
            Visibility(
              visible: widget.isDispute,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimension.Padding,),
                  DefaultTextField(
                      controller: orderNumber,
                      label: language.Order_Number
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimension.Padding,),
            DefaultTextField(
              controller: subject,
              label: language.Subject
            ),
            SizedBox(height: Dimension.Padding,),
            DefaultTextField(
                controller: message,
                label: language.Message
            ),
            SizedBox(height: Dimension.Padding,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadingButton(
                  isLoading: loading,
                  onPressed: (){
                    if(formKey.currentState.validate()){
                        sendMessage();
                    }
                  },
                  backgroundColor: Themes.Primary,
                  defaultStyle: true,
                  child: Container(
                    margin: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding),
                    child: Text(language.Send_Message,style: Theme.of(context).textTheme.headline1.copyWith(color: Themes.White),),
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimension.Padding*2,),
          ],
        ),
      ),
    );
  }

  Future sendMessage()async{
    loading=true;
    changeState();
    await ApiClient2.Request(context,
        url: URL.Store_User_Ticket,
        method: Method.POST,
        enableShowError: false,
        body: {
          AppConstant.type: widget.isDispute ? AppConstant.Dispute : AppConstant.Ticket,
          AppConstant.subject: subject.text,
          AppConstant.message: message.text,
          AppConstant.order_number: orderNumber.text,
        },
        onSuccess: (data){
          Navigator.of(context).pop(true);
        },
        onError: (data){
          ErrorMessage(context,message: data[AppConstant.error]);
        }
    );
    loading=false;
    changeState();
  }
}
