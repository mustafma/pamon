import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_world/Model/bed.dart';

class Room {
  String roomId;
  String departmentID;
  String roomName;
  int totalNotifications = 0;//getTotalNumberOfNotifications();
  List<dynamic> beds = new List<Bed>();
  Room({this.roomId, this.roomName, this.beds});


  Room.fromMap(Map snapshot,String id) :
        roomId = id,
        roomName = snapshot['name'] ?? '',
        departmentID = snapshot['departmntID'] ?? '',
        beds = snapshot['beds'].map((map) => new Bed.fromMap(map, map['bedId'])).toList();




  //map(((doc) =>doc.get().then(Bed.fromMap(doc.value, doc.value.documentID.toString())))).toList() ?? null;



  toJson() {
    return {
      "name": roomName,
      "beds": beds,
      "departmentID": departmentID,
    };
  }

  int getTotalNumberOfNotifications()
  {
    var sum = 0;
    List<dynamic> notifications;
    for(Bed bed in beds)
    {
      notifications = bed.notifications;

      sum = sum + bed.totalActiveNotifications;
    }
    return sum;
  }
}
