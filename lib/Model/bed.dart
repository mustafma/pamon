class Bed {
  int bedId;
  int roomId;
  int bedNumber;
  String name;
  int totalActiveNotifications;
  List<BedInstruction> notifications = new List<BedInstruction>();
}

class BedInstruction{
  int notificationId;
  int parentBedId;
  String notificationType;
  String notificationText;
  DateTime createdAt;
}