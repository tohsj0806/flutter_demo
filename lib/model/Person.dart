import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';

class Person{
  int id;
  String name;
  int age;
  bool sex;
  String address;
  String avatar;
  Person({this.id,this.name, this.age,this.sex, this.address,this.avatar});

  Person.fromJson(Map<String, dynamic> json) {
    id =json['id'];
    name = json['name'];
    age = json['age'];
    sex = json['sex'];
    address = json['address'];
    avatar=json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']=this.id;
    data['name'] = this.name;
    data['age'] = this.age;
    data['sex'] = this.sex;
    data['address'] = this.address;
    data['avatar']=this.avatar;
    return data;
  }

  static List<Person> fromJsonArray(jsonArray){
    List<Person> persons =List();
    jsonArray.forEach((personJson)=>{
      persons.add(Person.fromJson(personJson))
    });
    return persons;
  }

}