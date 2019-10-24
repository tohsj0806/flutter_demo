import 'package:flutter/material.dart';
import 'package:flutter_demo/model/Person.dart';

class PersonDetailPage extends StatelessWidget{
  final Person person;

  PersonDetailPage({Key key,@required this.person}):super(key:key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text(person.name),),
      body: Center(
        child: CircleAvatar(
          child: Text(person.name,style: TextStyle(color: Colors.lightBlue),),
          backgroundImage: NetworkImage("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1571745055214&di=7a17bb983a4f1275e5fc9bd66cf8e76e&imgtype=0&src=http%3A%2F%2Fpic.90sjimg.com%2Fdesign%2F01%2F54%2F03%2F90%2F5930149711114.png"),
          radius: 100.0,
        ),
      ),
    );
  }
  
}