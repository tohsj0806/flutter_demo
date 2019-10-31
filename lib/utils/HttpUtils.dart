import 'dart:io';
import 'dart:convert';
import 'package:flutter_demo/model/Person.dart';
import 'package:dio/dio.dart';

class HttpUtils {
  static Dio dio = Dio();

  static Future httpGet(String url) async {
    return await dio.get(url);
  }

  static T generateOBJ<T>(json){
    return Person.fromJson(json) as T;
  }

}
