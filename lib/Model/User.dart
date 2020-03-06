import 'package:BridgeTeam/Model/enumTypes.dart';
import 'package:flutter/material.dart';




class User {
  @protected
  String _userId;
  String _displayName;
  UserType _userType;
  Map<BridgeOperation,bool> userPermessions =  new Map();

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
    case "nr":
      return UserType.Nurse;
    case "drm":
    return UserType.DepartmentManager;

    case "nrm":
    return UserType.NurseShiftManager;

    case "other":
    return UserType.Other;
    default:
      return UserType.Nurse;
  }
  }

  UserType getUserType()
  {
    return _userType;
  }



  void populateUserPermessions()
  {
    switch(_userType)
    {
      case UserType.Doctor:
          userPermessions[BridgeOperation.CleanBed] = false;
          userPermessions[BridgeOperation.ReleaseBed] = true;
          userPermessions[BridgeOperation.MoveBed] = false;
          userPermessions[BridgeOperation.AddInstruction] = true;
          userPermessions[BridgeOperation.RemoveInstruction] = false;
          userPermessions[BridgeOperation.BuildNursesShift] = false;
          userPermessions[BridgeOperation.BuildDoctorsShift] = false;
          userPermessions[BridgeOperation.SendMessages] = false;
          userPermessions[BridgeOperation.ChangeBedStatus] = true;
          userPermessions[BridgeOperation.UserManagment] = false;
          userPermessions[BridgeOperation.SetRoomAsInfected] = true;
          userPermessions[BridgeOperation.CancelRoomInfectectionStatus] = true;
          
      break;

      case UserType.Nurse:
          userPermessions[BridgeOperation.CleanBed] = true;
          userPermessions[BridgeOperation.ReleaseBed] = false;
          userPermessions[BridgeOperation.MoveBed] = true;
          userPermessions[BridgeOperation.AddInstruction] = false;
          userPermessions[BridgeOperation.RemoveInstruction] = true;
          userPermessions[BridgeOperation.BuildNursesShift] = false;
          userPermessions[BridgeOperation.BuildDoctorsShift] = false;
          userPermessions[BridgeOperation.SendMessages] = false;
           userPermessions[BridgeOperation.ChangeBedStatus] = true;
            userPermessions[BridgeOperation.UserManagment] = false;
            userPermessions[BridgeOperation.SetRoomAsInfected] = false;
             userPermessions[BridgeOperation.CancelRoomInfectectionStatus] = false;


      break;

      case UserType.DepartmentManager:
          userPermessions[BridgeOperation.CleanBed] = true;
          userPermessions[BridgeOperation.ReleaseBed] = true;
          userPermessions[BridgeOperation.MoveBed] = true;
          userPermessions[BridgeOperation.AddInstruction] = true;
          userPermessions[BridgeOperation.RemoveInstruction] = true;
          userPermessions[BridgeOperation.BuildNursesShift] = true;
          userPermessions[BridgeOperation.BuildDoctorsShift] = true;
          userPermessions[BridgeOperation.SendMessages] = true;
           userPermessions[BridgeOperation.ChangeBedStatus] = true;
            userPermessions[BridgeOperation.UserManagment] = true;
            userPermessions[BridgeOperation.SetRoomAsInfected] = true;
             userPermessions[BridgeOperation.CancelRoomInfectectionStatus] = true;


      break;


      case UserType.NurseShiftManager:
          userPermessions[BridgeOperation.CleanBed] = true;
          userPermessions[BridgeOperation.ReleaseBed] = true;
          userPermessions[BridgeOperation.MoveBed] = true;
          userPermessions[BridgeOperation.AddInstruction] = true;
          userPermessions[BridgeOperation.RemoveInstruction] = true;
          userPermessions[BridgeOperation.BuildNursesShift] = true;
          userPermessions[BridgeOperation.BuildDoctorsShift] = true;
          userPermessions[BridgeOperation.SendMessages] = true;
           userPermessions[BridgeOperation.ChangeBedStatus] = true;
            userPermessions[BridgeOperation.UserManagment] = true;
            userPermessions[BridgeOperation.SetRoomAsInfected] = true;
             userPermessions[BridgeOperation.CancelRoomInfectectionStatus] = true;
      break;

      case UserType.Other:
          userPermessions[BridgeOperation.CleanBed] = false;
          userPermessions[BridgeOperation.ReleaseBed] = false;
          userPermessions[BridgeOperation.MoveBed] = false;
          userPermessions[BridgeOperation.AddInstruction] = false;
          userPermessions[BridgeOperation.RemoveInstruction] = false;
          userPermessions[BridgeOperation.BuildNursesShift] = false;
          userPermessions[BridgeOperation.BuildDoctorsShift] = false;
          userPermessions[BridgeOperation.SendMessages] = false;
           userPermessions[BridgeOperation.ChangeBedStatus] = false;
            userPermessions[BridgeOperation.UserManagment] = false;
            userPermessions[BridgeOperation.SetRoomAsInfected] = false;
             userPermessions[BridgeOperation.CancelRoomInfectectionStatus] = false;
      break;


    }
  }


}
