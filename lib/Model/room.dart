import 'package:hello_world/Model/bed.dart';

class Room{
  int roomId;
  String roomName;
  int totalNotifications;
  List<Bed> beds = new List<Bed>();
}