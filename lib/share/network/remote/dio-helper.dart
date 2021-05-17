import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> postData({
    @required String url,
    Map<String, dynamic> query,
    @required Map<String, dynamic> data,
    String lang = 'en',
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
    };
    return dio.post(url, data: data);
  }

  static Future<Response> getData({
    @required String endPoint,
    String token,
    String lang = 'en',
    Map<String, dynamic> query,
  }) {
    dio.options.headers={
      'lang':lang,
      'Content-Type': 'application/json',
      'Authorization':token??'',
    };
    return dio.get(endPoint);
  }
}
