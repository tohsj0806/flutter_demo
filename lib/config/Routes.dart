import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './router_handlers.dart';

class Routes{
  static String root ="/";
  static String main = "/main";
  static String home = "/home";
  static String demoParams = "/demo_params";
  static String returnParams = "/return_params";

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          print("ERROR!!!");
        });
    router.define(root, handler: splashHandler);
    router.define(main, handler: mainHandler);
    router.define(home, handler: homeHandler);
    router.define(demoParams, handler: demoParamHandler);
    router.define(returnParams, handler: returnParamHandler);
  }

}