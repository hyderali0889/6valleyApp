import 'dart:async';
import 'dart:io';
import 'package:geniouscart/Packege/FlushBar/flushbar.dart';
import 'package:geniouscart/Packege/FlushBar/flushbar_helper.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:flutter/foundation.dart';
import 'package:geniouscart/Widgets/ShowMessage.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';

enum Method { POST, GET,PUT,DELETE,PATCH }



class ApiClient2{
  static Map<String,String> header()=>{
    "Accept": "application/json",
    //"Content-Type": "application/json",
    'Authorization':'${AppConstant.Bearer} ${auth.data.token}'
  };
  


  static Future Request(BuildContext context,{@required String url,Method method=Method.GET,var body,@required Function onSuccess,@required Function onError,bool enableShowError=true})async{
    try{
      var response;
      if(method==Method.POST)
      {
        response = await http.post(Uri.parse(url),body: body, headers: header());
      }
      else if(method==Method.DELETE){
        response = await http.delete(Uri.parse(url), headers: header());
      }
      else if(method==Method.PATCH){
        response = await http.patch(Uri.parse(url), headers: header(),body: body);
      }
      else{
        response = await http.get(Uri.parse(url), headers: header());
      }
      showData(url: url,response: response.body,body: body,method: method,header: header());
      var data=json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 422) {
        if(data[AppConstant.success]==true || data[AppConstant.status]==true)
          onSuccess(data);
        else {
          if(enableShowError)
            ErrorMessage(context,message: data[AppConstant.message] ?? data[AppConstant.error][AppConstant.message] ?? data[AppConstant.error]);
          onError(data);
        }
      }
      else if(response.statusCode == 401){
        //CheckAuthentication(data,context);
        onError(data);
      }
      else {
        if(enableShowError)
        ErrorMessage(context,message: language.Something_went_wrong);
        onError({'error': language.Something_went_wrong});
      }
    } on TimeoutException catch (e) {
      if(enableShowError)
      ErrorMessage(context,message: language.Check_Your_Internet_Connection);
      onError({'error': language.Check_Your_Internet_Connection});
    } on SocketException catch (e) {
      if(enableShowError)
      ErrorMessage(context,message: language.Check_Your_Internet_Connection);
      onError({'error': language.Check_Your_Internet_Connection});
    } on Error catch (e) {
      if(enableShowError)
      ErrorMessage(context,message: language.Check_Your_Internet_Connection);
      onError({'error': language.Check_Your_Internet_Connection});
    }
  }


  static Future RequestWithFile(BuildContext context,{@required String url,Map<String,String> body,List<String> fileKey,List<File> files,Method method=Method.POST,@required Function onSuccess,@required Function onError,bool enableShowError=true})async{
    var result;
    var uri = Uri.parse(url);
    var request ;
    if(method==Method.POST){
      request = new http.MultipartRequest("POST", uri)..fields.addAll(body)..headers.addAll(header());
    }
    else if(method==Method.PATCH){
      request = new http.MultipartRequest("PATCH", uri)..fields.addAll(body)..headers.addAll(header());
    }
    else if(method==Method.PATCH){
      request = new http.MultipartRequest("PATCH", uri)..headers.addAll(header())..fields.addAll(body);
    }


    for(int i=0;i<fileKey.length;i++){
      var stream = new http.ByteStream(DelegatingStream.typed(files[i].openRead()));
      var length = await files[i].length();
      var multipartFile = new http.MultipartFile(fileKey[i], stream, length, filename: basename(files[i].path));
      request.files.add(multipartFile);
    }
    var response;
    try {
      response= await request.send();
      if (response.statusCode == 200 || response.statusCode == 401 || response.statusCode == 422) {
        await response.stream.transform(utf8.decoder).listen((value) {
          result = value;
        });
        showData(body: body,method: method,response: result,url: url,header: header());
        var data;
        try{
          data=jsonDecode(result);
          if(data[AppConstant.success]==true || data[AppConstant.status]==true)
            onSuccess(data);
          else {
            if(enableShowError)
              ErrorMessage(context,message: data[AppConstant.message]);
            onError(data);
          }
        }catch(e){
          onSuccess(result);
        }

      }
      else if (response.statusCode == 413) {
        if(enableShowError)
          ErrorMessage(context,message: language.File_to_large);
          onError({'error': language.Something_went_wrong});
      }
      else {
        if(enableShowError)
          ErrorMessage(context,message: language.Something_went_wrong);
        onError({'error': language.Something_went_wrong});
      }
    }on TimeoutException catch (e) {
      if(enableShowError)
        ErrorMessage(context,message: language.Check_Your_Internet_Connection);
      onError({'error': language.Check_Your_Internet_Connection});
    } on SocketException catch (e) {
      if(enableShowError)
        ErrorMessage(context,message: language.Check_Your_Internet_Connection);
      onError({'error': language.Check_Your_Internet_Connection});
    } on Error catch (e) {
      if(enableShowError)
        ErrorMessage(context,message: language.Check_Your_Internet_Connection);
      onError({'error': language.Check_Your_Internet_Connection});
    }
  }


  static Future SimpleRequest(BuildContext context,{@required String url,Method method=Method.GET,Map<String , dynamic> body,@required Function onSuccess,@required Function onError,bool enableShowError=true,bool isThirdPartyApi=false})async{
    var response;
    try{
      if(method==Method.POST)
      {
        response = await http.post(Uri.parse(url),body: body,);
      }
      else if(method==Method.DELETE){
        response = await http.delete(Uri.parse(url), );
      }
      else if(method==Method.PATCH){
        response = await http.patch(Uri.parse(url),body:body);
      }
      else{
        response = await http.get(Uri.parse(url));
      }
      showData(url: url,response: response.body,body: body,method: method);
      if (response.statusCode == 200 || response.statusCode == 401 || response.statusCode == 422) {
        var data=json.decode(response.body);
        if(!isThirdPartyApi){
          if(data[AppConstant.success]==true || data[AppConstant.status]==true)
            onSuccess(data);
          else {
            if(enableShowError)
              ErrorMessage(context,message: data[AppConstant.message] ?? data[AppConstant.error]);
            onError(data);
          }
        }
        else{
          onSuccess(data);
        }
      } else {
        if(enableShowError)
        ErrorMessage(context,message: language.Something_went_wrong);
        onError({'error': language.Something_went_wrong});
      }
    }
    catch(e){
      if(enableShowError)
      ErrorMessage(context,message: language.Something_went_wrong);
      onError({'error': language.Check_Your_Internet_Connection});
    }
  }

  static CheckAuthentication(var data,BuildContext context){
    Map<String,dynamic> response=data;
    if(response.containsKey(AppConstant.error)){
      if(response[AppConstant.error]==AppConstant.Unauthorized){
        prefs.clear();
        FlushbarHelper.createError(message: response[AppConstant.error],position: FlushbarPosition.TOP)..show(context).then((value) => Navigator.of(context)
            .pushNamedAndRemoveUntil(ONBOARD, (Route<dynamic> route) => false));
      }
    }
    return data;
  }


  static void showData({String url, var body,Map<String, dynamic> header, String response,Method method}) {
    if (kDebugMode) {
      print("URL = $url");
      print("Body = $body");
      print("Header = $header");
      print("Method = $method");
      print("Response = $response");
    }
  }

}

