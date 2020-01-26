import 'package:cloud_firestore/cloud_firestore.dart';

class Bed {
  String bedId;
  int roomId;
  int bedNumber;
  String name;
  int totalActiveNotifications;
  bool withCut = false;
  bool isInfected = false;
  bool forCT = false;
  bool fasting = false;
  List<dynamic> notifications = new List<BedInstruction>();

  Bed();
  Bed.fromMap(Map snapshot,String id) :
        bedId = id,
        name = snapshot['bedName'] ?? '',
        withCut = snapshot['withCut'] ?? false,
        isInfected = snapshot['isInficted'] ?? false,
        forCT = snapshot['forCT'] ?? false,
        fasting = snapshot['fasting'] ?? false,
        totalActiveNotifications = snapshot['totalActiveNotifications'],
        notifications = snapshot['notifications'].map((map) => new BedInstruction.fromMap(map, map['notificationId'])).toList();
}



class BedInstruction{
  String notificationId;
  String parentBedId;
  int notificationType;
  String notificationText;
  DateTime createdAt;



  BedInstruction(notificationText, notificationType, parentBedId){
    this.notificationText = notificationText;
    this.parentBedId = parentBedId;
    this.notificationType = notificationType;
    this.createdAt = new DateTime.now();
    this.notificationId = this.createdAt.toString();

  }




  BedInstruction.fromMap(Map snapshot,String id) :
        notificationId = id,
<<<<<<< HEAD
        notificationType = "1",//snapshot['notificationType'] ?? '',
=======
        notificationType = snapshot['notificationType'],
>>>>>>> 6e0a39cde737f8df1fd20bda830671b60ce199fe
        notificationText = snapshot['notificationText'],
        

  createdAt = (snapshot['createdAt'] as Timestamp).toDate();


  Map<String, dynamic> toMap() {
    return {
      'notificationId':this.notificationId,
      'notificationText': this.notificationText,
      'notificationType': this.notificationType,
      'createdAt':this.createdAt,
      'parentBedId': this.parentBedId
    };
  }
}