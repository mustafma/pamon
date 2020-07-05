import 'package:BridgeTeam/Model/User.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:BridgeTeam/Model/session.dart';
import 'package:BridgeTeam/Views/ui_login.dart';
import 'package:BridgeTeam/services/auth.dart';
import 'package:BridgeTeam/services/crud.dart';
import 'package:flutter/rendering.dart';

import 'index_view.dart';

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
          } else
            setUser(user.uid, user.displayName);
          return FutureBuilder<bool>(
              future: setUser(user.uid, user.displayName),
              builder: (context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.hasData) {
                     // Future.delayed(Duration.zero, () => alertDialog(context));
                  return IndexView();
                } else {
                  return Container(
                      child: Center(
                    child: SizedBox(
                      child: CircularProgressIndicator(),
                      height: 20.0,
                      width: 20.0,
                    ),
                  ));
                }
              });
        } else {
          return Scaffold(
            body: Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                height: 20.0,
                width: 20.0,
              ),
            ),
          );
        }
      },
    );
  }

  Future<bool> setUser(String userId, String displayName) async {
    CrudMethods crudObj = new CrudMethods();
    var userType = await crudObj.getUserRole(userId);
    var shiftStatus = await crudObj.isUserInShift(userId);
    AuthService.setUserInfo(userId, displayName != "" ? displayName : "adamin",
        userType, shiftStatus);
    User user = User.getInstance();
    user.setUID(userId);
    user.setUserType(user.stringToUserTypeConvert(userType));
    user.populateUserPermessions();
    user.setUserSurvies(await crudObj.populateUserSurvies(userId));
    //AuthService.regiterTokenOfLoggedInDevise(userId);
    
    return true;
  }

  void alertDialog(BuildContext context) {
    if (User.getInstance().needToSubmitSurvey() && User.getInstance().showAlert) {
      User.getInstance().showAlert = false;
      String message = "יש שאלון שעדיין פתוח ומחכה למילוי";
      var alert = new Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: new Text("הודעה",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            content: new Text(message,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  goToSurvey();
                },
                child: new Text("עבור לשאלון",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  goToSurvey();
                },
                child: new Text("אחר כך",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ));
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext c) {
            return alert;
          });
    }
  }

  void goToSurvey() {}
}
