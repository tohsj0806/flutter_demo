import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/fluro_convert_util.dart';
import 'package:flutter_demo/views/main_page.dart';
import 'package:flutter_demo/views/splash_page.dart';
import 'package:flutter_demo/views/home_page.dart';
import 'package:flutter_demo/views/demo_params_page.dart';
import 'package:flutter_demo/views/return_params_page.dart';

var splashHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return SplashPag();
    }
);

var homeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return HomePage();
    }
);

var mainHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return MainPage();
    }
);

var demoParamHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      String name = params["name"]?.first;
      String age = params["age"]?.first;
      String sex = params["sex"]?.first;
      String score = params["score"]?.first;
      String personjson = params['personjson']?.first;
      return DemoParamsPage(
        name: name,
        age: FluroConvertUtils.string2int(age),
        score: FluroConvertUtils.string2double(score),
        sex: FluroConvertUtils.string2bool(sex),
        personJson: personjson,
      );
    });

var returnParamHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return ReturnParamsPage();
    });