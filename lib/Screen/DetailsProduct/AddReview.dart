import 'package:flutter/material.dart';
import 'package:geniouscart/Class/DetailsProduct.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Providers/AddReviewProvider.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/Widgets/CircleButton.dart';
import 'package:geniouscart/Widgets/DefaultTextField.dart';
import 'package:geniouscart/Widgets/RatingVIew.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';

class AddReview extends StatefulWidget {
  DetailsProduct detailsProduct;

  AddReview(this.detailsProduct);

  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  AddReviewProvider addReviewProvider;


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddReviewProvider>(
      create: (_)=>AddReviewProvider()..setView(context,widget.detailsProduct),
      child: Consumer<AddReviewProvider>(
        builder: (context,model,child){
          addReviewProvider=model;
          return Container(
            child: Form(
              key: addReviewProvider.fromKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Center(
                    child: RatingView(
                        itemSize: 40,
                        ignoreGestures: false,
                        onRatingUpdate: (rating)=>addReviewProvider.setRating(rating)
                    ),
                  ),
                  addReviewProvider.errorMessage!=null ? Container(
                    color: Themes.Red.withAlpha(Dimension.Alpha),
                    margin: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding,top: Dimension.Padding),
                    padding: EdgeInsets.all(5),
                    child: Text(addReviewProvider.errorMessage,style: Theme.of(context).textTheme.bodyText1.copyWith(color: Themes.White),textAlign: TextAlign.center,),
                  ):Container(),
                  Container(
                    padding: EdgeInsets.all(Dimension.Padding),
                    child: DefaultTextField(
                      controller: addReviewProvider.review,
                      label: language.Your_review,
                      maxLine: 5,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FlatButton(
                        child: Text(language.Close,style: TextStyle(color: Themes.Primary,fontSize: Dimension.Text_Size_Small_Extra,fontWeight: Dimension.textBold),),
                        onPressed: ()=>Navigator.of(context).pop(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: CircleButton(
                            child: Text(language.Submit,style: TextStyle(color: Themes.Green,fontSize: Dimension.Text_Size_Small_Extra,fontWeight: Dimension.textBold),),
                            onTap: (){
                              if(addReviewProvider.fromKey.currentState.validate()){
                                addReviewProvider.submitReview();
                              }
                            },
                            loading: addReviewProvider.Loading
                        ),
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
