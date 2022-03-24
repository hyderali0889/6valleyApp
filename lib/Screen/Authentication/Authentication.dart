import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:geniouscart/Class/ForgotPass.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Packege/Loading_Button/Loading_Button.dart';
import 'package:geniouscart/Providers/AuthenticationProvider.dart';
import 'package:geniouscart/Providers/MainPageProvider.dart';
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

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {

  AuthenticationProvider authenticationProvider;

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<AuthenticationProvider>(
      create: (BuildContext context)=>AuthenticationProvider()..setView(context),
      child: Consumer<AuthenticationProvider>(builder: (context,model,child){
        if(authenticationProvider==null){
          authenticationProvider=model;
          authenticationProvider.mainPageProvider=Provider.of<MainPageProvider>(context);
          if(ModalRoute.of(context).settings.arguments!=null)
            authenticationProvider.isHaveAppBar=ModalRoute.of(context).settings.arguments;
        }

        return Scaffold(
          key: authenticationProvider.scaffoldKey,
          backgroundColor: Themes.White,
          appBar: authenticationProvider.isHaveAppBar ?  DefaultAppbar(context: context,title: language.Join) : PreferredSize(
            preferredSize: Size(0,0),
            child: Container(),
          ),
          body: KeyboardHandler(
            config: authenticationProvider.configuration(),
            child: Form(
              key: authenticationProvider.fromKey,
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
                                  child: Text(language.Login_Now.toUpperCase(),style: TextStyle(fontSize: 24,color: Themes.Primary,fontWeight: Dimension.textBold),textAlign: TextAlign.center,),
                                ),
                                ListView(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding,bottom: Dimension.Padding),
                                  physics: NeverScrollableScrollPhysics(),
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: Dimension.Padding),
                                      child: DefaultTextField(
                                        controller: authenticationProvider.email,
                                        textInputType: TextInputType.emailAddress,
                                        prefixIcon: Icons.email,
                                        label: language.Email,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: Dimension.Padding),
                                      child: DefaultTextField(
                                        controller: authenticationProvider.password,
                                        prefixIcon: Icons.vpn_key,
                                        label: language.Password,
                                        textInputType: TextInputType.visiblePassword,
                                        obscureText: authenticationProvider.hidePassword,
                                        suffixIcon: IconButton(
                                          onPressed: ()=>authenticationProvider.changePasswordState(),
                                          icon: Icon(authenticationProvider.hidePassword ? Icons.visibility : Icons.visibility_off,color: Themes.Primary,)
                                        )
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: Dimension.Padding),
                                      child: GestureDetector(
                                        onTap: (){
                                          showForgotPassDialog();
                                        },
                                        child: Text(language.Forget_Pass,textAlign: TextAlign.end,style: TextStyle(color: Themes.Primary,fontWeight: Dimension.textMedium,fontSize: Dimension.Text_Size_Small),),
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
                                        isLoading: authenticationProvider.Loading,
                                        defaultStyle: true,
                                        onPressed: () {
                                          if(authenticationProvider.fromKey.currentState.validate()){
                                              authenticationProvider.requestAuth();
                                          }
                                        },
                                        backgroundColor: Themes.Primary,
                                        child: Container(
                                            height: 30,
                                            width: mainWidth-20-(Dimension.Padding*4),
                                            alignment: Alignment.center,
                                            child: Text(language.Login.toUpperCase(),style: TextStyle(color: Themes.White,fontSize: Dimension.Text_Size_Big,fontWeight: Dimension.textBold),)
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
                                      text: language.Dont_heve_an_account,
                                      children: [
                                        TextSpan(
                                          style: TextStyle(color: Themes.Primary,fontWeight: Dimension.textBold,fontSize: Dimension.Text_Size),
                                          text: language.Register,
                                            recognizer: new TapGestureRecognizer()..onTap = () =>authenticationProvider.goForSignUp()
                                        )
                                      ]
                                    )
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: Dimension.Padding,left: Dimension.Padding,right: Dimension.Padding),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 2,
                                        width: 50,
                                        color: Themes.Grey.withAlpha(Dimension.Alpha),
                                        margin: EdgeInsets.only(right: 10),
                                      ),
                                      Text(language.OR,style: TextStyle(color: Themes.Primary,fontSize: 28,fontWeight: Dimension.textMedium),),
                                      Container(
                                        height: 2,
                                        width: 50,
                                        color: Themes.Grey.withAlpha(Dimension.Alpha),
                                        margin: EdgeInsets.only(left: 10),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: Dimension.Padding,left: Dimension.Padding,right: Dimension.Padding),
                                  child: Text(language.SignIn_with_social_media,textAlign: TextAlign.center,style: TextStyle(color: Themes.Text_Color,fontSize: Dimension.Text_Size_Big,fontWeight: Dimension.textMedium),),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: Dimension.Padding,left: Dimension.Padding,right: Dimension.Padding),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                        CircleButton(
                                          loading: authenticationProvider.facebookLoading,
                                          onTap: ()=>authenticationProvider.initiateFacebookLogin(),
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Themes.Primary,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Image.asset('assets/images/facebook.png',color: Themes.White,),
                                          ),
                                        ),
                                      CircleButton(
                                        loading: authenticationProvider.googleLoading,
                                        onTap: ()=>authenticationProvider.onGoogleSignIn(context),
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          margin: EdgeInsets.only(left: Dimension.Padding),
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Themes.Background,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset('assets/images/google.png',),
                                        ),
                                      ),
                                    ],
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

