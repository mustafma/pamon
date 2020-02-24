import 'package:BridgeTeam/services/crud.dart';
import 'package:flutter/material.dart';

import 'appBar.dart';
import 'bottomAppBar.dart';

class InstanceMessage extends StatefulWidget {
  CrudMethods crudObj = new CrudMethods();
  InstanceMessage({
    Key key,
  });
  _InstanceMessage createState() => _InstanceMessage();
}

class _InstanceMessage extends State<InstanceMessage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(200, 201, 202, 1.0),
        key: _scaffoldKey,
        appBar: BaseAppBar(
          title: Text('שליחת הודעות',
              style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          backButtonVisible: true,
          appBar: AppBar(),
        ),
        body:SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
                child: Padding(padding: EdgeInsets.all(10.0), child: Text(""))),
            Container(
                child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    color: Colors.white,
                    child: TextField(
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        maxLines: 10,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          // icon: const Icon(Icons.calendar_today),
                          //hintText: 'רשום הודעה',
                          //labelText: "הודעה",
                        )),
                  )),
            )),
            Container(
                child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(children: <Widget>[
                new Row(children: <Widget>[
                  Switch(value: false, onChanged: (bool newValue) {}),
                  new Padding(padding: EdgeInsets.all(1.0)),
                  Text('קבוצת רופאים',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ]),
                new Row(children: <Widget>[
                  Switch(value: false, onChanged: (bool newValue) {}),
                  new Padding(padding: EdgeInsets.all(1.0)),
                  Text('קבוצת אחים/אחיות',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ]),
                new Row(children: <Widget>[
                  Switch(value: false, onChanged: (bool newValue) {}),
                  new Padding(padding: EdgeInsets.all(1.0)),
                  Text('כללי',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ]),
              ]),
            )),
            Container(
              child: RaisedButton(
                color: Colors.orange,
                child: Text(
                  'שלח',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      textBaseline: TextBaseline.alphabetic),
                ),
                onPressed: () {},
              ),
            ),
          
          ]),
       
        ),
      
        bottomNavigationBar: BaseBottomBar());
  }
}
