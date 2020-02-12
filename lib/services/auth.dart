import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:BridgeTeam/Model/User.dart';
import 'package:BridgeTeam/Model/session.dart';
import 'package:BridgeTeam/services/crud.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _userCached;
  static Session sessionObj;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  // sign in anony.
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      _userCached = result.user;
      setUserInfo(
          _userCached.uid, _userCached.displayName, "Dr"); // Set UserInfor
      return _userCached;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  FirebaseUser getUser() {
    return _userCached;
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());

      _userCached = result.user;
      CrudMethods crudObj = new CrudMethods();
      setUserInfo(_userCached.uid, _userCached.displayName,
          await crudObj.getUserRole(_userCached.uid)); // Set UserInfor
          regiterTokenOfLoggedInDevise(_userCached.uid);
      return _userCached;
    } catch (e) {
      throw new AuthException(e.code, e.message);
    }
  }

  void signOut() async {
    User user = User.getInstance();

    switch(user.getUserType()){

      case UserType.Doctor:
        _fcm.unsubscribeFromTopic('removeInstruction_topic');
        _fcm.unsubscribeFromTopic('addInstruction_topic');
        break;
      case UserType.Nurse:
      case UserType.NurseShiftManager:
        _fcm.unsubscribeFromTopic('addInstruction_topic');
        break;
      case UserType.DepartmentManager:

      break;
      case UserType.Other:
        // TODO: Handle this case.
        break;
  }
    await _auth.signOut();
  }

  static void setUserInfo(
      String userId, String displayName, String typeAsString) {
    User user = User.getInstance();
    user.setUserId(userId);
    user.setUserName(displayName);
    user.setUserType(user.stringToUserTypeConvert(typeAsString));
  }

  Future<void> regiterTokenOfLoggedInDevise(uid) async {
    String fcmToken = await _fcm.getToken();
    if (fcmToken != null) {
      var tokens = Firestore.instance
          .collection('users')
          .document(uid)
          .collection('tokens')
          .document(fcmToken);
      await tokens.setData({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(),
        'platform': Platform.operatingSystem
      });
    }
    User user = User.getInstance();

    switch(user.getUserType()){

      case UserType.Doctor:
        _fcm.subscribeToTopic('removeInstruction_topic');
        break;
      case UserType.Nurse:
      case UserType.NurseShiftManager:
        _fcm.subscribeToTopic('addInstruction_topic');
        break;
      case UserType.DepartmentManager:

        break;
      case UserType.Other:
        break;
    }

  }
}
