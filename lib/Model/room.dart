import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_world/Model/bed.dart';

import 'enumTypes.dart';

class Room {
  String roomId;
  String departmentID;
  String roomName;
  int totalNotifications = 0; //getTotalNumberOfNotifications();
  List<dynamic> beds = new List<Bed>();
  Room({this.roomId, this.roomName, this.beds});

  Room.fromMap(Map snapshot, String id)
      : roomId = id,
        roomName = snapshot['name'] ?? '',
        departmentID = snapshot['departmntID'] ?? '',
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

      sum = sum + bed.totalActiveNotifications;
    }
    return sum;
  }

  int getTotalNumberOfBedsWithCateter(BedStatus bedStat) {
    var sum = 0;
    for (Bed bed in beds) {
      switch (bedStat) {
        case BedStatus.Cateter:
          if (bed.withCut) sum = sum + 1;
          break;
        case BedStatus.CT:
          if (bed.forCT) sum = sum + 1;
          break;
        case BedStatus.Fasting:
          if (bed.fasting) sum = sum + 1;
          break;
        case BedStatus.Inficted:
          if (bed.isInfected) sum = sum + 1;
          break;
        case BedStatus.SocialAid:
          if (bed.isInfected) sum = sum + 1;
          break;
        case BedStatus.PhysoAid:
          if (bed.isInfected) sum = sum + 1;
          break;
        case BedStatus.Invasiv:
          if (bed.isInfected) sum = sum + 1;
          break;
        case BedStatus.O2:
          if (bed.isInfected) sum = sum + 1;
          break;
        case BedStatus.DiatentAid:
          if (bed.isInfected) sum = sum + 1;
          break;
        case BedStatus.Petsa:
          if (bed.isInfected) sum = sum + 1;
          break;
      }
    }
    return sum;
  }
}
