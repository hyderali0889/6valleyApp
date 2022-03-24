import 'dart:async';
import 'dart:io';
import 'package:geniouscart/Packege/FlushBar/flushbar.dart';
import 'package:geniouscart/Packege/FlushBar/flushbar_helper.dart';
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/URL/AppConstant.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:geniouscart/URL/URL.dart';
import 'package:geniouscart/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';

enum Method { POST, GET,PUT,DELETE,PATCH }



class Api_Client{
  static BuildContext context;
  static Map<String,String> header()=>{
    "Accept": "application/json",
    //"Content-Type": "application/json",
    'Authorization':'${AppConstant.Bearer} ${auth.data.token}'
  };
  


  static config(BuildContext context){
    Api_Client.context=context;
  }

  static Future Request({@required String url,Method method=Method.GET,var body})async{
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
      if (response.statusCode == 200 || response.statusCode == 401 || response.statusCode == 404) {
        return json.decode(response.body);
      } else {
        return{
          'error': language.Something_went_wrong
        };
      }
    }
    catch(e){
      return{
        'error': language.Check_Your_Internet_Connection
      };
    }
  }

  static Future getOrder({@required String url}) async{
    var response;
    try {
      response = await http.get(Uri.parse(url), headers: header());
      showData(url: url,response: response.body,method: Method.GET);
      if (response.statusCode == 200 || response.statusCode == 401 ) {
        return json.decode(response.body);
      } else {
        FlushbarHelper.createError(message: language.Something_went_wrong,position: FlushbarPosition.TOP)..show(context);
        return response.body;
      }
    }
    catch(e){
      return{
        'error': language.Check_Your_Internet_Connection
      };
    }

  }

  static Future RequestWithFile({@required String url,Map<String,dynamic> body,List<String> fileKey,List<File> files,Method method=Method.POST})async{
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
      if (response.statusCode == 200 || response.statusCode == 401  || response.statusCode == 422 )
      {
        await response.stream.transform(utf8.decoder).listen((value) {
          result = value;
        });
        showData(body: body,method: method,response: result,url: url,header: header());
        return json.decode(result);
      }
      else{
        return{
          'error': language.Something_went_wrong
        };
      }
    }
    catch(e) {
      return{
        'error': language.Check_Your_Internet_Connection
      };
    }
  }


  static Future SimpleRequest({@required String url,Method method=Method.GET,Map<String , dynamic> body})async{
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
        return json.decode(response.body);
      } else {
        return{
          'error': language.Something_went_wrong
        };
      }
    }
    catch(e){
      return{
        'error': language.Check_Your_Internet_Connection
      };
    }
  }





  static Future Request_Login(String url,{Map<String , dynamic> body})async{
    var response;
    try{
      response = await http.post(Uri.parse(url),body: body);
      showData(url : url,body : body , response : response.body,method: Method.POST);
      if (response.statusCode == 200 || response.statusCode == 401 || response.statusCode==422) {
        return json.decode(response.body);
      } else {
        return{
          'error': language.Something_went_wrong
        };
      }
    }
    catch(e){
      return{
        'error': language.Check_Your_Internet_Connection
      };
    }
  }

/*  static CheckAuthentication(var data,BuildContext context){
    Map<String,dynamic> response=data;
    *//*if(response.containsKey(AppConstant.data)){
      if(response[AppConstant.title]==AppConstant.Unauthorized){
        data.remove(AppConstant.Error);
        FlushbarHelper.createError(message: response[AppConstant.title],position: FlushbarPosition.TOP)..show(context);
        prefs.clear();
        Timer(const Duration(milliseconds: 1000), () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(ONBOARD, (Route<dynamic> route) => false);
        });
      }
    }*//*
    return data;
  }*/


  static void showData({String url, var body,Map<String, dynamic> header, String response,Method method}) {
    if (!kReleaseMode) {
      print("URL = $url");
      print("Body = $body");
      print("Header = $header");
      print("Method = $method");
      print("Response = $response");
    }
  }

}

