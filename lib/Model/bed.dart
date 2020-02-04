import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:BridgeTeam/Model/enumTypes.dart';

class Bed {
  String bedId;
  int roomId;
  String name;
  bool Cateter = false;
  bool Infected = false;
  bool CT = false;
  bool Fasting = false;
  bool SocialAid = false;
  bool PhysoAid = false;
  bool DiatentAid = false;
  bool O2 = false;
  bool Petsa = false;
  bool Invasiv = false;
  List<dynamic> notifications = new List<BedInstruction>();

  Bed();
  Bed.fromMap(Map snapshot,String id) :
        bedId = id,
        name = snapshot['bedName'] ?? '',
        Cateter = snapshot['withCut'] ?? false,
        Infected = snapshot['isInficted'] ?? false,
        CT = snapshot['forCT'] ?? false,
        Fasting = snapshot['fasting'] ?? false,
        SocialAid = snapshot['fasting'] ?? false,
        PhysoAid = snapshot['fasting'] ?? false,
        DiatentAid = snapshot['fasting'] ?? false,
        O2 = snapshot['fasting'] ?? false,
        Petsa = snapshot['fasting'] ?? false,
        Invasiv = snapshot['fasting'] ?? false,
        notifications = snapshot['notifications'].map((map) => new BedInstruction.fromMap(map, map['notificationId'])).toList();



List<BedStatus> listOfIcons()
{
List<BedStatus> bedStatuses =  new List<BedStatus>();

 if(Cateter) bedStatuses.add(BedStatus.Cateter);
 if(CT) bedStatuses.add(BedStatus.CT);
 if(Fasting) bedStatuses.add(BedStatus.Fasting);

 if(SocialAid) bedStatuses.add(BedStatus.SocialAid);
 if(PhysoAid) bedStatuses.add(BedStatus.PhysoAid);
 if(Infected) bedStatuses.add(BedStatus.Infected);
 if(DiatentAid) bedStatuses.add(BedStatus.DiatentAid);
 if(O2) bedStatuses.add(BedStatus.O2);
 if(Petsa) bedStatuses.add(BedStatus.Petsa);
 if(Invasiv) bedStatuses.add(BedStatus.Invasiv);

return bedStatuses;

}


  int getNumberOfActiveNotifications()
  {
    if(notifications == null)
      return 0;
    if(notifications.length == 0)
      return 0;
    int sum = 0;
    List<BedInstruction> instructions = List.from(notifications);
    for(int i =0; i<instructions.length;i++)
      {
        if(instructions[i].notificationStatus == "active")
          sum++;
      }
    return sum;
  }


}



class BedInstruction{
  String notificationId;
  String parentBedId;
  int notificationType;
  String notificationText;
  String notificationStatus;
  DateTime createdAt;



  BedInstruction(notificationText, notificationType, parentBedId, status){
    this.notificationText = notificationText;
    this.parentBedId = parentBedId;
    this.notificationType = notificationType;
    this.createdAt = new DateTime.now();
    this.notificationStatus = status;
    this.notificationId = this.createdAt.toString();

  }

  BedInstruction.fromMap(Map snapshot,String id) :
        notificationId = id,
        notificationType = snapshot['notificationType']?? "",
        notificationText = snapshot['notificationText']?? "",
        notificationStatus = snapshot['notificationStatus']?? "",
        createdAt = (snapshot['createdAt'] as Timestamp).toDate();


  Map<String, dynamic> toMap() {
    return {
      'notificationId':this.notificationId,
      'notificationText': this.notificationText,
      'notificationType': this.notificationType,
      'notificationStatus': this.notificationStatus,
      'createdAt':this.createdAt,
      'parentBedId': this.parentBedId
    };
  }


}