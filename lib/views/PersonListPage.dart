import 'package:flutter/material.dart';
import 'package:flutter_demo/model/Person.dart';
import 'package:flutter_demo/utils/HttpUtils.dart';
import 'package:flutter_demo/views/PersonDetailPage.dart';
import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_demo/config/NavigatorUtil.dart';
import 'package:flutter_demo/PersonCache.dart';

class PersonListPage extends StatefulWidget {
  @override
  _PersonListPage createState() => new _PersonListPage();
}

class _PersonListPage extends State<PersonListPage> {
  Dio _dio = Dio();
  List<Person> _personList = new List(); //列表要展示的数据
  ScrollController _scrollController = ScrollController(); //listview的控制器
  int _page = 1; //加载的页数
  int _size = 5; //加载的每页数量
  bool isLoading = true; //是否正在加载数据

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState");
    initData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        _getMore();
      }
    });
  }

  /**
   * 初始化list数据 加延时模仿网络请求
   */
  Future initData() async {
    await _dio.get("http://200.200.200.17:9999/person/1/10").then((data) => {
          setState(() {
            _personList = Person.fromJsonArray(json.decode(data.toString()));
          }),
          _page = 3,
          isLoading = false
        });
  }

  @override
  Widget build(BuildContext context) {
    personCache=_personList;
    return new Scaffold(
      appBar: AppBar(
          title:Text('PersonListPage'),
          actions:<Widget>[
            IconButton(
                icon:Icon(Icons.search),
                onPressed: (){
                  showSearch(context:context,delegate: searchBarDelegate());
                }
              // showSearch(context:context,delegate: searchBarDelegate()),
            ),
          ]
      ),
      body: RefreshIndicator(
        onRefresh: initData,
        child: ListView.builder(
          itemBuilder: _renderRow,
          itemCount: _personList.length + 1,
          controller: _scrollController,
          physics: AlwaysScrollableScrollPhysics(),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _renderRow(BuildContext context, int index) {
    if (index < _personList.length) {
      return ListTile(
        title: Text(
          'id:${_personList[index].id}--姓名：${_personList[index].name}--年龄:${_personList[index].age}',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: new Text('地址：${_personList[index].address}'),
        leading: new Icon(
          Icons.account_box,
          color: Colors.lightBlue,
        ),
        onTap: () {
          NavigatorUtil.goPersonDetailPage(context,_personList[index]);
         /* Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => new PersonDetailPage(
                      Person.fromJson(_personList[index]))));*/
        },
      );
    }
    if (isLoading) {
      return _isLoadingWidget();
    }
    return Center(child: Text("到底了！拉不动了！"),);
  }

  /**
   * 上拉加载更多
   */
  Future _getMore() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      await _dio
          .get("http://200.200.200.17:9999/person/${_page}/${_size}")
          .then((data) {
        setState(() {
          _personList.addAll(Person.fromJsonArray(json.decode(data.toString())));
          _page++;
          isLoading = false;
        });
      });
    }
  }

  /**
   * 加载更多时显示的圈圈
   */
  Widget _isLoadingWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'loading...',
              style: TextStyle(fontSize: 16.0),
            ),
            CircularProgressIndicator(
              strokeWidth: 1.0,
              backgroundColor: Colors.redAccent,
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }
}


class searchBarDelegate extends SearchDelegate<String>{

  Dio _dio =Dio();

  @override
  List<Widget> buildActions(BuildContext context){
    return [
      IconButton(
        icon:Icon(Icons.clear),
        onPressed: ()=>query = "",)
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {



    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: _dio.get("http://200.200.200.17:9999/person/search?namelike=${query}"),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //请求完成
          if (snapshot.connectionState == ConnectionState.done) {
            Response response = snapshot.data;
            List<Widget> widgetList = List<Widget>();
            json.decode(response.data).forEach((person) => {
              widgetList.add(Container(
                child: ListTile(
                  title: new Text('姓名：${person['name']}',
                    style: TextStyle(fontWeight: FontWeight.w500),),
                  subtitle: new Text('地址：${person['address']}'),
                  leading: new Icon(
                    Icons.account_box, color: Colors.lightBlue,),
                  onTap: () {
                    NavigatorUtil.goPersonDetailPage(context, Person.fromJson(person));
                  },
                ),
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: new Border.all(//添加边框
                    width: 1.0,//边框宽度
                    color: Colors.grey,//边框颜色
                  ),
                  borderRadius: new BorderRadius.all(Radius.circular(5.0)),//设置圆角

                ),

              )
              ),widgetList.add(Divider(height: 1.0,indent: 0.0,color: Colors.grey,),)
            });
            //发生错误
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            //请求成功，通过项目信息构建用于显示项目名称的ListView
            return ListView(
              children: widgetList,
            );
          }
          //请求未完成时弹出loading
          return Center(
            child: CircularProgressIndicator(),
          );
        }
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Person> suggestionList = query.isEmpty
        ? List()
        : personCache.where((person) => person.name.startsWith(query)).toList();
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) => ListTile(
          onTap: (){
            NavigatorUtil.goPersonDetailPage(context, suggestionList[index]);
          },
          title: RichText(
              text: TextSpan(
                  text: suggestionList[index].name.substring(0, query.length),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: suggestionList[index].name.substring(query.length),
                        style: TextStyle(color: Colors.grey))
                  ])),
        ));
  }

}
