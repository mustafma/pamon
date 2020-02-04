import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:BridgeTeam/Model/bed.dart';

import 'enumTypes.dart';

class Room {
  String roomId;
  String departmentID;
  String roomName;
  List<dynamic> beds = new List<Bed>();
  Room({this.roomId, this.roomName, this.beds});

  Room.fromMap(Map snapshot, String id)
      : roomId = id,
        roomName = snapshot['name'] ?? '',
        departmentID = snapshot['departmntId'] ?? '',
        beds = snapshot['beds']
            .map((map) => new Bed.fromMap(map, map['bedId']))
            .toList();

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

      sum = sum + notifications.length;
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
        case BedStatus.Invasiv:
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
      }
    }
    return sum;
  }
}
