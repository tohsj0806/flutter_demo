import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/views/demo/home_page.dart';
import 'package:flutter_demo/views/splash_page.dart';

class MainPage extends StatefulWidget{
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin{

  List<Widget> _list = List();
  int _currentIndex = 0;
  List tabData = [
    {'text': '首页', 'icon': Icon(Icons.home)},
    {'text': 'demo', 'icon': Icon(Icons.extension)},
    {'text': '个人中心', 'icon': Icon(Icons.people)},
  ];
  List<BottomNavigationBarItem> _myTabs = [];
  String appBarTitle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appBarTitle = tabData[0]['text'];
    for (int i = 0; i < tabData.length; i++) {
      _myTabs.add(BottomNavigationBarItem(
        icon: tabData[i]['icon'],
        title: Text(
          tabData[i]['text'],
        ),
      ));
    }
    _list
      ..add(HomePage())
      ..add(HomePage())
      ..add(HomePage());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Scaffold(
      appBar: AppBar(
          title: Text(tabData[_currentIndex]['text']),
          centerTitle: true,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _list,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _myTabs,
        currentIndex: _currentIndex,
        onTap: _itemTapped,
        type: BottomNavigationBarType.fixed,
        fixedColor: Theme.of(context).primaryColor,
      ),
    );
  }

  void _itemTapped(int index) {
    setState(() {
      _currentIndex = index;
      appBarTitle = tabData[index]['text'];
    });
  }
}