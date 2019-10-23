import 'dart:io';
import 'dart:convert';
import 'package:flutter_demo/model/Person.dart';

class HttpUtils{

  static Future listPerson()async{
    HttpClient httpClient = HttpClient();
    Uri uri = Uri(scheme: "http",host: "10.10.6.165",port: 8080,path: "/person");
    HttpClientRequest request = await httpClient.getUrl(uri);
    HttpClientResponse response = await request.close();
    String data = await response.transform(utf8.decoder).join();
    List responseJson = json.decode(data);
    List<Person> persons = List<Person>();
    responseJson.forEach((a)=>{persons.add(Person.fromJson(a))});
    return persons;
  }

}