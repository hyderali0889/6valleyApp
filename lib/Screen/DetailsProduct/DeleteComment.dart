import 'package:flutter/material.dart';
import 'package:geniouscart/Class/DetailsProduct.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Providers/DeleteCommentProvider.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/Widgets/CircularProgress.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class DeleteComment extends StatefulWidget {
  Widget child;
  bool isReply;
  int replyIndex;
  Comments comment;
  String message;
  DeleteComment(this.child,{this.isReply=false, this.replyIndex, this.comment,this.message});

  @override
  _DeleteCommentState createState() => _DeleteCommentState();
}

class _DeleteCommentState extends State<DeleteComment> {

  DeleteCommentProvider deleteCommentProvider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DeleteCommentProvider>(
      create: (_)=>DeleteCommentProvider()..setView(context,isReply: widget.isReply,replyIndex: widget.replyIndex,comment: widget.comment),
      child: Consumer<DeleteCommentProvider>(
        builder: (context,model,child){
          deleteCommentProvider=model;
          return Container(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(0),
              children: [
                Container(
                    margin: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding),
                    child: Text(widget.message,style: Theme.of(context).textTheme.bodyText1,)
                ),
                AbsorbPointer(
                  absorbing: true,
                  child: Container(
                      margin: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding,top: Dimension.Padding),
                      child: widget.child
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FlatButton(
                      child: Text(language.Close,style: TextStyle(color: Themes.Primary,fontSize: Dimension.Text_Size_Small_Extra,fontWeight: Dimension.textBold),),
                      onPressed: ()=>Navigator.of(context).pop(false),
                    ),
                    deleteCommentProvider.Loading ? Padding(
                      padding: EdgeInsets.only(right: Dimension.Padding),
                      child: CircularProgress(color: Themes.Green),
                    ) : FlatButton(
                      child: Text(language.Delete,style: TextStyle(color: Themes.Green,fontSize: Dimension.Text_Size_Small_Extra,fontWeight: Dimension.textBold),),
                      onPressed: ()=>deleteCommentProvider.deleteComment(),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
