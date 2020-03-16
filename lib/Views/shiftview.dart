import 'package:BridgeTeam/Model/User.dart';
import 'package:BridgeTeam/services/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'appBar.dart';

class ShiftView extends StatefulWidget {
  CrudMethods crudObj = new CrudMethods();
  ShiftView();
  _ShiftView createState() => _ShiftView();
}

class _ShiftView extends State<ShiftView> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List updatedUsers = [];
  var crud = new CrudMethods();
  var _firestoreRef = Firestore.instance
      .collection('users')
      .where('departmentId', isEqualTo: "001")
      .where('hospitalId', isEqualTo: "001");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(
          title: Text('ניהול משמרת',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              textDirection: TextDirection.rtl),
          backButtonVisible: true,
          appBar: AppBar(),
        ),
        body: new Container(
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [const Color(0xFF003C64), const Color(0xFF428879)],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight,
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp)),
            child: Center(
                child: Center(
                    child: Directionality(
              textDirection: TextDirection.rtl,
              child: StreamBuilder(
                  stream: _firestoreRef.snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return LinearProgressIndicator();
                    } else {
                      List items = [];
                      items = snapshot.data.documents
                          .map((doc) => User.fromMap(
                              doc.data, doc.documentID.toString()))
                          .toList();
                      return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          User user = (items[index] as User);

                          return Visibility(
                              visible: true,
                              child: Row(children: <Widget>[
                                Switch(
                                    value: user.isInShift,
                                    onChanged: (bool newValue) {
                                      user.isInShift = newValue;
                                      if (updatedUsers.contains(user))
                                        updatedUsers.remove(user);

                                      updatedUsers.add(user);
                                    }),
                                new Padding(padding: EdgeInsets.all(1.0)),
                                Text(user.name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ]));
                        },
                      );
                    } //else
                  } //builder
                  ),
            )))),
        floatingActionButton: Container(
            margin: EdgeInsets.only(bottom: 10),
            child: FloatingActionButton.extended(
                backgroundColor: Colors.orange,
                onPressed: (
                    // Save mashmeret

                    ) {
                  updatedUsers.forEach((u) => {crud.addUser(u, false)});

                  showDialog(
                      context: context,
                      child: new AlertDialog(
                        title: Text('ניהול משמרת'),
                        content: const Text('משמרת עודכנה בהצלחה'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('סגור'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ));
                },
                icon: Icon(
                  Icons.save,
                ),
                label: Text("שמור"))));
  }
}
