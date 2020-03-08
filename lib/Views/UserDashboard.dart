
import 'package:BridgeTeam/Views/UserItem.dart';
import 'package:BridgeTeam/Views/user_details_page.dart';
import 'package:BridgeTeam/Model/User2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'appBar.dart';

class UsersDashboardPage extends StatefulWidget {
  UsersDashboardPage({Key key}) : super(key: key);

  @override
  _UsersDashboardPageState createState() => _UsersDashboardPageState();
}


class _UsersDashboardPageState extends State<UsersDashboardPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _firestoreRef = Firestore.instance.collection('users').where('departmentId', isEqualTo: "001").where('hospitalId', isEqualTo: "001");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: Text('ניהול משתמשים',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            textDirection: TextDirection.rtl),
        backButtonVisible: true,
        appBar: AppBar(),
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 56),
          decoration: new BoxDecoration
            (
              gradient: new LinearGradient(
                colors: [const Color(0xFF003C64), const Color(0xFF428879)],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp
              )
            ),

        child: Center
          (
          child: StreamBuilder
            (
              stream: _firestoreRef.snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null)
              {
                return LinearProgressIndicator();
              }
              else
                {
                  List items = [];
                  items = snapshot.data.documents
                  .map((doc) => User2.fromMap(doc.data, doc.documentID.toString()))
                  .toList();
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      UserItem userItem =
                      UserItem(user: items[index]);
                      return userItem;
                      },

                  );
                }//else
              } //builder
          ),
        ),
      ),
          floatingActionButton: Container
            (
            margin: EdgeInsets.only(bottom: 10),
            child: FloatingActionButton.extended(
            backgroundColor: Colors.orange,
            onPressed: () {
              Navigator.of(context).push(
                new MaterialPageRoute<Null>(
                    builder: (BuildContext context) {
                      return UserDetailsPage();
                      },
                    fullscreenDialog: true),

              );
              },
                icon: Icon(
                  Icons.add,
                ),
                label: Text("משתמש")),

      ),
    );
  }
}
