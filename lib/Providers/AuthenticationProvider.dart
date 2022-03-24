import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:geniouscart/Class/Auth.dart';
import 'package:geniouscart/Class/FacebookResponse.dart';
import 'package:geniouscart/Class/User.dart';
import 'package:geniouscart/Providers/MainPageProvider.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/URL/Api_Client.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/Widgets/KeyboardHandler.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';
import 'package:geniouscart/main.dart';
import 'package:http/http.dart' as http;

class AuthenticationProvider with ChangeNotifier{

  bool isHaveAppBar=false;

  final GoogleSignIn googleSignInState = GoogleSignIn(scopes: [
    'email',
    //'https://www.googleapis.com/auth/contacts.readonly',
  ],);
  GoogleSignInAccount currentUser;
  bool isGoogleUserSignedIn=false;

  bool isLoggedIn = false;
  FacebookResponse facebookProfileData;
  var facebookLogin = FacebookLogin();
  BuildContext context;

  MainPageProvider mainPageProvider;

  GlobalKey<FormState> fromKey=GlobalKey();
  GlobalKey<ScaffoldState> scaffoldKey=GlobalKey();

  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  bool hidePassword=true;

  Map<String,String> requestBody={};

  bool Loading=false,googleLoading=false,facebookLoading=false;

  AuthenticationProvider(){
      googleSignInState.signOut();
      facebookLogin.logOut();
      checkGoogleUser();
  }

  /*Google Login*/
  void checkGoogleUser() async {
    var userSignedIn = await googleSignInState.isSignedIn();
    isGoogleUserSignedIn = userSignedIn;
    googleSignInState.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      currentUser = account;
      if (currentUser != null) {
        handleGetContact(currentUser);
      }
    });
    googleSignInState.signInSilently();
    notifyListeners();
  }

  Future<void> handleGetContact(GoogleSignInAccount user) async {
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data = json.decode(response.body);
  }



  Future<GoogleSignInAccount> googleSignIn() async {
    GoogleSignInAccount user;
    bool userSignedIn = await googleSignInState.isSignedIn();

    isGoogleUserSignedIn = userSignedIn;
    notifyListeners();

    if (isGoogleUserSignedIn) {
      user = googleSignInState.currentUser;
    }
    else {
      try{
        final GoogleSignInAccount googleUser = await googleSignInState.signIn();
        print(googleUser.displayName);
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        user = googleSignInState.currentUser;
        userSignedIn = await googleSignInState.isSignedIn();
        isGoogleUserSignedIn = userSignedIn;
        notifyListeners();
      }catch(e){
        print(e);
      }
    }

    return user;
  }
  void onGoogleSignIn(BuildContext context) async {
     try{
       GoogleSignInAccount user = await googleSignIn();
       print('User = ${user.email}');
       print('_googleSignIn = ${googleSignInState.clientId}');
       notifyListeners();
       if(user!=null){
         googleLoading=true;
         notifyListeners();
         getToken(URL.Social_Login, body: {
           AppConstant.name:user.displayName,
           AppConstant.email:user.email,
         });
       }
     }catch(e){
        //ErrorMessage(context,message: language.Something_went_wrong);
     }
  }
  /*Google Login*/
  
  /*Facebook Login*/
  void onLoginStatusChanged(bool isLoggedIn, {FacebookResponse profileData}) {
      this.isLoggedIn = isLoggedIn;
      this.facebookProfileData = profileData;
      notifyListeners();
  }
  void initiateFacebookLogin() async {
    var facebookLoginResult =await facebookLogin.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.success:
      /*// Logged in

      // Send access token to server for validation and auth
        final FacebookAccessToken accessToken = facebookLoginResult.accessToken;
        print('Access token: ${accessToken.token}');

        // Get profile data
        final profile = await facebookLogin.getUserProfile();
        print('Hello, ${profile.name}! You ID: ${profile.userId}');

        // Get user profile image url
        final imageUrl = await facebookLogin.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');

        // Get email (since we request email permission)
        final email = await facebookLogin.getUserEmail();
        // But user can decline permission
        if (email != null)
          print('And your email is $email');*/

        facebookLoading=true;
        notifyListeners();
        var graphResponse = await Api_Client.SimpleRequest(url: 'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult
            .accessToken.token}');
        try{
          FacebookResponse data=FacebookResponse.fromJson(graphResponse);
          onLoginStatusChanged(true, profileData: data);
          getToken(URL.Social_Login, body: {
            AppConstant.name:data.name,
            AppConstant.email:data.email,
          });
        }catch(e){
          facebookLoading=false;
          notifyListeners();
          ErrorMessage(context,message: language.Something_went_wrong);
        }

        break;
      case FacebookLoginStatus.cancel:
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.error:
        onLoginStatusChanged(false);
        print('Error while log in: ${facebookLoginResult.error}');
        break;
    }
  }
  /*Facebook Login*/

  void changePasswordState(){
    hidePassword=!hidePassword;
    notifyListeners();
  }
  String makeRequestData(){
    requestBody.clear();
    requestBody={
      AppConstant.email:email.text,
      AppConstant.password:password.text
    };
    return URL.Login;
  }

  KeyboardActionsConfig configuration() {
    return KeyboardActionsConfig(
      keyboardSeparatorColor: Colors.transparent,
      actions: [

      ],
    );
  }

  
  Future requestAuth()async{
    Loading=true;
    notifyListeners();
    getToken(makeRequestData(),body: requestBody);
  }

  Future getToken(String url,{@required Map<String,String>body})async{
    Map<String,dynamic> response=await Api_Client.SimpleRequest(url: url,method: Method.POST,body: body);
    try {
      if (response.containsKey(AppConstant.status) && response[AppConstant.status]==true) {
        auth=Auth.fromJson(response);
        user=auth.data.user;
        userType=user.type;
        isVendor=userType==AppConstant.Type_Vendor;
        prefs.setString(AppConstant.Share_Auth, json.encode(response));
        if(isHaveAppBar){
          Navigator.of(context).pop(true);
        }
        else
          mainPageProvider.Refresh();
      }
      else if(response.containsKey(AppConstant.Error)) {
        try{
          ErrorMessage(context,message: response[AppConstant.Error][AppConstant.message]);
        }
        catch(e){
          ErrorMessage(context,message: response[AppConstant.Error]);
        }
        Loading=false;
        facebookLoading=false;
        googleLoading=false;
      }
    } catch (e) {
      ErrorMessage(context,message: response[AppConstant.Error]);
      Loading=false;
      facebookLoading=false;
      googleLoading=false;
    }
    notifyListeners();
  }

  void setView(BuildContext context) {
    this.context=context;
    Api_Client.config(context);
  }

  void goForSignUp() {
    if(isHaveAppBar){
      Navigator.of(context).pushReplacementNamed(REGISTER,arguments: isHaveAppBar);
    }else{
      mainPageProvider.changeAuthPage(status: false);
    }
  }

}