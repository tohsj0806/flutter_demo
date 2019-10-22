import 'dart:ui';

class Person{
  String name;
  int age;
  bool sex;
  String address;
  Person({this.name, this.age,this.sex, this.address});

  Person.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    sex = json['sex'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['age'] = this.age;
    data['sex'] = this.sex;
    data['address'] = this.address;
    return data;
  }
}