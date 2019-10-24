import 'package:flutter/material.dart';
import 'package:flutter_demo/model/Person.dart';
import 'package:flutter_demo/views/demo/PersonDetailPage.dart';
import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';

class PersonListPage extends StatelessWidget {
  Dio _dio = new Dio();

  @override
  Widget build(BuildContext context) {
    print("personListpage");
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text(
        "person list", style: TextStyle(fontWeight: FontWeight.w500),),),
      body: FutureBuilder(
          future: _dio.get("http://10.10.6.165:8080/person"),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //请求完成
            if (snapshot.connectionState == ConnectionState.done) {
              Response response = snapshot.data;
              List<Widget> widgetList = List<Widget>();
              response.data.forEach((person) => {
                widgetList.add(Container(
                  child: ListTile(
                    title: new Text('姓名：${person['name']}',
                      style: TextStyle(fontWeight: FontWeight.w500),),
                    subtitle: new Text('地址：${person['address']}'),
                    leading: new Icon(
                      Icons.account_box, color: Colors.lightBlue,),
                    onTap: () {

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
            return CircularProgressIndicator();
          }
      ),
    );
  }
}
