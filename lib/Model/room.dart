import 'package:BridgeTeam/Model/bed.dart';

import 'enumTypes.dart';

class Room {
  String roomId;
  String departmentID;
  String roomName;
  String responsibleDoctor;
  String responsibleNurse;
  bool timeforUpdate1;
  bool docAcceptedTalk1;
  bool nurseAcceptedTalk1;

  bool timeforUpdate2;
  bool docAcceptedTalk2;
  bool nurseAcceptedTalk2;


  List<dynamic> beds = new List<Bed>();
  Room({this.roomId, this.roomName, this.beds});

  Room.fromMap(Map snapshot, String id)
      : roomId = id,
        roomName = snapshot['name'] ?? '',
        responsibleDoctor = snapshot['responsibleDoctor'] ?? '',
        responsibleNurse = snapshot['responsibleNurse'] ?? '',
        departmentID = snapshot['departmntId'] ?? '',
        timeforUpdate1 = snapshot['timeforUpdate1'] ?? false,
        docAcceptedTalk1 = snapshot['docAcceptedTalk1'] ?? false,
        nurseAcceptedTalk1 = snapshot['nurseAcceptedTalk1'] ?? false,


        timeforUpdate2 = snapshot['timeforUpdate2'] ?? false,
        docAcceptedTalk2 = snapshot['docAcceptedTalk2'] ?? false,
        nurseAcceptedTalk2 = snapshot['nurseAcceptedTalk2'] ?? false,


        beds = snapshot['beds']
            .map((map) => new Bed.fromMap(map, map['bedId']))
            .toList();//.sort((a,b) =>  (a as Bed).bedId.compareTo((b as Bed).bedId) );

       

  //map(((doc) =>doc.get().then(Bed.fromMap(doc.value, doc.value.documentID.toString())))).toList() ?? null;

  toJson() {
    return {
      "name": roomName,
      "beds": beds,
      "departmentID": departmentID,
    };
  }

  int getTotalNumberOfNotifications() {
    var sum = 0;
    List<dynamic> notifications;
    for (Bed bed in beds) {
      notifications = bed.notifications;
      List<BedInstruction> instructions = List.from(notifications);
      for(int j =0;j<instructions.length;j++)
        {
          if(instructions[j].notificationStatus =='active')
            sum++;
        }

    }
    return sum;
  }


    int getTotalNumberOfReleases() {
    var sum = 0;
    for (Bed bed in beds) {
    
          if(bed.dismissed) sum++;

    }
    return sum;
  }



  int getTotalNumberOfBedsWithCateter(BedStatus bedStat) {
    var sum = 0;
    for (Bed bed in beds) {
      switch (bedStat) {
        case BedStatus.Cateter:
          if (bed.Cateter) sum = sum + 1;
          break;
        case BedStatus.CT:
          if (bed.CT) sum = sum + 1;
          break;
        case BedStatus.Fasting:
          if (bed.Fasting) sum = sum + 1;
          break;
        case BedStatus.Infected:
          if (bed.Infected) sum = sum + 1;
          break;
        case BedStatus.SocialAid:
          if (bed.Infected) sum = sum + 1;
          break;
        case BedStatus.PhysoAid:
          if (bed.Infected) sum = sum + 1;
          break;
        case BedStatus.Invasive:
          if (bed.Infected) sum = sum + 1;
          break;
        case BedStatus.O2:
          if (bed.Infected) sum = sum + 1;
          break;
        case BedStatus.DiatentAid:
          if (bed.Infected) sum = sum + 1;
          break;
        case BedStatus.Petsa:
          if (bed.Infected) sum = sum + 1;
          break;
       case BedStatus.Pranola:
          if (bed.pranola) sum = sum + 1;
          break;
             case BedStatus.Seodi:
          if (bed.pranola) sum = sum + 1;
          break;
             case BedStatus.Cognitive:
          if (bed.pranola) sum = sum + 1;
          break;
      }
    }
    return sum;
  }
}
