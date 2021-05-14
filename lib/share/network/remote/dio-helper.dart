import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,
          headers: {
            'Content-Type': 'application/json',
          }),
    );
  }

  static Future<Response> postData({
    @required String url,
    Map<String, dynamic> query,
    @required Map<String, dynamic> data,
    String lang='en',
  }) async {
    dio.options.headers={
      'lang':lang
    };
    return dio.post(url,data: data);
  }
}
