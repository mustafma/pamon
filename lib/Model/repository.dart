import 'package:hello_world/Model/room.dart';
import 'bed.dart';
import 'dart:async';
import 'package:cloud_functions/cloud_functions.dart';

class Repository {
  List<Room> rooms = new List<Room>();



   Repository();





  Future<List<Room>> getRooms() async
 {
    dynamic resp = await callable.call();
    //var jsonData = json.decode(resp.data);

    await new Future.delayed(new Duration(seconds: 2));

   List<Room> temporaryRooms = [];
   Room room1 = new Room();
    room1.roomId = 1;
    room1.roomName = "חדר 1";
    room1.beds = new List<Bed>();
    room1.totalNotifications = 3;

    Bed bed1 = new Bed();
    bed1.roomId = 1;
    bed1.bedNumber = 1;
    bed1.totalActiveNotifications = 2;
    bed1.name = "מיטה 1";


    

    Bed bed2 = new Bed();
    bed2.roomId = 1;
    bed2.bedNumber = 2;
    bed2.totalActiveNotifications = 0;
    bed2.name = "מיטה 2";

    Bed bed3 = new Bed();
    bed3.roomId = 1;
    bed3.bedNumber = 3;
    bed3.totalActiveNotifications = 1;
    bed3.name = "מיטה 3";



    room1.beds.add(bed1);
    room1.beds.add(bed2);
    room1.beds.add(bed3);



  Room room2 = new Room();
    room2.roomId = 2;
    room2.roomName = "חדר 2";
    room2.beds = new List<Bed>();
    room2.totalNotifications = 0;

    Bed bed11 = new Bed();
    bed11.roomId = 1;
    bed11.bedNumber = 1;
    bed11.totalActiveNotifications = 0;
    bed11.name = "מיטה 1";

    Bed bed22 = new Bed();
    bed22.roomId = 1;
    bed22.bedNumber = 2;
    bed22.totalActiveNotifications = 0;
    bed22.name = "מיטה 2";

    Bed bed33 = new Bed();
    bed33.roomId = 1;
    bed33.bedNumber = 3;
    bed33.totalActiveNotifications = 0;
    bed33.name = "מיטה 3";


    BedInstruction bedInstruction1 = new BedInstruction();
    bedInstruction1.notificationId = 1;
    bedInstruction1.notificationType = "A";
    bedInstruction1.notificationText = "הוראה סוג A";
    bedInstruction1.createdAt = DateTime.parse("2020-01-07 17:00");
    bedInstruction1.parentBedId = 1;

    bed1.notifications.add(bedInstruction1);

    room2.beds.add(bed11);
    room2.beds.add(bed22);
    room2.beds.add(bed33);




    temporaryRooms.add(room1);
    temporaryRooms.add(room2);
   rooms = temporaryRooms;
   return temporaryRooms;
 
 }

final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
    functionName: 'helloWorld',
);


}
