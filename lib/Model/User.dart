import 'package:BridgeTeam/Model/enumTypes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  String meshmeretFileName;
  bool  _showAlert = true;



  List<dynamic> survies = new List<UserSurvey>();

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
    this.meshmeretFileName,
  });
  void setUserType(UserType type) {
    userole = type;
  }

  String getUID() {
    return uid;
  }




  String getMeshmeretImpagePath() {
    return meshmeretFileName;
  }

  void setMeshmeretImpagePath(String name) {
    meshmeretFileName = name;
  }

  bool needToSubmitSurvey() {
    for (int i = 0; i < survies.length; i++) {
      if (!(survies[i] as UserSurvey).issubmitted) return true;
    }
    return false;
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



  bool get showAlert => _showAlert;

  set showAlert(bool showAlert) {
    _showAlert = showAlert;
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

  void setUserSurvies(List<UserSurvey> userSurvies) async {
    survies = userSurvies;
  }

  void populateUserPermessions() async {
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
        userPermessions[BridgeOperation.SetBedAsInfected] = true;
        userPermessions[BridgeOperation.CancelBedInfectectionStatus] = true;
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
                userPermessions[BridgeOperation.SetBedAsInfected] = true;
        userPermessions[BridgeOperation.CancelBedInfectectionStatus] = true;

        break;

      case UserType.DepartmentManager:
        userPermessions[BridgeOperation.CleanBed] = true;
        userPermessions[BridgeOperation.ReleaseBed] = true;
        userPermessions[BridgeOperation.MoveBed] = true;
        userPermessions[BridgeOperation.AddInstruction] = true;
        userPermessions[BridgeOperation.RemoveInstruction] = false;
        userPermessions[BridgeOperation.BuildNursesShift] = true;
        userPermessions[BridgeOperation.BuildDoctorsShift] = true;
        userPermessions[BridgeOperation.SendMessages] = true;
        userPermessions[BridgeOperation.ChangeBedStatus] = true;
        userPermessions[BridgeOperation.UserManagment] = true;
        userPermessions[BridgeOperation.SetRoomAsInfected] = true;
        userPermessions[BridgeOperation.CancelRoomInfectectionStatus] = true;
        userPermessions[BridgeOperation.SetBedAsInfected] = true;
        userPermessions[BridgeOperation.CancelBedInfectectionStatus] = true;

        break;

      case UserType.NurseShiftManager:
        userPermessions[BridgeOperation.CleanBed] = true;
        userPermessions[BridgeOperation.ReleaseBed] = true;
        userPermessions[BridgeOperation.MoveBed] = true;
        userPermessions[BridgeOperation.AddInstruction] = false;
        userPermessions[BridgeOperation.RemoveInstruction] = true;
        userPermessions[BridgeOperation.BuildNursesShift] = true;
        userPermessions[BridgeOperation.BuildDoctorsShift] = true;
        userPermessions[BridgeOperation.SendMessages] = true;
        userPermessions[BridgeOperation.ChangeBedStatus] = true;
        userPermessions[BridgeOperation.UserManagment] = true;
        userPermessions[BridgeOperation.SetRoomAsInfected] = true;
        userPermessions[BridgeOperation.CancelRoomInfectectionStatus] = true;
        userPermessions[BridgeOperation.SetBedAsInfected] = true;
        userPermessions[BridgeOperation.CancelBedInfectectionStatus] = true;
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
        userPermessions[BridgeOperation.SetBedAsInfected] = false;
        userPermessions[BridgeOperation.CancelBedInfectectionStatus] = false;
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
        departmentId = snapshot['departmentId'] ?? '',
        meshmeretFileName = snapshot['imageName'] ?? '',
        // Get Shalonem for User that are still opened
        survies = snapshot['shalonem']
            .map((map) => new UserSurvey.fromMap(map))
            .toList(); //.sort((a,b)

}

class UserSurvey {
  String surveyid;
  DateTime dueDate;
  bool _issubmitted;

  List<dynamic> answers = new List<SurveyAnswer>();

  bool get issubmitted => _issubmitted;

  set issubmitted(bool issubmitted) {
    _issubmitted = issubmitted;
  }

  UserSurvey.fromMap(Map snapshot)
      :

        // documentID =  id,
        surveyid = snapshot['survey_id'],
        _issubmitted = snapshot['issubmitted'],
        dueDate = (snapshot['duedate'] as Timestamp) != null
            ? (snapshot['duedate'] as Timestamp).toDate()
            : DateTime.now(),
        answers = snapshot['answers']
            .map((map) => new SurveyAnswer.fromMap(map))
            .toList();
}

class SurveyAnswer {
  String _questionid;
  String _answer;

  String get question_id => _questionid;

  set question_id(String _questionid) {
    _questionid = question_id;
  }

  String get answer => _answer;

  set answer(String answer) {
    _answer = answer;
  }

  SurveyAnswer.fromMap(Map snapshot)
      : _questionid = snapshot['question_id'],
        _answer = snapshot['answer'];
}
