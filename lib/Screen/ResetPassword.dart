import 'package:flutter/material.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Packege/Loading_Button/Loading_Button.dart';
import 'package:geniouscart/Providers/ResetPasswordProvider.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/DefaultTextField.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  ResetPasswordProvider provider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ResetPasswordProvider>(
      create: (_)=>ResetPasswordProvider()..setView(context),
      child: Consumer<ResetPasswordProvider>(
        builder: (context,model,child){
          provider=model;
          return Scaffold(
            appBar: DefaultAppbar(context: context,title: language.Change_Password),
            body: Form(
              key: provider.formKey,
              child: Container(
                child: ListView(
                  padding: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding),
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: Dimension.Padding),
                      child: DefaultTextField(
                          controller: provider.currentPassword,
                          label: language.Current_Password,
                          textInputType: TextInputType.visiblePassword,
                          obscureText: provider.hideCurrent,
                          suffixIcon: IconButton(
                            onPressed: ()=>provider.visibleCurrent(),
                            icon: Icon(provider.hideCurrent ? Icons.visibility_off : Icons.visibility , color: Themes.Primary,),
                          )
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Dimension.Padding),
                      child: DefaultTextField(
                          controller: provider.newPassword,
                          label: language.New_Password,
                          textInputType: TextInputType.visiblePassword,
                          obscureText: provider.hideNew,
                          suffixIcon: IconButton(
                            onPressed: ()=>provider.visibleNew(),
                            icon: Icon(provider.hideNew ? Icons.visibility_off : Icons.visibility , color: Themes.Primary,),
                          )
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Dimension.Padding),
                      child: DefaultTextField(
                          controller: provider.reNewPassword,
                          label: language.Re_New_Password,
                          textInputType: TextInputType.visiblePassword,
                          obscureText: provider.hideReNew,
                          suffixIcon: IconButton(
                            onPressed: ()=>provider.visibleReNew(),
                            icon: Icon(provider.hideReNew ? Icons.visibility_off : Icons.visibility , color: Themes.Primary,),
                          )
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
                              if(provider.formKey.currentState.validate()){
                                if(provider.newPassword.text==provider.reNewPassword.text)
                                  provider.requestUpdate();
                                else
                                  ErrorMessage(context,message: language.Pass_not_match);
                              }
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
          );
        },
      ),
    );
  }
}
