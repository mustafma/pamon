import 'package:BridgeTeam/services/crud.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  final String text;
  final handleYesButton;
  final handleNoButton;
  CrudMethods crudObj = new CrudMethods();
  CustomDialog(
      {@required this.text, this.handleYesButton, this.handleNoButton});
  _CustomDialog createState() => _CustomDialog();
}

class _CustomDialog extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return new Directionality(
        textDirection: TextDirection.rtl,
        //return Container(
        child: AlertDialog(
          title: new Text("הודעה",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          content: Container(
            width: 200,
            height: 70,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    new Text(widget.text,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    new Padding(padding: EdgeInsets.all(16.0)),
                  ],
                )
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              onPressed: () async {
                Navigator.of(context).pop();
                widget.handleYesButton();
              },
              child: new Text("אישור",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                

                widget.handleNoButton();
                
              },
              child: new Text("ביטול",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ));
  }
}
