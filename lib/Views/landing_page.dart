import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:BridgeTeam/Model/session.dart';
import 'package:BridgeTeam/Views/listview_rooms.dart';
import 'package:BridgeTeam/Views/ui_login.dart';
import 'package:BridgeTeam/services/auth.dart';
import 'package:BridgeTeam/services/crud.dart';

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
          setUser(user.uid,user.displayName);
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

  void setUser(String userId, String displayName) async{
      CrudMethods crudObj = new CrudMethods();
      AuthService.setUserInfo(userId , displayName, await crudObj.getUserRole(userId));
      //AuthService.regiterTokenOfLoggedInDevise(userId);
  }
}