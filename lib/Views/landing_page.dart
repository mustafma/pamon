import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello_world/Model/session.dart';
import 'package:hello_world/Views/listview_rooms.dart';
import 'package:hello_world/Views/ui_login.dart';

class LandingPage extends StatelessWidget {
  static Session sessionObj;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          FirebaseUser user = snapshot.data;
          if (user == null) {
            return LoginWidget();
          }
          var uid = user.uid;

          //var datat = Firestore.instance.collection('users').document(uid);
          //var t = datat.get().then((doc) => {role = doc.data['role']});
          // initialize session again 
        //  sessionObj = new Session("yosef", "N", DateTime.now());
          return ListViewRooms();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}