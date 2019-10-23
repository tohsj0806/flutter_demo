import 'package:flutter/cupertino.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/config/Routes.dart';
import 'package:flutter_demo/config/app.dart';
import 'package:flutter_demo/model/Person.dart';
import 'package:flutter_demo/utils/fluro_convert_util.dart';

class NavigatorUtil {

  static void goBack(BuildContext context) {
    /// 调用的是 Navigator.pop(context);
    app.router.pop(context);
  }

  static void goMainPage(BuildContext context) {
    app.router.navigateTo(context, Routes.main, replace: true);
  }

  static void goHomePage(BuildContext context) {
   app.router.navigateTo(context, Routes.home, replace: true);
  }

  static void goDemoParamsPage(BuildContext context, String name, int age,
      double score, bool sex, Person person) {
    String mName = FluroConvertUtils.fluroCnParamsEncode(name);
    String personJson = FluroConvertUtils.object2string(person);
    app.router.navigateTo(
        context,
        Routes.demoParams +
            "?name=$mName&age=$age&score=$score&sex=$sex&personjson=$personJson");
  }

  static Future goReturnParamsPage(BuildContext context) {
    return app.router.navigateTo(context, Routes.returnParams);
  }

  static void goBackWithParams(BuildContext context, result) {
    Navigator.pop(context, result);
  }
}
