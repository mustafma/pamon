import 'dart:convert';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:BridgeTeam/Model/enumTypes.dart';
import 'package:flutter/material.dart';

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
  bool Invasive = false;
  bool dismissed = false;
  bool pranola = false;
  bool seodi = false;
  bool cognitive = false;

  DateTime CatDate;
  List<dynamic> notifications = new List<BedInstruction>();

  Bed();
  Bed.fromMap(Map snapshot, String id)
      : bedId = id,
        name = snapshot['bedName'] ?? '',
        Cateter = snapshot['Cateter'] ?? false,
        Infected = snapshot['Infected'] ?? false,
        CT = snapshot['CT'] ?? false,
        Fasting = snapshot['Fasting'] ?? false,
        SocialAid = snapshot['SocialAid'] ?? false,
        PhysoAid = snapshot['PhysoAid'] ?? false,
        DiatentAid = snapshot['DiatentAid'] ?? false,
        O2 = snapshot['O2'] ?? false,
        Petsa = snapshot['Petsa'] ?? false,
        Invasive = snapshot['Invasive'] ?? false,
        CatDate = (snapshot['CatDate'] as Timestamp) != null
            ? (snapshot['CatDate'] as Timestamp).toDate()
            : DateTime.now(),
        dismissed = snapshot['dismissed'] ?? false,
        pranola = snapshot['pranola'] ?? false,
        seodi = snapshot['seodi'] ?? false,
        cognitive = snapshot['cognitive'] ?? false,
        notifications = snapshot['notifications']
            .map(
                (map) => new BedInstruction.fromMap(map, map['notificationId']))
            .toList();

  List<BedStatus> listOfIcons() {
    List<BedStatus> bedStatuses = new List<BedStatus>();


    // Keep  Order in  list 
    int index = 0;
    if (seodi) bedStatuses.insert(index++,BedStatus.Seodi);
    if (cognitive) bedStatuses.insert(index++,BedStatus.Cognitive);
    if (Cateter) bedStatuses.insert(index++,BedStatus.Cateter);
    if (Petsa) bedStatuses.insert(index++,BedStatus.Petsa);
    if (PhysoAid) bedStatuses.insert(index++,BedStatus.PhysoAid);
    if (SocialAid) bedStatuses.insert(index++,BedStatus.SocialAid);
    if (DiatentAid) bedStatuses.insert(index++,BedStatus.DiatentAid);
    if (Invasive) bedStatuses.insert(index++,BedStatus.Invasive);
    if (O2) bedStatuses.insert(index++,BedStatus.O2);
    if (Infected) bedStatuses.insert(index++,BedStatus.Infected);
    if (Fasting) bedStatuses.insert(index++,BedStatus.Fasting);





    
    //if (CT) bedStatuses.add(BedStatus.CT);
    //if (Fasting) bedStatuses.add(BedStatus.Fasting);

   // if (SocialAid) bedStatuses.add(BedStatus.SocialAid);
   // if (PhysoAid) bedStatuses.add(BedStatus.PhysoAid);
   // if (Infected) bedStatuses.add(BedStatus.Infected);
   // if (DiatentAid) bedStatuses.add(BedStatus.DiatentAid);
   // if (O2) bedStatuses.add(BedStatus.O2);
   // if (Petsa) bedStatuses.add(BedStatus.Petsa);
   // if (Invasive) bedStatuses.add(BedStatus.Invasive);
   // if (pranola) bedStatuses.add(BedStatus.Pranola);
  //  if (seodi) bedStatuses.add(BedStatus.Seodi);
  //  if (cognitive) bedStatuses.add(BedStatus.Cognitive);

    return bedStatuses;
  }

  int getNumberOfActiveNotifications() {
    if (notifications == null) return 0;
    if (notifications.length == 0) return 0;
    int sum = 0;
    List<BedInstruction> instructions = List.from(notifications);
    for (int i = 0; i < instructions.length; i++) {
      if (instructions[i].notificationStatus == "active") sum++;
    }
    return sum;
  }
}

class BedInstruction {
  String notificationId;
  String parentBedId;
  InstructionType notificationType;
  String notificationText;
  String notificationStatus;
  DateTime createdAt;
  Color color;

  BedInstruction(notificationText, notificationType, parentBedId, status) {
    this.notificationText = notificationText;
    this.parentBedId = parentBedId;
    this.notificationType = InstructionType.values[notificationType];
    this.createdAt = new DateTime.now();
    this.notificationStatus = status;
    this.notificationId = this.createdAt.toString();

    if (notificationType == InstructionType.PO ||
        notificationType == InstructionType.IV)
      color = Colors.green;
    else
      color = Colors.red;
  }

  BedInstruction.fromMap(Map snapshot, String id)
      : notificationId = id,
        notificationType = InstructionType.values[snapshot['notificationType'] ?? 1],
        notificationText = snapshot['notificationText'] ?? "",
        notificationStatus = snapshot['notificationStatus'] ?? "",
        color = (InstructionType.values[snapshot['notificationType'] ?? 1]==InstructionType.IV || InstructionType.values[snapshot['notificationType'] ?? 1]==InstructionType.PO )?Colors.green:Colors.red,
        createdAt = (snapshot['createdAt'] as Timestamp).toDate();
    

  Map<String, dynamic> toMap() {
    return {
      'notificationId': this.notificationId,
      'notificationText': this.notificationText,
      'notificationType': this.notificationType.index,
      'notificationStatus': this.notificationStatus,
      'createdAt': this.createdAt,
      'parentBedId': this.parentBedId
    };
  }
}

class StatusTypeValue {
  BedStatus bedStatus;
  bool value;
  FieldType fieldType;
  String dbFieldName;
  DateTime datetimeVal;

  BedStatus get status {
    return bedStatus;
  }
}
