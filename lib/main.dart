import 'package:flutter/material.dart';
import 'package:flutter_demo/my_app.dart';
import 'package:flutter_demo/utils/HttpUtils.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_demo/model/Person.dart';

void main() => runApp(MyApp());



/*void main(){
  Person person;
  List<Person> persons;
  HttpUtils.httpGet("http://200.200.200.17:9999/person").then((value)=>{
    persons= Person.fromJsonArray(json.decode(value.toString())),
    persons.forEach((p)=>{
      print(p.name)
    })
  });
}*/

