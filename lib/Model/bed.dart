class Bed {
  int bedId;
  int roomId;
  int bedNumber;
  String name;
  int totalActiveNotifications;
  List<dynamic> notifications = new List<BedInstruction>();

  Bed();
  Bed.fromMap(Map snapshot,String id) :
        bedId = int.parse(id),
        name = snapshot['bedName'] ?? '',
        totalActiveNotifications = snapshot['totalActiveNotifications'],
        notifications = snapshot['notifications'].map((map) => new BedInstruction.fromMap(map, map['notificationId'])).toList();
}



class BedInstruction{
  int notificationId;
  int parentBedId;
  String notificationType;
  String notificationText;
  DateTime createdAt;

  BedInstruction();
  BedInstruction.fromMap(Map snapshot,String id) :
        notificationId = int.parse(id),
        notificationType = snapshot['notificationType'] ?? '',
        notificationText = snapshot['notificationText'],
        createdAt = new DateTime.fromMillisecondsSinceEpoch(1000);
}