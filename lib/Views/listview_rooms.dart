import 'package:BridgeTeam/Model/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:BridgeTeam/Model/room.dart';
import 'package:BridgeTeam/Views/room_card.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'appBar.dart';
import 'bottomAppBar.dart';

class ListViewRooms extends StatefulWidget {
  _ListViewRoomsState createState() => _ListViewRoomsState();
}

class _ListViewRoomsState extends State<ListViewRooms> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _message = "";
  User user = User.getInstance();


  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  _register() {
    _firebaseMessaging.getToken().then((token) => print(token));
  }

  void getMessage() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print('on message $message');

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: ListTile(
              title: Text(message['notification']['title'] +
                  "\n" +
                  message['notification']['subtitle']),
              subtitle: Text(message['notification']['body'])),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );

      setState(() {
        _message = message["notification"]["title"];
      });
    }, onResume: (Map<String, dynamic> message) async {
      print('on message $message');
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on message $message');
    });
  }

  //final List<String> _listViewData = ["Room 1", "Room 2", "Room 3", "Room 4"];

  var _firestoreRef = Firestore.instance.collection('rooms');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor:
          Theme.of(context).primaryColor, //Color.fromRGBO(58, 66, 86, 1.0),
      key: _scaffoldKey,
      appBar: BaseAppBar(
        title: Text('רשימת חדרים',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        backButtonVisible: false,
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
            child: StreamBuilder(
                stream: _firestoreRef.snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return LinearProgressIndicator();
                  } else {
                    List item = [];

                    item = snapshot.data.documents
                        .map((doc) =>
                            Room.fromMap(doc.data, doc.documentID.toString()))
                        .toList();

                    return ListView.builder(
                      itemCount: item.length,
                      itemBuilder: (BuildContext context, int index) {
                        RoomCard roomCard =
                            RoomCard(room: item[index], rooms: item);
                        return roomCard;
                      },
                    );
                  }
                })),
      ),

      bottomNavigationBar: BaseBottomBar(),
    );
  }

  @override
  void initState() {
    super.initState();
    getMessage();
    _register();
  }
}
