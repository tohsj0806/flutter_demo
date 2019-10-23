import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_demo/config/app.dart';
import 'package:flutter_demo/config/Routes.dart';

class MyApp extends StatelessWidget {

  MyApp() {
   final router = Router();
   Routes.configureRoutes(router);
   app.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      onGenerateRoute: app.router.generator,
      debugShowCheckedModeBanner: false,
    );
  }
}
