import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bell_api/main.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';

class Edit extends StatefulWidget {
  final List list;
  final int index;

  Edit({required this.list, required this.index});

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  late TextEditingController cname;
  late TextEditingController cage;

  void editData() {
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.UpdateEndpoint);
    http.post(url, body: {
      'id': widget.list[widget.index]['id'].toString(),
      'name': cname.text,
      'age': cage.text,
    });
  }

  @override
  void initState() {
    cname = TextEditingController(text: widget.list[widget.index]['name']);
    cage = TextEditingController(
        text: widget.list[widget.index]['age'].toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Data ${widget.list[widget.index]['name']}"),
      ),
      body: Center(
        child: ListView(
          children: [
            TextField(
              controller: cname,
              decoration: InputDecoration(
                  hintText: "Enter Name", labelText: "Enter Name"),
            ),
            TextField(
              controller: cage,
              decoration: InputDecoration(
                  hintText: "Enter Age", labelText: "Enter Age"),
            ),
            MaterialButton(
              child: Text("Edit Data"),
              onPressed: () {
                editData();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) => Home()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
