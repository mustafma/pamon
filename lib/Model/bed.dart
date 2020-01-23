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
  String notificationType;
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
        notificationType = snapshot['notificationType'] ?? '',
        notificationText = snapshot['notificationText'],
        createdAt = new DateTime.fromMillisecondsSinceEpoch(1000);

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