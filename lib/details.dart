import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bell_api/editdata.dart';
import 'package:bell_api/main.dart';
import 'constants.dart';
import 'package:http/http.dart' as http;

class Details extends StatefulWidget {
  List list;
  int index;

  Details({required this.list, required this.index});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  void delete() {
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.DeleteEndpoint);
    http.post(url, body: {
      'id': widget.list[widget.index]['id'].toString(),
    });
  }

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content: Text("Are You Sure?"),
      actions: [
        MaterialButton(
          child: Text("OK DELETE"),
          onPressed: () {
            delete();
            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => Home()));
          },
        ),
        MaterialButton(
          child: Text("CANCEL"),
          onPressed: () {},
        ),
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.list[widget.index]['name']}'),
      ),
      body: Container(
        child: Column(
          children: [
            Text(
              widget.list[widget.index]['name'].toString(),
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              widget.list[widget.index]['age'].toString(),
            ),
            MaterialButton(
              child: Text("Edit"),
              color: Colors.deepPurpleAccent,
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        Edit(list: widget.list, index: widget.index)),
              ),
            ),
            MaterialButton(
                child: Text("Delete"),
                color: Colors.deepPurpleAccent,
                onPressed: () {
                  confirm();
                })
          ],
        ),
      ),
    );
  }
}
