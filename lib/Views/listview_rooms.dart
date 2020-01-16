import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/Model/repository.dart';
import 'package:hello_world/Model/room.dart';
import 'package:hello_world/Views/room_card.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'appBar.dart';

class ListViewRooms extends StatefulWidget {
  _ListViewRoomsState createState() => _ListViewRoomsState();
}

class _ListViewRoomsState extends State<ListViewRooms> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

_register() {
  _firebaseMessaging.getToken().then((token) => print(token));
}


void getMessage(){
  _firebaseMessaging.configure(
    onMessage: (Map<String,dynamic> message) async {
      print('on message $message');
    },
    onResume: (Map<String,dynamic> message) async {
      print('on message $message');
    },
    onLaunch: (Map<String,dynamic> message) async {
      print('on message $message');
    }
    
    
    );

  
}


  //final List<String> _listViewData = ["Room 1", "Room 2", "Room 3", "Room 4"];

  Repository repository = new Repository();
  var _firestoreRef = Firestore.instance.collection('rooms');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color.fromRGBO(58,66,86,1.0),
        key: _scaffoldKey,
        appBar: BaseAppBar(
          title: Text('רשימת חדרים'),
          appBar: AppBar(),
          
        ),
        body: Center(
          child:  StreamBuilder(
            stream: _firestoreRef.snapshots(),
            builder:(BuildContext context , AsyncSnapshot snapshot){
              if(snapshot.data == null){
                return LinearProgressIndicator();
              }
              else{
                List item = [];

                item = snapshot.data.documents.map((doc) => Room.fromMap(doc.data, doc.documentID.toString())).toList();

                  return ListView.builder(
                  itemCount: item.length,
                  itemBuilder: (BuildContext context, int index){
                    RoomCard roomCard = RoomCard(
                  room: item[index],
                );
                return roomCard;
                  },
                );
              }
       

            })
            

          

        ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromRGBO(64, 75, 96, 9),
      
      child: new Container(
        height: 40,
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        
         Align(
           alignment: Alignment.center,
           child:Text("Powered  By Adamtec", style: TextStyle(
            color: Colors.white38, fontWeight: FontWeight.bold, fontSize: 18)))
        ],
      ),
    ))
        
        );
}
@override
  void initState() {
    super.initState();
    getMessage();
    _register();
  }
}
