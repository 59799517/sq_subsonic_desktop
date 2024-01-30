import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
enum DioMethod {
  get,
  post,
  put,
  delete,
}
class DioManager  {
  static final dio = Dio(BaseOptions(
    connectTimeout: Duration(seconds: 5),
    receiveTimeout: Duration(seconds: 3),
    receiveDataWhenStatusError: true
  ),);

  DioManager(){
    dio.interceptors.add( InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        // 如果你想完成请求并返回一些自定义数据，你可以使用 `handler.resolve(response)`。
        // 如果你想终止请求并触发一个错误，你可以使用 `handler.reject(error)`。
        return handler.next(options);
      },
      onResponse: ( response, ResponseInterceptorHandler handler) {
        // 如果你想终止请求并触发一个错误，你可以使用 `handler.reject(error)`。
        if (response.statusCode == 200) {
          if(response.data is String){
            if(json.decode(response.data) is Map){
                if(json.decode(response.data)["subsonic-response"]["status"]=="ok" ){
                  return handler.next(response);
                }else{
                  Get.snackbar("提示", json.decode(response.data)["subsonic-response"]["error"]["message"]);
                }
            }
          }
          return handler.next(response);
        }else{
         Get.snackbar("提示", "请求失败");
        }
        return handler.next(response);
      },
      onError: (DioException error, ErrorInterceptorHandler handler) {
        // 如果你想完成请求并返回一些自定义数据，你可以使用 `handler.resolve(response)`。
        return handler.next(error);
      },
    ),);

  } // With default `Options`.



  /// get请求
  static Future get({@required String? url, Map<String, dynamic>? params,Map<String, dynamic>? headers}) async {
    return await requestHttp(url!, method: DioMethod.get, params: params,headers:headers);
  }

  /// post 请求
  static Future post({@required String? url, Map<String, dynamic>? params,Map<String, dynamic>? headers}) async {
    return await requestHttp(url!, method: DioMethod.post, params: params,headers:headers);
  }

  /// put 请求
  static  Future put({@required String? url, Map<String, dynamic>? params}) async {
    return await requestHttp(url!, method: DioMethod.put, params: params);
  }

  /// delete 请求
  static Future delete({ @required String? url, Map<String, dynamic>? params}) async {
    return await requestHttp(url!, method: DioMethod.delete, params: params);
  }

//二进制流
  static Future<Uint8List> getData({ @required String? url, Map<String, dynamic>? params}) async {
    try {
      var response = await Dio().get(
        url!,
        queryParameters: params,
        options: Options(responseType: ResponseType.stream),
      );
      final stream = await (response.data as ResponseBody).stream.toList();
      final result = BytesBuilder();
      for (Uint8List subList in stream) {
        result.add(subList);
      }
      return result.takeBytes();
    } on DioError catch (_) {
      rethrow;
    }
  }


  static Future requestHttp(String url, {DioMethod method = DioMethod.get, Map<String, dynamic>? params,Map<String, dynamic>? headers}) async {
    const methodValues = {
      DioMethod.get: 'get',
      DioMethod.post: 'post',
      DioMethod.delete: 'delete',
      DioMethod.put: 'put'
    };

    // 添加 token
    // TokenModel tokenModel = await SpUtil().loadToken();
    // if (tokenModel.userToken != null) {
    //   _dio.options.headers = {'Authorization': 'Bearer ' + tokenModel.userToken};
    // }
    try {
      var response;
      // 不同请求方法，不同的请求参数。按实际项目需求分，这里 get 是 queryParameters，其它用 data. FormData 也是 data
      // 注意: 只有 post 方法支持发送 FormData.
      switch (method) {
        case DioMethod.get:
          response = await dio.request(url, queryParameters: params, options: Options(method: methodValues[method],headers:headers));
          break;
        default:
          response = await dio.request(url, data: params, options: Options(method: methodValues[method],headers:headers));
      }

      // JSON 序列化, Response<dynamic> 转 Map<String, dynamic>
      String jsonStr = json.encode(response.data);
      Map<String, dynamic> map = json.decode(jsonStr);

      return map;

    } on Error catch (e) {
//      throw e;
//      print('DioError--- ${e.type}');
      // 出现错误都返回空，错误在 OnErrorInterceptors 类处理。
      return null;
    }
  }


}
