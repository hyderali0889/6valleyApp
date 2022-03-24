import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:geniouscart/Class/ForgotPass.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Packege/Loading_Button/Loading_Button.dart';
import 'package:geniouscart/Providers/AuthenticationProvider.dart';
import 'package:geniouscart/Providers/MainPageProvider.dart';
import 'package:geniouscart/Providers/RegistrationProvider.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/URL/Api_Client2.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/CircleButton.dart';
import 'package:geniouscart/Widgets/CircularProgress.dart';
import 'package:geniouscart/Widgets/DefaultAppbar.dart';
import 'package:geniouscart/Widgets/DefaultDialog.dart';
import 'package:geniouscart/Widgets/DefaultTextField.dart';
import 'package:geniouscart/Widgets/KeyboardHandler.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';
import 'package:geniouscart/main.dart';
import 'package:provider/provider.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  RegistrationProvider provider;

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<RegistrationProvider>(
      create: (BuildContext context)=>RegistrationProvider()..setView(context),
      child: Consumer<RegistrationProvider>(builder: (context,model,child){
        if(provider==null){
          provider=model;
          provider.mainPageProvider=Provider.of<MainPageProvider>(context);
          if(ModalRoute.of(context).settings.arguments!=null)
            provider.isHaveAppBar=ModalRoute.of(context).settings.arguments;
        }

        return Scaffold(
          key: provider.scaffoldKey,
          backgroundColor: Themes.White,
          appBar: provider.isHaveAppBar ?  DefaultAppbar(context: context,title: language.Join) : PreferredSize(
            preferredSize: Size(0,0),
            child: Container(),
          ),
          body: KeyboardHandler(
            config: provider.configuration(),
            child: Form(
              key: provider.fromKey,
              child: Container(
                height: mainHeight,
                child: ListView(
                  padding: EdgeInsets.all(0),
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                        margin: EdgeInsets.all(Dimension.Padding),
                        child: Container(
                            child: ListView(
                              padding: EdgeInsets.all(0),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                Container(
                                  padding: EdgeInsets.all(50),
                                  child: Text(language.SignUp_Now.toUpperCase(),style: TextStyle(fontSize: 24,color: Themes.Primary,fontWeight: Dimension.textBold),textAlign: TextAlign.center,),
                                ),
                                ListView(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding,bottom: Dimension.Padding),
                                  physics: NeverScrollableScrollPhysics(),
                                  children: [
                                    DefaultTextField(
                                      controller: provider.name,
                                      prefixIcon: Icons.person_outline,
                                      label: language.Name,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: Dimension.Padding),
                                      child: DefaultTextField(
                                        controller: provider.email,
                                        textInputType: TextInputType.emailAddress,
                                        prefixIcon: Icons.email,
                                        label: language.Email,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: Dimension.Padding),
                                      child: DefaultTextField(
                                        controller: provider.phone,
                                        prefixIcon: Icons.phone,
                                        textInputType: TextInputType.phone,
                                        label: language.Phone,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: Dimension.Padding),
                                      child: DefaultTextField(
                                        controller: provider.address,
                                        prefixIcon: Icons.place,
                                        label: language.Address,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: Dimension.Padding),
                                      child: DefaultTextField(
                                        controller: provider.password,
                                        prefixIcon: Icons.vpn_key,
                                        label: language.Password,
                                        textInputType: TextInputType.visiblePassword,
                                        obscureText: provider.hidePassword,
                                        suffixIcon: IconButton(
                                          onPressed: ()=>provider.changePasswordState(),
                                          icon: Icon(provider.hidePassword ? Icons.visibility : Icons.visibility_off,color: Themes.Primary,)
                                        )
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: Dimension.Padding),
                                      child: DefaultTextField(
                                          controller: provider.confirmPassword,
                                          prefixIcon: Icons.vpn_key,
                                          label: language.Confirm_Password,
                                          textInputType: TextInputType.visiblePassword,
                                          obscureText: provider.hideConfirmPassword,
                                          suffixIcon: IconButton(
                                              onPressed: ()=>provider.changeConfirmPasswordState(),
                                              icon: Icon(provider.hideConfirmPassword ? Icons.visibility : Icons.visibility_off,color: Themes.Primary,)
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(Dimension.Padding),
                                      child: LoadingButton(
                                        isLoading: provider.Loading,
                                        defaultStyle: true,
                                        onPressed: () {
                                          if(provider.fromKey.currentState.validate()){
                                              provider.requestAuth();
                                          }
                                        },
                                        backgroundColor: Themes.Primary,
                                        child: Container(
                                            height: 30,
                                            width: mainWidth-20-(Dimension.Padding*4),
                                            alignment: Alignment.center,
                                            child: Text(language.Register.toUpperCase(),style: TextStyle(color: Themes.White,fontSize: Dimension.Text_Size_Big,fontWeight: Dimension.textBold),)
                                        ),
                                        decoration: BoxDecoration(
                                          color: Themes.Primary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.all(Dimension.Padding),
                                  child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(color: Themes.Text_Color,fontWeight: Dimension.textMedium,fontSize: Dimension.Text_Size_Small),
                                          text: language.Already_have_an_account,
                                          children: [
                                            TextSpan(
                                                style: TextStyle(color: Themes.Primary,fontWeight: Dimension.textBold,fontSize: Dimension.Text_Size),
                                                text: language.LOGIN,
                                                recognizer: new TapGestureRecognizer()..onTap = () =>provider.goForSignIn()
                                            )
                                          ]
                                      )
                                  ),
                                ),
                              ],
                            )
                        )
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },),
    );
  }


  void showForgotPassDialog(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return DefaultDialog(
        child: ForgotPassDialog(),
        title: language.Forget_Pass
      );
        }
    );
  }
}

class ForgotPassDialog extends StatefulWidget {
  @override
  _ForgotPassDialogState createState() => _ForgotPassDialogState();
}

class _ForgotPassDialogState extends State<ForgotPassDialog> {

  TextEditingController email=TextEditingController();
  TextEditingController token=TextEditingController();
  TextEditingController newPass=TextEditingController();
  TextEditingController conNewPass=TextEditingController();
  GlobalKey<FormState> formKey=GlobalKey();
  bool Loading=false;
  bool hideNew=true,hideReNew=true;
  String message='';

  ForgotPass resetData;
  bool isVerificationCodeSend=false,isPasswordChanged=false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: formKey,
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            !isPasswordChanged ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(Dimension.Padding).copyWith(top: 0),
                  child: Text(isVerificationCodeSend ? language.Enter_Your_Verification_Code : language.Please_enter_your_email_id,style: Theme.of(context).textTheme.bodyText1,),
                ),
                isVerificationCodeSend ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(Dimension.Padding).copyWith(top: 0),
                      child: DefaultTextField(
                          controller: token,
                          label: language.Code
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(Dimension.Padding).copyWith(top: 0),
                      child: DefaultTextField(
                          controller: newPass,
                          label: language.New_Password,
                          obscureText: hideNew,
                          suffixIcon: IconButton(
                            onPressed: () {
                              hideNew=!hideNew;
                              changeSate();
                            },
                            icon: Icon(hideNew ? Icons.visibility_off : Icons.visibility , color: Themes.Primary,),
                          )
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(Dimension.Padding).copyWith(top: 0),
                      child: DefaultTextField(
                          controller: conNewPass,
                          label: language.Confirm_Password,
                          obscureText: hideReNew,
                          suffixIcon: IconButton(
                            onPressed: () {
                              hideReNew=!hideReNew;
                              changeSate();
                            },
                            icon: Icon(hideReNew ? Icons.visibility_off : Icons.visibility , color: Themes.Primary,),
                          )
                      ),
                    ),
                  ],
                ):
                Padding(
                  padding: EdgeInsets.all(Dimension.Padding).copyWith(top: 0),
                  child: DefaultTextField(
                      controller: email,
                      label: language.Email
                  ),
                ),
              ],
            ) : Padding(
              padding: EdgeInsets.all(Dimension.Padding).copyWith(top: 0),
              child: Text(message,style: Theme.of(context).textTheme.bodyText1,),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FlatButton(
                  child: Text(language.Close,style: TextStyle(color: Themes.Primary,fontSize: Dimension.Text_Size_Small_Extra,fontWeight: Dimension.textBold),),
                  onPressed: (){
                      Navigator.of(context).pop();
                  },
                ),
                Visibility(
                  visible: !isPasswordChanged,
                  child: Loading ? Padding(
                    padding: EdgeInsets.only(right: Dimension.Padding),
                    child: CircularProgress(size: 20),
                  ) :
                  FlatButton(
                    child: Text(isVerificationCodeSend ? language.Save : language.Send,style: TextStyle(color: Themes.Green,fontSize: Dimension.Text_Size_Small_Extra,fontWeight: Dimension.textBold),),
                    onPressed: (){
                        if(formKey.currentState.validate()){
                          if(!isVerificationCodeSend)
                            sendResetPassword();
                          else{
                            if(resetData.data.resetToken==token.text){
                              changePassword();
                            }else{
                              ErrorMessage(context,message: language.Verification_code_not_matched);
                            }
                          }
                        }
                    }
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future sendResetPassword() async {
    Loading=true;
    changeSate();
    await ApiClient2.SimpleRequest(context,
        url: URL.Forgot_Password,
        method: Method.POST,
        body: {
         AppConstant.email : email.text
        },
        onSuccess: (data){
          resetData=ForgotPass.fromJson(data);
          isVerificationCodeSend=true;
        },
        onError: (data){
        }
    );
    Loading=false;
    changeSate();
  }
  Future changePassword() async {
    Loading=true;
    changeSate();
    await ApiClient2.SimpleRequest(context,
        url: URL.Forgot_Password_Submit,
        method: Method.POST,
        body: {
           AppConstant.new_password : newPass.text,
           AppConstant.confirm_password : conNewPass.text,
           AppConstant.reset_token : token.text,
           AppConstant.user_id : resetData.data.userId.toString(),
        },
        onSuccess: (data){
          message=data[AppConstant.data][AppConstant.message];
          isPasswordChanged=true;
        },
        onError: (data){
        }
    );
    Loading=false;
    changeSate();
  }

  void changeSate() {
    if(mounted)
      setState(() {});
  }
}

