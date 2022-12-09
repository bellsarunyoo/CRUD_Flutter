import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bell_api/main.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';

class NewData extends StatefulWidget {
  @override
  _NewDataState createState() => _NewDataState();
}

class _NewDataState extends State<NewData> {
  TextEditingController cname = new TextEditingController();
  TextEditingController cage = new TextEditingController();
  void addData() {
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.CreateEndpoint);
    http.post(url, body: {
      "name": cname.text,
      "age": cage.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Data"),
      ),
      body: ListView(
        children: [
          TextField(
            controller: cname,
            decoration: InputDecoration(
                hintText: "Enter Name", labelText: "Enter Name"),
          ),
          TextField(
            controller: cage,
            decoration:
                InputDecoration(hintText: "Enter age", labelText: "Enter age"),
          ),
          MaterialButton(
            child: Text("Add Data"),
            color: Colors.red,
            onPressed: () {
              addData();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => Home()),
              );
            },
          ),
        ],
      ),
    );
  }
}
