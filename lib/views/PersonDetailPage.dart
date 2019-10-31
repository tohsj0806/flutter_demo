import 'package:flutter/material.dart';
import 'package:flutter_demo/model/Person.dart';
import 'package:flutter_demo/utils/HttpUtils.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:ui';

class PersonDetailPage extends StatelessWidget {
  Dio _dio=Dio();

  final Person person;

  PersonDetailPage(@required this.person);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData.fallback(),
        title: null,
        backgroundColor: Color.fromARGB(200, 39, 181, 177),
        actions: <Widget>[
          IconButton(
              icon: Image.network(
                  "https://www.easyicon.net/api/resizeApi.php?id=1217848&size=96"),
              onPressed: null)
        ],
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              buildRow1(),
              buildRow2(),
              buildRow3(),
              buildRow4(),

              buildRow5(),
              buildRow6(),
              buildRow7(),
            ],
          ),
          buildRow8(),
        ],
      ),
    );
  }

  Widget buildRow1() {
    return Container(
      padding: EdgeInsets.all(10),
      color: Color.fromARGB(200, 39, 181, 177),
      child: Row(
        children: <Widget>[
          // Expanded(
          // child:
          Container(
            padding: EdgeInsets.all(10),
            child: CircleAvatar(
              backgroundImage: NetworkImage(person.avatar),
              radius: 35,
            ),
            //  ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  person.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Divider(
                  height: 10,
                ),
                Text(
                  (person.sex ? "男" : "女"),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Divider(
                  height: 5,
                ),
                Text(
                  person.address,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: RaisedButton(
                child: Text(
                  "关注",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                color: Color.fromARGB(200, 39, 181, 177),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRow2() {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "11",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      ),
                      Text(
                        "年",
                        style: TextStyle(color: Colors.black38, fontSize: 10),
                      )
                    ],
                  ),
                  Text(
                    "从业年限",
                    style: TextStyle(color: Colors.black38, fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "11",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      ),
                      Text(
                        "年",
                        style: TextStyle(color: Colors.black38, fontSize: 10),
                      )
                    ],
                  ),
                  Text(
                    "回答次数",
                    style: TextStyle(color: Colors.black38, fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "4.9",
                        style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      ),
                      Text(
                        "分",
                        style: TextStyle(color: Colors.orange, fontSize: 10),
                      )
                    ],
                  ),
                  //todo 这里要用星级评分控件
                  Text(
                    "⭐⭐⭐⭐⭐",
                    style: TextStyle(color: Colors.orange, fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRow3() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.1),
          color: Colors.white),
      alignment: Alignment.center,
      //color: Colors.white,
      child: Row(
        children: <Widget>[
          Icon(
            Icons.check_circle_outline,
            size: 20,
          ),
          Text(
            " 医师认证    ",
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          Icon(
            Icons.check_circle_outline,
            size: 20,
          ),
          Text(
            " 平均响应时长：10分钟",
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget buildRow4() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "   擅长疾病",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.left,
              )
            ],
          ),
          Container(
            child:FutureBuilder(
                future: _dio.get("https://gitee.com/crzbird/flutter-demo/raw/master/disease.json"),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //请求完成
                  if (snapshot.connectionState == ConnectionState.done) {
                    Response response = snapshot.data;
                    List<Widget> widgetList = List<Widget>();
                    json.decode(response.data).forEach((disease) => {
                      widgetList.add(
                        Container(
                          
                          child: InkWell(
                            child: Text(disease['disease'],style: TextStyle(color: (disease['tag']?Color.fromARGB(200, 39, 181, 177):Colors.black26)),),
                            onTap: (){
                              print(disease['disease']);
                            },
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50)),border: Border.all(color: Colors.grey)),
                        )
                      )
                    });
                    //发生错误
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    //请求成功，通过项目信息构建用于显示项目名称的ListView
                    return Container(
                      child: GridView.count(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 30,
                        padding: EdgeInsets.all(20),
                        childAspectRatio: 1.5,
                        physics: new NeverScrollableScrollPhysics(),//增加
                        shrinkWrap: true,//增加
                        crossAxisCount: 4,
                        children: widgetList,
                      ),
                    );
                  }
                  //请求未完成时弹出loading
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRow5() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "   个人简介",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.left,
              )
            ],
          ),
          Container(
              child: Text(
            "    个人简介个人简介个人简介个人简介个人简介个人简介个人简介个人简介个人简介个人简介个人简介个人简介个人简介个人简介个人简介个人简介个人简介",
            style: TextStyle(
              color: Colors.black38,
              fontSize: 13,
            ),
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
          ))
        ],
      ),
    );
  }

  Widget buildRow6() {
    return Container(
      alignment: Alignment.center,
      child: InkWell(
        child: Text(
          '更多医生详细信息 >',
          style: TextStyle(color: Colors.black38, fontSize: 14),
        ),
        onTap: () {
          print(111);
        },
      ),
    );
  }

  Widget buildRow7() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "   患者评价",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.left,
              )
            ],
          ),
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Text(
                          "    匿名用户",
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "⭐⭐⭐⭐⭐",
                          style: TextStyle(color: Colors.orange, fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Text(
                    "    评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价评价",
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 100,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRow8(){
    return Container(
      alignment: Alignment.bottomCenter,
      child: new MaterialButton(
        minWidth: window.physicalSize.width,
        height: window.physicalSize.height / 40,
        onPressed: () {
          print(window.physicalSize.height);
        },
        child: Text(
          '向${person.name}提问',
          maxLines: 1,
          style: TextStyle(color: Colors.white),
        ),
        color: Color.fromARGB(200, 39, 181, 177),
      ),
    );
  }

  void buildDiseaseWidget() async {
    Response response =
        await HttpUtils.httpGet("http://10.10.6.165:8081/disease");
    List items = response.data;
  }
}
