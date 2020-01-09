import 'package:flutter/cupertino.dart';

class Session {
  @protected
  String _userId;
  @protected
  String _userType;
  // @protected
  // DateTime _lastlogindt;

  static Session _instance;

  Session._privateConstructor();

  //dart is single thread programming no need for thread safe code
  static Session instance() {
    if (_instance == null) {
      _instance = Session._privateConstructor();
    }

    return _instance;
  }

// set lastLogindt(DateTime lastLoginDateTime) {
//    _lastlogindt = lastLoginDateTime;
// }

  String get userID {
    return _userId;
  }

  String get userType {
    return _userType;
  }

  set userID(String userId) {
    _userId = userId;
  }

  set userType(String type) {
    _userType = type;
  }

  bool get iSNursePermessions {
    if (_userType == "N")
      return true;
    else
      return false;
  }
}
