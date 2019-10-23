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
    Observable.timer(0, Duration(seconds: 2)).listen((_) {
      NavigatorUtil.goMainPage(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/open_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
            child: Text('这是第二种写法的欢迎页面！(即将不用)',
                style: TextStyle(fontSize: 22.0, color: Colors.black))),
      ),
    );

    /*   return new DecoratedBox(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage('assets/images/open_bg.jpg'),
          // ...
        ),
        // ...
      ),
    );*/
  }
}
