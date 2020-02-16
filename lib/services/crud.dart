import 'dart:async';

import 'package:BridgeTeam/Model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:BridgeTeam/Model/bed.dart';
import 'package:BridgeTeam/locator.dart';
import 'package:BridgeTeam/services/auth.dart';

class CrudMethods {
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    }
    return false;
  }

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
          //await tx.update(postRef, <String, dynamic>{'likesCount': postSnapshot.data['likesCount'] + 1});
          await tx.update(roomRef, <String, dynamic>{'beds': beds});
        }
      }).then((_) {
        print("Success");
      });
    }
  }


  Future<void> updateBedStatus(roomId, bedId, flag, status) {
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
              beds[i][flag] = status;
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
              beds[i]["fasting"] = false;
              beds[i]["forCT"] = false;
              beds[i]["isInficted"] = false;
              beds[i]["withCut"] = false;
              beds[i]["SocialAid"] = false;
              beds[i]["PhysoAid"] = false;
              beds[i]["DiatentAid"] = false;
              beds[i]["O2"] = false;
              beds[i]["Petsa"] = false;
              beds[i]["Invasive"] = false;
              beds[i]["dismissed"] = false;
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

  Future<void> addInstruction(roomId, bedId, instructionType, instructionText) {
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

        Message message = new Message(newInstruction.notificationId, bedId, bedId, newInstruction.notificationType, newInstruction.notificationText,
            roomId, roomId, "uid", "departmentId", "ADD_INSTRUCTION", new DateTime.now().toString());
        Firestore.instance.collection("messages").add(message.toMap());
      });
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
              List notifications =
                  List.from(beds[i]['notifications']);
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
          Message message = new Message(instructionId, bedId, bedId, removedInstruction['notificationType'], removedInstruction['notificationText'],
              roomId, roomId, "uid", "departmentId", "EXECUTED_INSTRUCTION", new DateTime.now().toString());
          Firestore.instance.collection("messages").add(message.toMap());
        }
      }).then((_) {
        print("Success");

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

        List beds = List.from(fromPostSnapshot.data['beds']);

        dynamic firstmovingBed;
        dynamic secondmovingBed;
        dynamic tempBed;
        List toBeds = [];

        for (int i = 0; i < beds.length; i++) {
          if (beds[i]['bedId'] == firstBedId) {
            firstmovingBed = fromPostSnapshot.data['beds'][i]; //Bed.fromMap(fromPostSnapshot.data['beds'][i],fromPostSnapshot.data['beds'][i]['bedId']);

            toBeds = List.from(toPostSnapshot.data['beds']);
            for (int j = 0; j < toBeds.length; i++) {
              secondmovingBed = toPostSnapshot.data['beds'][j]; //Bed.fromMap(fromPostSnapshot.data['beds'][i],fromPostSnapshot.data['beds'][i]['bedId']);
              tempBed = secondmovingBed;
              firstmovingBed['bedId'] = tempBed['bedId'];
              firstmovingBed['bedName'] = tempBed['bedName'];

              secondmovingBed['bedId'] = firstBedId;
              firstmovingBed['bedName'] = firstBedId;

              beds.removeAt(i);
              beds.add(secondmovingBed);
              
              toBeds.removeAt(j);
              toBeds.add(firstmovingBed);
              break;
            }


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
  Future<String> getUserRole(uid) async {
    if (isLoggedIn()) {
      var usersRef = Firestore.instance.collection("users");
      var authService = locator<AuthService>();

      List<DocumentSnapshot> docs =
          (await usersRef.where('uid', isEqualTo: uid).getDocuments())
              .documents;
      return docs[0].data['role'];
    }
  }
}
