import 'dart:io';

import 'package:BridgeTeam/Model/enumTypes.dart';
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
 
  


  FirebaseUser getUser() {
    return _userCached;
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    AuthResult result;
    try {
       result = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());

      _userCached = result.user;
      CrudMethods crudObj = new CrudMethods();
      setUserInfo(_userCached.uid, _userCached.displayName,
          await crudObj.getUserRole(_userCached.uid),
          await crudObj.isUserInShift(_userCached.uid)); // Set UserInfor
          regiterTokenOfLoggedInDevise(_userCached.uid);
      return _userCached;
    } catch (e) {
      print(e.message);
    return null;
      //throw new AuthException(e.code, e.message);
    }
  }

  void signOut() async {
    User user = User.getInstance();

    switch(user.getUserType()){

      case UserType.Doctor:
        _fcm.unsubscribeFromTopic('removeInstruction_topic');
        _fcm.unsubscribeFromTopic("messagesFromAdmin_doc_topic");

        break;
      case UserType.Nurse:
        _fcm.unsubscribeFromTopic('addInstruction_topic');
        _fcm.unsubscribeFromTopic("messagesFromAdmin_nurse_topic");
        break;
      case UserType.NurseShiftManager:
        _fcm.unsubscribeFromTopic('addInstruction_topic');
        _fcm.unsubscribeFromTopic("messagesFromAdmin_nurse_topic");
        _fcm.unsubscribeFromTopic('removeInstruction_topic');
        break;
      case UserType.DepartmentManager:
        _fcm.unsubscribeFromTopic('addInstruction_topic');
        _fcm.unsubscribeFromTopic('removeInstruction_topic');
        _fcm.unsubscribeFromTopic("messagesFromAdmin_nurse_topic");
        _fcm.unsubscribeFromTopic("messagesFromAdmin_all_topic");
      break;
      case UserType.Other:
        // TODO: Handle this case.
        break;
  }

    _fcm.unsubscribeFromTopic("messagesFromAdmin_all_topic");
    await _auth.signOut();
  }

  static void setUserInfo(
      String userId, String displayName, String typeAsString, shiftStatus) {
    User user = User.getInstance();
    user.setUID(userId);
    user.setUserName(displayName);
    user.setUserType(user.stringToUserTypeConvert(typeAsString));
     user.populateUserPermessions();
     user.setUserInShift(shiftStatus);
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
        _fcm.subscribeToTopic("messagesFromAdmin_doc_topic");
        break;
      case UserType.Nurse:
        _fcm.subscribeToTopic('addInstruction_topic');
        _fcm.subscribeToTopic("messagesFromAdmin_nurse_topic");
        break;
      case UserType.NurseShiftManager:
        _fcm.subscribeToTopic('addInstruction_topic');
        _fcm.subscribeToTopic('removeInstruction_topic');
        _fcm.subscribeToTopic("messagesFromAdmin_nurse_topic");
        break;
      case UserType.DepartmentManager:
        _fcm.subscribeToTopic('addInstruction_topic');
        _fcm.subscribeToTopic('removeInstruction_topic');
        _fcm.subscribeToTopic("messagesFromAdmin_doc_topic");
        break;
     /* case UserType.RoomDoctorSuperviosor:
        _fcm.subscribeToTopic("messagesFromAdmin_doc_topic");
        break;
      case UserType.NurseRoomsupervisor:
        _fcm.subscribeToTopic("messagesFromAdmin_nurse_topic");

        break;*/
      case UserType.Other:
        break;
    }
    _fcm.subscribeToTopic("messagesFromAdmin_all_topic");
  }
}
