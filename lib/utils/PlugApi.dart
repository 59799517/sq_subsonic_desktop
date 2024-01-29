import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sq_subsonic_desktop/subsonic/models/PlugSearchResult.dart';

import 'DioManager.dart';

class PlugApi {


  static String login = "/login";
  static String isLogin = "/isLogin";
  static String selectOption = "/set/selectOption";
  static String searchMusic = "/searchMusic";
  static String musicUrl = "/musicUrl";
  static String songInfoById = "/SongInfoById";





  static Future<String> getPlugBaseUrl() async {
    var box = await Hive.openBox("set_server_config");
    return box.get("plug_url");
  }

  static getPlugToken() async {
    var box = await Hive.openBox("set_server_config");
    return box.get("plug_token");
  }


  static checkPlugStatus() async {
     String url = await getPlugBaseUrl();
     var plugToken = await getPlugToken();
     Map<String, dynamic> result = await DioManager.get(url: url+isLogin, headers: {"sqmusic": plugToken});
     if (result["code"]==200) {
      return true;
     }else{
       return false;
     }
  }

  static Future<bool> loginPlug(String ip,String username,String password) async{
    Map<String, dynamic> result = await DioManager.post(url: ip+login, params: {"username": username, "password": password});
    if (result["code"]==200) {
      var box = await Hive.openBox("set_server_config");
      box.put("plug_token", result["data"]["tokenValue"]);
      box.put("plug_url", ip);
      box.put("plug_username", username);
      box.put("plug_password", password);
      getPlugOption();
      return true;
    }else
    {
      return false;
    }
  }

  static getPlugOption() async{
    String url = await getPlugBaseUrl();
    var plugToken = await getPlugToken();
    Map<String, dynamic> result = await DioManager.get(url: url+selectOption, headers: {"sqmusic": plugToken});
    if (result["code"]==200) {
      var box = await Hive.openBox("plug_type");
      List result2 = result["data"];
        result2.forEach((element) {
          if(element["disabled"]==null||element["disabled"]==false){
              box.put(element["label"], element["value"]);
          }
              });

      return result["data"];
    }else{
      return null;
    }
  }

  static Future<PlugSearchResult>  search(String query,{ String type = "kw",int pageNum = 1,int pageSize = 20}) async{
    String url = await getPlugBaseUrl();
    var plugToken =await getPlugToken();
      url = url+searchMusic+"/"+type+"/"+query+"/"+pageSize.toString()+"/"+pageNum.toString();
    Map<String, dynamic> result = await DioManager.get(url: url, headers: {"sqmusic": plugToken});
    if (result["code"]==200) {
      return PlugSearchResult.fromJson(result);
    }else{
      return PlugSearchResult();
    }
  }
  static Future getMusicPlayUrl(String id,{String type = "kw",}) async{
    String url = await getPlugBaseUrl();
    var plugToken =await getPlugToken();
    url = url+musicUrl+"/"+type+"/"+id;
    Map<String, dynamic> result = await DioManager.get(url: url, headers: {"sqmusic": plugToken});
    if (result["code"]==200) {
      return result["data"]["url"];
    }else{
      return "";
    }
  }

  static Future< Map<String, dynamic> > getsongInfoById(String id,{String type = "kw",}) async{
    String url = await getPlugBaseUrl();
    var plugToken =await getPlugToken();
    url = url+songInfoById+"/"+type+"/"+id;
    Map<String, dynamic> result = await DioManager.get(url: url, headers: {"sqmusic": plugToken});
    if (result["code"]==200) {
      return result["data"];
    }else{
      return {};
    }
  }


}
