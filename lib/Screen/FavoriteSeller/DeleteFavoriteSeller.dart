import 'package:flutter/material.dart';
import 'package:geniouscart/Class/DetailsProduct.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Providers/DeleteCommentProvider.dart';
import 'package:geniouscart/Providers/DeleteFavoriteShopProvider.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/Widgets/CircularProgress.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class DeleteFavoriteSeller extends StatefulWidget {
  Widget child;
  int id;

  DeleteFavoriteSeller({this.child,this.id});

  @override
  _DeleteFavoriteSellerState createState() => _DeleteFavoriteSellerState();
}

class _DeleteFavoriteSellerState extends State<DeleteFavoriteSeller> {

  DeleteFavoriteShopProvider provider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DeleteFavoriteShopProvider>(
      create: (_)=>DeleteFavoriteShopProvider()..setView(context),
      child: Consumer<DeleteFavoriteShopProvider>(
        builder: (context,model,child){
          provider=model;
          return Container(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(0),
              children: [
                Container(
                    margin: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding),
                    child: Text(language.Remove_Favorite_Shop,style: Theme.of(context).textTheme.bodyText1,)
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
                    provider.Loading ? Padding(
                      padding: EdgeInsets.only(right: Dimension.Padding),
                      child: CircularProgress(color: Themes.Green),
                    ) : FlatButton(
                      child: Text(language.Delete,style: TextStyle(color: Themes.Green,fontSize: Dimension.Text_Size_Small_Extra,fontWeight: Dimension.textBold),),
                      onPressed: ()=>provider.deleteShop(widget.id),
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
