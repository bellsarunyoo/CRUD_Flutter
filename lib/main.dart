import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'constants.dart';
import 'details.dart';
import 'newdata.dart';

void main() => runApp(MaterialApp(
      title: "Api Test",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

Map headers = {
  'content-type': 'application/json',
  'accept': 'application/json',
  'authorization': 'basicAuth'
};

class _HomeState extends State<Home> {
  Future<List> getData() async {
    String username = 'admin';
    String password = 'admin';
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$username:$password'))}';
    // log(basicAuth.toString());
    Uri url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
    Response responce = await http.get(url);
    // Response responce =
    //     await http.post(url, headers: {'authorization': basicAuth});

    log(responce.toString());
    // log(responce.body.toString());
    // log(responce.statusCode.toString());s
    // if (responce.statusCode == 200) {
    //   return jsonDecode(responce.body);
    // } else {
    //   return jsonDecode(responce.statusCode.toString());
    // }
    return jsonDecode(responce.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My App Bar"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext contex) => NewData(),
          ),
        ),
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.hasData);
            return Items(list: snapshot.requireData);
            // return Text('${snapshot.data}');
            // list dataList = snapshot.data ;
            // return ListView.builder(
            //     itemCount: dataList.length,
            //     itemBuilder: (context, index) {
            //       return Text(dataList[index].name);
            //     });
          } else if (snapshot.hasError) {
            // handle error here
            return Text('${snapshot.error}');
          } else {
            return CircularProgressIndicator(); // displays while loading data
          }

          // if (ss.hasError) {
          //   print("error");
          // }
          // if (ss.hasData) {
          //   return Items(list: '');
          // } else {
          //   return CircularProgressIndicator();
          // }
        },
      ),
    );
  }
}

class Items extends StatelessWidget {
  List list;

  Items({required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (ctx, i) {
          return ListTile(
            leading: Icon(Icons.message),
            title: Text(list[i]['name']),
            subtitle: Text(list[i]['age'].toString()),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => Details(list: list, index: i),
            )),
          );
        });
  }
}

class Student {
  final int id;
  String name, age;
  Student({required this.id, required this.name, required this.age});
  factory Student.fromJson(Map<String, dynamic> json) =>
      Student(id: json['id'], name: json['name'], age: json['age']);
}
