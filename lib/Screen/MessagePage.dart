import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:geniouscart/Class/UserMessages.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Providers/MessagePageProvider.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/Widgets/CircularProgress.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/DefaultTextField.dart';
import 'package:geniouscart/Widgets/EmptyView.dart';
import 'package:geniouscart/Widgets/MessagesSkeleton.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';
import 'package:geniouscart/CustomIcon/my_flutter_app_icons.dart' as CustomIcon;


class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {

  MessagePageProvider provider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MessagePageProvider>(
      create: (_)=>MessagePageProvider()..setView(context),
      child: Consumer<MessagePageProvider>(
        builder: (context,model,child){
          provider=model;
          return Scaffold(
            appBar: DefaultAppbar(context: context,title: language.Messages),
            body: Container(
              child: Stack(
                children: [
                  ListView(
                    padding: EdgeInsets.only(bottom: 65),
                    children: [
                      provider.messages!=null ? provider.messages.messages.isNotEmpty ?
                      MessageView(provider.messages) : emptyView():emptyView(),
                      Padding(
                          padding: EdgeInsets.only(bottom:Dimension.Padding)
                      )
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: 65,
                      width: mainWidth,
                      color: Themes.White,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(width: Dimension.Size_10,),
                          Expanded(
                            child: Container(
                                height: 50,
                                child: DefaultTextField(
                                    controller: provider.message,
                                    borderEnable: false,
                                    hint: language.Type_a_message
                                )
                            ),
                          ),
                          !provider.Loading ? IconButton(
                            onPressed: (){
                                if(provider.message.text.isNotEmpty)
                                  provider.sendMessage();
                            },
                            icon: Icon(Icons.send,color: Themes.Primary,),
                          ) :  Padding(
                            padding: EdgeInsets.all(Dimension.Size_10),
                            child: CircularProgress(),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
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

  Widget MessageView(TicketData data) {
      return ListView.builder(
          padding: EdgeInsets.only(left: Dimension.Size_10,right: Dimension.Size_10),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: data.messages.length,
          itemBuilder: (context,i){
            bool isMind=data.messages[i].sentUserId==user.id;
            return Container(
              alignment: isMind ? Alignment.bottomRight : Alignment.bottomLeft,
              margin: EdgeInsets.only(top: Dimension.Padding,left: isMind ? mainWidth*0.2 : 0 ,right: isMind ? 0 : mainWidth*0.2),
              child: isMind ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: isMind ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding,top: 5,bottom: 5),
                      decoration: BoxDecoration(
                          color: isMind ? Themes.Primary : Themes.White,
                          borderRadius: isMind ? BorderRadius.only(bottomLeft: Radius.circular(20),topLeft: Radius.circular(20),topRight: Radius.circular(20)) :
                          BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20),topLeft: Radius.circular(20))
                      ),
                      child: Text(data.messages[i].message,style: Theme.of(context).textTheme.bodyText1.copyWith(color: isMind ? Themes.White : Themes.Text_Color),)
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5,right: isMind ? 5 : 0 ,left: isMind ? 0 : 5),
                    child: Text(data.messages[i].createdAt,style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: Dimension.Text_Size_Small_Extra),),
                  )
                ],
              ) : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: isMind ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipOval(child: Image.network(data.messages[i].sentUserImage,height: Dimension.Size_50,width: Dimension.Size_50,fit: BoxFit.cover,)),
                      SizedBox(width: Dimension.Size_10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data.messages[i].sentUser,style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: Dimension.textBold),),
                          Container(
                            child: Text(data.messages[i].createdAt,style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: Dimension.Text_Size_Small_Extra),),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: Dimension.Size_10,),
                  Container(
                      padding: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding,top: 5,bottom: 5),
                      decoration: BoxDecoration(
                          color: isMind ? Themes.Primary : Themes.White,
                          borderRadius: isMind ? BorderRadius.only(bottomLeft: Radius.circular(20),topLeft: Radius.circular(20),topRight: Radius.circular(20)) :
                          BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20),topLeft: Radius.circular(20))
                      ),
                      child: Text(data.messages[i].message,style: Theme.of(context).textTheme.bodyText1.copyWith(color: isMind ? Themes.White : Themes.Text_Color),)
                  ),
                ],
              ),
            );
          }
      );
  }
}
