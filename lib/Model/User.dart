import 'package:BridgeTeam/Model/enumTypes.dart';
import 'package:flutter/material.dart';



class User {
  @protected
  String _userId;
  String _displayName;
  UserType _userType;

  static User _instance;
  UserType get loggedInUserType => _userType;
  String get loggedInUserId => _userId;

  void setUserType(UserType type) {
    _userType = type;
  }

  void setUserId(String id) {
    _userId = id;
  }
  void setUserName(String displayName){
    _displayName = displayName;
  }
  User._internal();

  static User getInstance() {
    if (_instance == null) {
      _instance = User._internal();
    }

    return _instance;
  }

  UserType stringToUserTypeConvert(String typeAsString)
  {
    switch (typeAsString.toLowerCase()) {
    case "dr":
      return UserType.Doctor;
    //case "nr":
     // return UserType.Nurse;
    case "nrs":
      return UserType.NurseShiftManager;
    case "drm":
    return UserType.DepartmentManager;

        case "drrs":
    return UserType.NurseRoomsupervisor;

        case "nrrs":
    return UserType.NurseRoomsupervisor;
    default:
      return UserType.Nurse;
  }
  }

  UserType getUserType()
  {
    return _userType;
  }
}
