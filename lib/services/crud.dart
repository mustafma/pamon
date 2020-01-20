import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello_world/Model/bed.dart';


class CrudMethods {
  bool isLoggedIn() {
    if(FirebaseAuth.instance.currentUser != null)
      {
        return true;
      }
    return false;
  }

  Future<void> addBed(roomId, bed )
  {
    if(isLoggedIn())
      {
        var roomRef = Firestore.instance.collection("rooms").document(roomId);
        if(roomRef !=null){
          roomRef.updateData({
            "beds" : FieldValue.arrayUnion(bed)
          });
        }
      }
  }

  Future<void> updateBedStatus(roomId,bedId,flag,status){
    if(isLoggedIn())
    {
      //var roomRef = Firestore.instance.collection("rooms").document(roomId);

      DocumentReference roomRef = Firestore.instance.collection("rooms").document(roomId);
      Firestore.instance.runTransaction((Transaction tx) async {
        DocumentSnapshot postSnapshot = await tx.get(roomRef);
        if (postSnapshot.exists) {
          var beds = postSnapshot.data['beds'];
          for (int i=0;i<beds.length;i++) {
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

  Future<void> removeBed(roomId,bedId){
    if(isLoggedIn())
    {
      //var roomRef = Firestore.instance.collection("rooms").document(roomId);

      DocumentReference roomRef = Firestore.instance.collection("rooms").document(roomId);
      Firestore.instance.runTransaction((Transaction tx) async {
        DocumentSnapshot postSnapshot = await tx.get(roomRef);
        if (postSnapshot.exists) {
          List<dynamic> beds = postSnapshot.data['beds'];

          for (int i=0;i<beds.length;i++) {
            if (beds[i]['bedId'] == bedId) {
              beds.removeAt(i);
              break;
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

  Future<void> moveBed(fromRoomId,toRoomId,bedId){
    if(isLoggedIn())
    {
      //var roomRef = Firestore.instance.collection("rooms").document(roomId);

      DocumentReference fromRoomRef = Firestore.instance.collection("rooms").document(fromRoomId);
      DocumentReference toRoomRef = Firestore.instance.collection("rooms").document(toRoomId);

      Firestore.instance.runTransaction((Transaction tx) async {
        DocumentSnapshot fromPostSnapshot = await tx.get(fromRoomRef);
        DocumentSnapshot toPostSnapshot = await tx.get(toRoomRef);
        if (fromPostSnapshot.exists) {
          List<dynamic> beds = fromPostSnapshot.data['beds'];

          dynamic movingBed;
          for (int i=0;i<beds.length;i++) {
            if (beds[i]['bedId'] == bedId) {
              movingBed = beds[i];
              List<dynamic> toBeds = toPostSnapshot.data['beds'];
              //toBeds.add(movingBed);
              await tx.update(toRoomRef, <String, dynamic>{'beds': toBeds});
              beds.removeAt(i);
              await tx.update(fromRoomRef, <String, dynamic>{'beds': beds});
              break;
            }
          }



          //await tx.update(postRef, <String, dynamic>{'likesCount': postSnapshot.data['likesCount'] + 1});

        }
      }).then((doc) {
        print("Success");
      });
    }
  }


}