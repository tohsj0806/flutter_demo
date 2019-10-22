import 'package:flutter_demo/config/NavigatorUtil.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SplashPag extends StatefulWidget {
  @override
  _SplashPagState createState() => _SplashPagState();
}

class _SplashPagState extends State<SplashPag> {

  @override
  void initState() {
//    Future.delayed(Duration(seconds: 5),(){
//      NavigatorUtil.goHomePage(context);
//    });
    /// 上面注释的代码也可以做到倒计时
    Observable.timer(0, Duration(seconds: 2)).listen((_){
      NavigatorUtil.goHomePage(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return new DecoratedBox(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage('assets/images/open_bg.jpg'),
          // ...
        ),
        // ...
      ),
    );
  }
}
