
import 'package:BridgeTeam/Model/enumTypes.dart';

class Message {
  String notificationId;
  String bedId;
  String bedName;
  String notificationText;
  String roomId;
  String roomName;
  String uid;
  String displayName;
  String departmentId;
  String operation;
  String createdAt;

  Message(notificationId, bedId, bedName,notificationText,roomId,roomName, uid, displayName, departmentId, operation, createdAt) {
    this.notificationId = notificationId;
    this.bedId = bedId;
    this.bedName = bedName;
    this.notificationText = notificationText;
    this.roomId = roomId;
    this.roomName = roomName;
    this.uid = uid;
    this.displayName = displayName;
    this.departmentId = departmentId;
    this.operation = operation;
    this.createdAt = createdAt;
  }

  Map<String, dynamic> toMap() {
    return {
    'notificationId' : this.notificationId,
    'bedId' : this.bedId,
    'bedName' : this.bedName,
    'notificationText' : this.notificationText,
    'roomId' : this.roomId,
    'roomName' : this.roomName,
    'uid' : this.uid,
    'displayName': this.displayName,
    'departmentId' : this.departmentId,
    'operation' : this.operation,
    'createdAt' : this.createdAt
    };
  }

}