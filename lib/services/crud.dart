import 'dart:async';

import 'package:BridgeTeam/Model/User.dart';
import 'package:BridgeTeam/Model/User2.dart';
import 'package:BridgeTeam/Model/enumTypes.dart';
import 'package:BridgeTeam/Model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:BridgeTeam/Model/bed.dart';
import 'package:BridgeTeam/locator.dart';
import 'package:BridgeTeam/services/auth.dart';
import 'package:cloud_functions/cloud_functions.dart';

class CrudMethods {
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    }
    return false;
  }

  final HttpsCallable sendMessageFunction =
  CloudFunctions.instance.getHttpsCallable(
    functionName: 'sendMessageFunction',
  );

  final HttpsCallable addInstructionFunction =
  CloudFunctions.instance.getHttpsCallable(
    functionName: 'addInstructionFunction',
  );

  Future<void> addBed(roomId, bed) {
    if (isLoggedIn()) {
      var roomRef = Firestore.instance.collection("rooms").document(roomId);
      if (roomRef != null) {
        roomRef.updateData({"beds": FieldValue.arrayUnion(bed)});
      }
    }
  }

  Future<void> updateBedDateField(roomId, bedId, field, value) {
    if (isLoggedIn()) {
      //var roomRef = Firestore.instance.collection("rooms").document(roomId);

      DocumentReference roomRef =
      Firestore.instance.collection("rooms").document(roomId);
      Firestore.instance.runTransaction((Transaction tx) async {
        DocumentSnapshot postSnapshot = await tx.get(roomRef);
        if (postSnapshot.exists) {
          var beds = postSnapshot.data['beds'];
          for (int i = 0; i < beds.length; i++) {
            if (beds[i]['bedId'] == bedId) {
              beds[i][field] = Timestamp.fromDate(value);
            }
          }
          await tx.update(roomRef, <String, dynamic>{'beds': beds});
        }
      }).then((_) {
        print("Success");
      });
    }
  }

  Future<void> updateBedStatus(roomId, bedId, flag, status) async {
    if (isLoggedIn()) {
      //var roomRef = Firestore.instance.collection("rooms").document(roomId);

      DocumentReference roomRef =
      Firestore.instance.collection("rooms").document(roomId);
      Firestore.instance.runTransaction((Transaction tx) async {
        DocumentSnapshot postSnapshot = await tx.get(roomRef);
        if (postSnapshot.exists) {
          var beds = postSnapshot.data['beds'];
          for (int i = 0; i < beds.length; i++) {
            if (beds[i]['bedId'] == bedId) {
              List<String> list = (flag as String).split(";");

              list.forEach(
                      (x) => {if (x != null && x != "") beds[i][x] = status});
            }
          }
          //await tx.update(postRef, <String, dynamic>{'likesCount': postSnapshot.data['likesCount'] + 1});
          await tx.update(roomRef, <String, dynamic>{'beds': beds});
        }
      }).then((_) {
        print("Success");
      });
    }
  }

  Future<void> updateListOfBedStatusesAndDates(roomId, bedId,
      List<StatusTypeValue> listOfbedStatuses) async {
    if (isLoggedIn()) {
      //var roomRef = Firestore.instance.collection("rooms").document(roomId);

      DocumentReference roomRef =
      Firestore.instance.collection("rooms").document(roomId);
      Firestore.instance.runTransaction((Transaction tx) async {
        DocumentSnapshot postSnapshot = await tx.get(roomRef);
        if (postSnapshot.exists) {
          var beds = postSnapshot.data['beds'];
          for (int i = 0; i < beds.length; i++) {
            if (beds[i]['bedId'] == bedId) {
              listOfbedStatuses.forEach((x) =>
              {
                if (x != null)
                  {
                    if(x.fieldType == FieldType.bool)
                      beds[i][x.dbFieldName] = x.value
                    else
                      if(x.fieldType == FieldType.DateTime)
                        beds[i][x.dbFieldName] =
                            Timestamp.fromDate(x.datetimeVal)
                  }});
            }
          }
          //await tx.update(postRef, <String, dynamic>{'likesCount': postSnapshot.data['likesCount'] + 1});
          await tx.update(roomRef, <String, dynamic>{'beds': beds});
        }
      }).then((_) {
        print("Success");
      });
    }
  }

  Future<void> updateListOfBedStatuses(roomId, bedId,
      List<StatusTypeValue> listOfbedStatuses) async {
    if (isLoggedIn()) {
      //var roomRef = Firestore.instance.collection("rooms").document(roomId);

      DocumentReference roomRef =
      Firestore.instance.collection("rooms").document(roomId);
      Firestore.instance.runTransaction((Transaction tx) async {
        DocumentSnapshot postSnapshot = await tx.get(roomRef);
        if (postSnapshot.exists) {
          var beds = postSnapshot.data['beds'];
          for (int i = 0; i < beds.length; i++) {
            if (beds[i]['bedId'] == bedId) {
              listOfbedStatuses.forEach(
                      (x) => {if (x != null) beds[i][x.dbFieldName] = x.value});
            }
          }
          //await tx.update(postRef, <String, dynamic>{'likesCount': postSnapshot.data['likesCount'] + 1});
          await tx.update(roomRef, <String, dynamic>{'beds': beds});
        }
      }).then((_) {
        print("Success");
      });
    }
  }

  Future<void> cleanBed(roomId, bedId) {
    if (isLoggedIn()) {
      DocumentReference roomRef =
      Firestore.instance.collection("rooms").document(roomId);
      Firestore.instance.runTransaction((Transaction tx) async {
        DocumentSnapshot postSnapshot = await tx.get(roomRef);
        if (postSnapshot.exists) {
          List beds = List.from(postSnapshot.data['beds']);
          for (int i = 0; i < beds.length; i++) {
            if (beds[i]['bedId'] == bedId) {
              beds[i]["Fasting"] = false;
              beds[i]["CT"] = false;
              beds[i]["Inficted"] = false;
              beds[i]["Cateter"] = false;
              beds[i]["SocialAid"] = false;
              beds[i]["PhysoAid"] = false;
              beds[i]["DiatentAid"] = false;
              beds[i]["O2"] = false;
              beds[i]["Petsa"] = false;
              beds[i]["Invasive"] = false;
              beds[i]["dismissed"] = false;

              beds[i]["seodi"] = false;
              beds[i]["cognitive"] = false;
              beds[i]["pranola"] = false;

              List notifications =
              List.from(postSnapshot.data['beds'][i]['notifications']);
              for (int i = 0; i < notifications.length; i++) {
                notifications[i]['notificationStatus'] = "executed";
              }

              beds[i]["notifications"] = notifications;

              break;
            }
          }
          await tx.update(roomRef, <String, dynamic>{'beds': beds});
        }
      }).then((_) {
        print("Success");
      });
    }
  }

  Future<void> addInstruction(roomId, bedId, instructionType,
      instructionText) async {
    try {
      if (isLoggedIn()) {
        BedInstruction newInstruction =
        new BedInstruction(instructionText, instructionType, bedId, "active");

        DocumentReference roomRef =
        Firestore.instance.collection("rooms").document(roomId);

        Firestore.instance.runTransaction((Transaction tx) async {
          DocumentSnapshot postSnapshot = await tx.get(roomRef);
          if (postSnapshot.exists) {
            List beds = List.from(postSnapshot.data['beds']);
            for (int i = 0; i < beds.length; i++) {
              if (beds[i]['bedId'] == bedId) {
                List notifications =
                List.from(postSnapshot.data['beds'][i]['notifications']);

                dynamic instructionMap = newInstruction.toMap();
                notifications.add(instructionMap);
                beds[i]["notifications"] = notifications;
                break;
              }
            }
            await tx.update(roomRef, <String, dynamic>{'beds': beds});
          }
        }).then((_) {
          print("Success");

          Message message = new Message(
              newInstruction.notificationId,
              bedId,
              bedId,
              newInstruction.notificationType,
              newInstruction.notificationText,
              roomId,
              roomId,
              "uid",
              "departmentId",
              "ADD_INSTRUCTION",
              new DateTime.now().toString());
          Firestore.instance.collection("messages").add(message.toMap());
        }).catchError((e) {
          print('error runningbtransaction: $e');
          return null;
        });
      }
    }
    catch (e) {
      print('error caught: $e');
    }
  }

  Future<void> removeInstruction(roomId, bedId, instructionId) {
    if (isLoggedIn()) {
      dynamic removedInstruction;
      DocumentReference roomRef =
      Firestore.instance.collection("rooms").document(roomId);
      Firestore.instance.runTransaction((Transaction tx) async {
        DocumentSnapshot postSnapshot = await tx.get(roomRef);
        if (postSnapshot.exists) {
          List beds = List.from(postSnapshot.data['beds']);
          for (int i = 0; i < beds.length; i++) {
            if (beds[i]['bedId'] == bedId) {
              List notifications = List.from(beds[i]['notifications']);
              for (int j = 0; j < notifications.length; j++) {
                if (notifications[j]['notificationId'] == instructionId) {
                  // change notification status to executed
                  notifications[j]['notificationStatus'] = "executed";
                  removedInstruction = notifications[j];
                  beds[i]["notifications"] = notifications;
                  break;
                }
              }
              break;
            }
          }
          await tx.update(roomRef, <String, dynamic>{'beds': beds});
          Message message = new Message(
              instructionId,
              bedId,
              bedId,
              removedInstruction['notificationType'],
              removedInstruction['notificationText'],
              roomId,
              roomId,
              "uid",
              "departmentId",
              "EXECUTED_INSTRUCTION",
              new DateTime.now().toString());
          Firestore.instance.collection("messages").add(message.toMap());
        }
      }).then((_) {
        print("Success");
      }).catchError((e) {
        print('error runningbtransaction: $e');
        return null;
      });
    }
  }

  Future<void> removeBed(roomId, bedId) {
    if (isLoggedIn()) {
      //var roomRef = Firestore.instance.collection("rooms").document(roomId);

      DocumentReference roomRef =
      Firestore.instance.collection("rooms").document(roomId);
      Firestore.instance.runTransaction((Transaction tx) async {
        DocumentSnapshot postSnapshot = await tx.get(roomRef);
        if (postSnapshot.exists) {
          List beds = List.from(postSnapshot.data['beds']);

          for (int i = 0; i < beds.length; i++) {
            if (beds[i]['bedId'] == bedId) {
              beds.removeAt(i);
              break;
            }
          }
          await tx.update(roomRef, <String, dynamic>{'beds': beds});
        }
      }).then((_) {
        print("Success");
      }).catchError((e) {
        print('error runningbtransaction: $e');
        return null;
      });
    }
  }

  Future<void> moveBed(fromRoomId, toRoomId, bedId) {
    FutureOr<dynamic> _toMap;
    if (isLoggedIn()) {
      DocumentReference fromRoomRef =
      Firestore.instance.collection("rooms").document(fromRoomId);
      DocumentReference toRoomRef =
      Firestore.instance.collection("rooms").document(toRoomId);

      final TransactionHandler createTransaction = (Transaction tx) async {
        final DocumentSnapshot fromPostSnapshot = await tx.get(fromRoomRef);
        final DocumentSnapshot toPostSnapshot = await tx.get(toRoomRef);

        List beds = List.from(fromPostSnapshot.data['beds']);

        dynamic movingBed;
        List toBeds = [];

        for (int i = 0; i < beds.length; i++) {
          if (beds[i]['bedId'] == bedId) {
            movingBed = fromPostSnapshot.data['beds'][
            i]; //Bed.fromMap(fromPostSnapshot.data['beds'][i],fromPostSnapshot.data['beds'][i]['bedId']);

            toBeds = List.from(toPostSnapshot.data['beds']);
            toBeds.add(movingBed);
            beds.removeAt(i);
            break;
          }
        }
        await tx.update(fromRoomRef, <String, dynamic>{'beds': beds});
        await tx.update(toRoomRef, <String, dynamic>{'beds': toBeds});

        return;
      };

      return Firestore.instance
          .runTransaction(createTransaction)
          .then(_toMap)
          .catchError((e) {
        print('error runningbtransaction: $e');
        return null;
      });
    }
  }

  Future<void> replaceBed(fromRoomId, toRoomId, firstBedId, secondBedId) {
    FutureOr<dynamic> _toMap;
    if (isLoggedIn()) {
      DocumentReference fromRoomRef =
      Firestore.instance.collection("rooms").document(fromRoomId);
      DocumentReference toRoomRef =
      Firestore.instance.collection("rooms").document(toRoomId);

      final TransactionHandler createTransaction = (Transaction tx) async {
        final DocumentSnapshot fromPostSnapshot = await tx.get(fromRoomRef);
        final DocumentSnapshot toPostSnapshot = await tx.get(toRoomRef);

        List fromBeds = List.from(fromPostSnapshot.data['beds']);

        dynamic firstmovingBed;
        dynamic secondmovingBed;
        dynamic tempBed;
        List toBeds = [];

        for (int i = 0; i < fromBeds.length; i++) {
          if (fromBeds[i]['bedId'] == firstBedId) {
            firstmovingBed = fromPostSnapshot.data['beds'][
            i]; //Bed.fromMap(fromPostSnapshot.data['beds'][i],fromPostSnapshot.data['beds'][i]['bedId']);

            toBeds = List.from(toPostSnapshot.data['beds']);
            for (int j = 0; j < toBeds.length; j++) {
              if (toBeds[j]['bedId'] == secondBedId) {
                secondmovingBed = toPostSnapshot.data['beds'][
                j]; //Bed.fromMap(fromPostSnapshot.data['beds'][i],fromPostSnapshot.data['beds'][i]['bedId']);
                tempBed = new Map.from(secondmovingBed);
                secondmovingBed["Fasting"] = firstmovingBed['Fasting'];
                secondmovingBed["CT"] = firstmovingBed['CT'];
                secondmovingBed["Infected"] = firstmovingBed['Infected'];
                secondmovingBed["Cateter"] = firstmovingBed['Cateter'];
                secondmovingBed["SocialAid"] = firstmovingBed['SocialAid'];
                secondmovingBed["PhysoAid"] = firstmovingBed['PhysoAid'];
                secondmovingBed["DiatentAid"] = firstmovingBed['DiatentAid'];
                secondmovingBed["O2"] = firstmovingBed['O2'];
                secondmovingBed["Petsa"] = firstmovingBed['Petsa'];
                secondmovingBed["Invasive"] = firstmovingBed['Invasive'];
                secondmovingBed["dismissed"] = firstmovingBed['dismissed'];
                secondmovingBed["pranola"] = firstmovingBed['pranola'];
                secondmovingBed["seodi"] = firstmovingBed['seodi'];
                secondmovingBed["cognitive"] = firstmovingBed['cognitive'];
                List notifications = firstmovingBed["notifications"];
                secondmovingBed["notifications"] = notifications;

                firstmovingBed["Fasting"] = tempBed['Fasting'];
                firstmovingBed["CT"] = tempBed['CT'];
                firstmovingBed["Infected"] = tempBed['Infected'];
                firstmovingBed["Cateter"] = tempBed['Cateter'];
                firstmovingBed["SocialAid"] = tempBed['SocialAid'];
                firstmovingBed["PhysoAid"] = tempBed['PhysoAid'];
                firstmovingBed["DiatentAid"] = tempBed['DiatentAid'];
                firstmovingBed["O2"] = tempBed['O2'];
                firstmovingBed["Petsa"] = tempBed['Petsa'];
                firstmovingBed["Invasive"] = tempBed['Invasive'];
                firstmovingBed["dismissed"] = tempBed['dismissed'];
                firstmovingBed["pranola"] = tempBed['pranola'];
                firstmovingBed["seodi"] = tempBed['seodi'];
                firstmovingBed["cognitive"] = tempBed['cognitive'];
                List notificationsSecond = tempBed["notifications"];
                firstmovingBed["notifications"] = notificationsSecond;

                if (fromRoomId == toRoomId) {
                  toBeds[i] = firstmovingBed;
                  toBeds[j] = secondmovingBed;
                  await tx
                      .update(fromRoomRef, <String, dynamic>{'beds': toBeds});
                  return;
                }
                break;
              }
            }
          }
        }

        await tx.update(fromRoomRef, <String, dynamic>{'beds': fromBeds});
        await tx.update(toRoomRef, <String, dynamic>{'beds': toBeds});

        return;
      };

      return Firestore.instance.runTransaction(createTransaction).then((_) {
        print("Success");
      }).catchError((e) {
        print('error runningbtransaction: $e');
        return null;
      });
    }
  }

  Future<String> getUserRole(uid) async {
    if (isLoggedIn()) {
      var usersRef = Firestore.instance.collection("users");
      List<DocumentSnapshot> docs =
          (await usersRef.where('uid', isEqualTo: uid).getDocuments())
              .documents;
      return docs[0].data['role'];
    }
  }

  Future<List<User2>> getUsers(hospitalId, departmentId) async {
    if (isLoggedIn()) {
      var usersRef = Firestore.instance.collection("users");
      List<DocumentSnapshot> docs =
          (await usersRef.where('departmentId', isEqualTo: departmentId).where(
              'hospitalId', isEqualTo: hospitalId).
          getDocuments())
              .documents;

      List<User2> _users = new List<User2>();
      for (int i = 0; i < docs.length; i++) {
        //  var user = User2.fromFirestore(docs[i]);
        // _users.add(user);

      }
      return _users;
    }
  }

  Future<void> addUser(user, isNew) async {
    if (isLoggedIn()) {
      if (isNew) {
        //create a new one
        Firestore.instance.collection('registration').add(
          {
            'email': user.email,
            'isInShift': user.isInShift,
            'name': user.name,
            'password': user.password,
            'title': user.title,
            'role': user.role,
            'departmentId': user.departmentId,
            'hospitalId' : user.hospitalId
          },
        );
      } else {
        // updating
         Firestore.instance.collection('users').document(user.uid).setData(
            {
              'email': user.email,
              'isInShift': user.isInShift,
              'name': user.name,
              'password': user.password,
              'title': user.title,
              'role': user.role,
              'departmentId': user.departmentId,
              'hospitalId' : user.hospitalId
            }, merge: true);
      }
    }
  }
}
