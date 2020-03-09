

import 'package:BridgeTeam/Model/User.dart';

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
          else
            setUser(user.uid,user.displayName);
          return FutureBuilder<bool>(
            future: setUser(user.uid,user.displayName),
            builder: (context,AsyncSnapshot<bool> snapshot) {
              if(snapshot.hasData)
              return ListViewRooms();
              else
              return CircularProgressIndicator();

            }

          
          );
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

  Future<bool> setUser(String userId, String displayName) async{
  
      CrudMethods crudObj = new CrudMethods();
      var userType =  await crudObj.getUserRole(userId);
      AuthService.setUserInfo(userId , displayName, userType);
        User user = User.getInstance();
    user.setUID(userId);
    user.setUserName(displayName);
    user.setUserType(user.stringToUserTypeConvert(userType));
     user.populateUserPermessions();
         
      //AuthService.regiterTokenOfLoggedInDevise(userId);
      return true;
  }
}