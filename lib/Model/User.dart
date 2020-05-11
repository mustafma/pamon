import 'package:BridgeTeam/Model/enumTypes.dart';
import 'package:flutter/material.dart';

class User with ChangeNotifier {
  @protected
  String uid;
  String name;
  String email;
  String hospitalId;
  String departmentId;
  String documentID;
  String password;
  String title;
  String role;
  bool isInShift;
  bool isAdmin;
  UserType userole;

  Map<BridgeOperation, bool> userPermessions = new Map();

  static User _instance;
  UserType get loggedInUserType => userole;
  String get loggedInUserId => uid;

  User({
    this.email,
    this.hospitalId,
    this.departmentId,
    this.isAdmin,
    this.name,
    this.password,
    this.uid,
    this.role,
    this.title,
    this.isInShift,
  });
  void setUserType(UserType type) {
    userole = type;
  }

  String getUID() {
    return uid;
  }

  void setUID(String id) {
    uid = id;
  }

  void setUserName(String displayName) {
    name = displayName;
  }

  String getUserName() {
    return name;
  }

  User._internal();

  static User getInstance() {
    if (_instance == null) {
      _instance = User._internal();
    }

    return _instance;
  }

  UserType stringToUserTypeConvert(String typeAsString) {
    switch (typeAsString.toLowerCase()) {
      case "dr":
      case "doctor":
        return UserType.Doctor;
      case "nr":
      case "nurse":
        return UserType.Nurse;
      case "drm":
      case "departmentmanager":
        return UserType.DepartmentManager;

      case "nrm":
      case "nurseShiftmanager":
        return UserType.NurseShiftManager;

      case "other":
        return UserType.Other;
      default:
        return UserType.Nurse;
    }
  }

  UserType getUserType() {
    return userole;
  }

  bool isUserInShift() {
    return this.isInShift;
  }

  void setUserInShift(bool status) {
    isInShift = status;
    notifyListeners();
  }

  void populateUserPermessions() async {
   /* if (!isInShift) {
      userPermessions[BridgeOperation.CleanBed] = false;
      userPermessions[BridgeOperation.ReleaseBed] = false;
      userPermessions[BridgeOperation.MoveBed] = false;
      userPermessions[BridgeOperation.AddInstruction] = false;
      userPermessions[BridgeOperation.RemoveInstruction] = false;
      if (this.userole == UserType.DepartmentManager ||
          this.userole == UserType.NurseShiftManager)
        userPermessions[BridgeOperation.BuildNursesShift] = true;
      else
        userPermessions[BridgeOperation.BuildNursesShift] = false;
      if (this.userole == UserType.DepartmentManager ||
          this.userole == UserType.NurseShiftManager)
        userPermessions[BridgeOperation.BuildDoctorsShift] = true;
      else
        userPermessions[BridgeOperation.BuildDoctorsShift] = false;
      userPermessions[BridgeOperation.SendMessages] = false;
      userPermessions[BridgeOperation.ChangeBedStatus] = false;
      if (this.userole == UserType.DepartmentManager ||
          this.userole == UserType.NurseShiftManager)
        userPermessions[BridgeOperation.UserManagment] = true;
      else
        userPermessions[BridgeOperation.UserManagment] = false;
      userPermessions[BridgeOperation.SetRoomAsInfected] = false;
      userPermessions[BridgeOperation.CancelRoomInfectectionStatus] = false;
    } else {*/
      switch (this.userole) {
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
    //}
  }

  User.fromMap(Map snapshot, String id)
      :

        // documentID =  id,
        uid = snapshot['uid'],
        title = snapshot['title'],
        role = snapshot['role'],
        isInShift = snapshot['isInShift'] ?? false,
        email = snapshot['email'] ?? '',
        password = snapshot['password'] ?? '',
        name = snapshot['name'] ?? '',
        isAdmin = snapshot['isAdmin'] ?? false,
        hospitalId = snapshot['hospitalId'] ?? '',
        departmentId = snapshot['departmentId'] ?? '';
}
