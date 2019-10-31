import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/fluro_convert_util.dart';
import 'package:flutter_demo/views/main_page.dart';
import 'package:flutter_demo/views/splash_page.dart';
import 'package:flutter_demo/views/demo/home_page.dart';
import 'package:flutter_demo/views/demo/demo_params_page.dart';
import 'package:flutter_demo/views/demo/return_params_page.dart';
import 'package:flutter_demo/views/demo/PersonListPage.dart';
import 'package:flutter_demo/views/demo/PersonDetailPage.dart';
import 'package:flutter_demo/model/Person.dart';

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

var personListHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return PersonListPage();
    }
);

var personDetailHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return PersonDetailPage(Person.fromJson(FluroConvertUtils.string2map(params['personjson'].first)));
    }
);