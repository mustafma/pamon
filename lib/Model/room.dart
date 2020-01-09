import 'package:hello_world/Model/bed.dart';

class Room {
  int roomId;
  String departmentID;
  String roomName;
 int totalNotifications = 0;//getTotalNumberOfNotifications();
  List<Bed> beds = new List<Bed>();

  Room({this.roomId, this.roomName, this.beds});

  Room.fromMap(Map snapshot,int id) :
        roomId = id ?? '',
        roomName = snapshot['name'] ?? '',
        departmentID = snapshot['departmntID'] ?? '',
        beds = snapshot['beds'] ?? null;

  toJson() {
    return {
      "name": roomName,
      "beds": beds,
      "departmentID": departmentID,
    };
  }

  int getTotalNumberOfNotifications()
  {
    int sum = 0;
    for (int i = 0; i<beds.length;i++)
      {
        sum += beds[i].totalActiveNotifications;
      }
    return sum;
  }
}
