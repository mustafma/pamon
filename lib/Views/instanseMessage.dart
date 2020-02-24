import 'package:BridgeTeam/services/crud.dart';
import 'package:flutter/material.dart';

import 'appBar.dart';

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
      // backgroundColor: Theme.of(context).primaryColor,
      key: _scaffoldKey,
      appBar: BaseAppBar(
        title: Text('שליחת הודעות',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18)),
        backButtonVisible: true,
        appBar: AppBar(),
      ),

      body: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [
                        const Color(0xFF003C62),
                        const Color(0xFF428879)
                      ],
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp)),
              child: Column(
                children: <Widget>[
                 
                  Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Container(
                        color: Colors.white,
                        child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextField(
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                                maxLines: 10,
                                decoration: const InputDecoration(
                                  fillColor: Colors.white,
                                ))),
                      )),
                  Container(
                      child: Column(
                    children: <Widget>[
                      new Row(children: <Widget>[
                        Switch(value: false, onChanged: (bool newValue) {}),
                        new Padding(padding: EdgeInsets.all(1.0)),
                        Text('רופאים',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ]),
                      new Row(children: <Widget>[
                        Switch(value: false, onChanged: (bool newValue) {}),
                        new Padding(padding: EdgeInsets.all(1.0)),
                        Text('אחים/אחיות',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ]),
                      new Row(children: <Widget>[
                        Switch(value: false, onChanged: (bool newValue) {}),
                        new Padding(padding: EdgeInsets.all(1.0)),
                        Text('לכולם',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ]),
                    ],
                  )),
                
                 Container(

                   child:Center(
                     child:  new RaisedButton(
                      
                    onPressed: ()=>{},
                    textColor: Colors.white,
                    color: Colors.orange,
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(
                      "שלח",
                    style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                  ),
                   
                   )
                 )
                
                ],
              ))),
    );
  }
}
