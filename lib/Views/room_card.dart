import 'dart:async';
//import 'dart:js';

import 'package:BridgeTeam/Model/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:BridgeTeam/Model/room.dart';
import 'package:BridgeTeam/Views/listview_beds.dart';

class RoomCard extends StatefulWidget {
  final Room room;
  List rooms = [];
  RoomCard({@required this.room, this.rooms});

  _RoomCardState createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  int count = 0;
  Color iconTalkColor = Colors.grey;
  Color iconTalkColor2 = Colors.grey;
  Color iconCateterColor = Colors.white;
  Color cardColor;
  Timer timer;
  bool talk10AMvisible = false;
  bool talk15AMvisible = false;

  void _updateNotificationcounter() {
    var totalNotifications = widget.room.getTotalNumberOfNotifications();
    totalNotifications += 1;
    count = totalNotifications;
  }

  @override
  Widget build(BuildContext context) {
    String doctorName = "דר מהנד אבו אלהיגא";
    String nurseName = "עולא עולא";
    return Container(
        height: 188,
        child: Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            //color: cardColor,



            child: Container(
              decoration: new BoxDecoration(
                        gradient: new LinearGradient(
                            colors: [
                              const Color(0xFF144464),
                              const Color(0xFF546C7D)
                            ],
                            begin: FractionalOffset.topLeft,
                            end: FractionalOffset.bottomRight,
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp)),

                            child:Column(
              children: <Widget>[
                Container(
            

                    // decoration:
                    //BoxDecoration(color: Theme.of(context).cardColor),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),

                      title: Align(
                        alignment: Alignment(0, -0.75),
                        child: Text(
                          widget.room.roomName,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      subtitle: buildSubTrial(),
                      // trailing: buildTrial(),
                      onTap: () => onTapBrowseToBeds(context),
                    )),
                Container(
                  decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                          colors: [
                            const Color(0xFF003C64),
                            const Color(0xFF428879)
                          ],
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.bottomRight,
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                      border: new Border(
                          top: new BorderSide(
                              width: 1.5, color: const Color(0xFF428879)))),
                ),

                // decoration: BoxDecoration(
                //   color: (widget.room.getTotalNumberOfNotifications() == 0)
                //       ? Theme.of(context).cardColor
                //      : Colors.red,
                // border: new Border(
                //      top: new BorderSide(
                //          width: 3.0, color: Colors.orange))),
                //    ),
                Container(
            
                    child: Column(
                      children: [
                        Container(
                          child: Text(" רופא/ה אחראי:" + doctorName,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          child: Text("אח/אחות אחראי:" + nurseName,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Container(
                            child: Row(
                              
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                    child: Visibility(
                                        visible: talk10AMvisible,
                                        child: IconButton(
                                            icon: Icon(Icons.people),
                                            iconSize: 30,
                                            tooltip:
                                                "זמן לדבר ולהתעדכן על  הסטאטוס של חדר " +
                                                    (widget.room).roomName,
                                            color: iconTalkColor,
                                            onPressed: () => handleTalk1()))),
                                Center(
                                    child: Visibility(
                                        visible: talk15AMvisible,
                                        child: IconButton(
                                            icon: Icon(Icons.people),
                                            iconSize: 30,
                                            tooltip:
                                                "זמן לדבר ולהתעדכן על  הסטאטוס של חדר " +
                                                    (widget.room).roomName,
                                            color: iconTalkColor2,
                                            onPressed: () => handleTalk2()))),
                              ],
                            )),
                      ],
                    ))
              ],
            )
            )
            
            
            
            
            
            
            
            
            
            ));
  }

  Widget buildTrial() {
    return SingleChildScrollView(
      //padding: const EdgeInsets.all(8.0),
      child: Column(children: <Widget>[
        // Column(
        // children: <Widget>[

        //  ],
        //),
        //Column(
        //children: <Widget>[
        IconButton(
          // alignment: Alignment(10.0, 10.0),
          icon: Icon(Icons.exit_to_app),
          iconSize: 30,
          color: iconTalkColor,
          onPressed: () => handleTalk1(),
        ),

        //],
        //)
      ]),
    );
  }

  Widget buildSubTrial() {
    if (widget.room.getTotalNumberOfNotifications() == 0)
      return new Align(
          alignment: Alignment(0, -2.8),
          child: new Text(
            "אין הוראות חדשות",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            overflow: TextOverflow.fade,
            maxLines: 3,
            // softWrap: true,
          ));
    else {
      String text2 = "הוראות שלא בוצעו ";

      String text3 =
          text2 + widget.room.getTotalNumberOfNotifications().toString();

      return new Align(
          alignment: Alignment(0, -2.8),
          child: new Text(
            text3,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            overflow: TextOverflow.visible,
            maxLines: 1,
            softWrap: false,
          ));
    }
  }

  void onTapBrowseToBeds(BuildContext context) async {
    // navigate to the next screen.
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ListViewBeds(
              beds: widget.room.beds,
              roomId: widget.room.roomId,
              rooms: widget.rooms,
              parentAction: _updateNotificationcounter)),
    );
  }

  @override
  void initState() {
    count = this.widget.room.getTotalNumberOfNotifications();
    if (count > 0) cardColor = Colors.red;
    // else
    //  cardColor = Colors.green.withOpacity(0.7);

    timer = Timer.periodic(Duration(seconds: 60), (Timer t) => onTimeElapsed());

    super.initState();
  }

  handleTalk1() {
    setState(() {
      if (User.getInstance().loggedInUserType == UserType.NurseRoomsupervisor ||
          User.getInstance().loggedInUserType == UserType.Nurse) {
        if (widget.room.docAcceptedTalk1) iconTalkColor = Colors.green;
        // set nurseAcceptedTalk to true

      }

      if (User.getInstance().loggedInUserType ==
              UserType.RoomDoctorSuperviosor ||
          User.getInstance().loggedInUserType == UserType.Doctor) {
        if (!widget.room.nurseAcceptedTalk1) iconTalkColor = Colors.yellow;
        // set docAcceptedTalk to true
      }
    });
  }

  handleTalk2() {
    setState(() {
      if (User.getInstance().loggedInUserType == UserType.NurseRoomsupervisor ||
          User.getInstance().loggedInUserType == UserType.Nurse) {
        if (widget.room.docAcceptedTalk2) iconTalkColor2 = Colors.green;
        // set nurseAcceptedTalk to true

      }

      if (User.getInstance().loggedInUserType ==
              UserType.RoomDoctorSuperviosor ||
          User.getInstance().loggedInUserType == UserType.Doctor) {
        if (!widget.room.nurseAcceptedTalk2) iconTalkColor2 = Colors.yellow;
        // set docAcceptedTalk to true
      }
    });
  }

  void onTimeElapsed() {
    var date = DateTime.now();
    var hour = date.hour;
    if ((hour < 10)) {
      if (widget.room.timeforUpdate1 ||
          widget.room.nurseAcceptedTalk1 ||
          widget.room.docAcceptedTalk1) {
        //set all to false in room  and prepare fo r10 AM fot talk
      }

      if (widget.room.timeforUpdate2 ||
          widget.room.nurseAcceptedTalk2 ||
          widget.room.docAcceptedTalk2) {
        //set all to false in room  and prepare fo r10 AM fot talk
      }
    }

    if (hour == 10) {
      if (User.getInstance().loggedInUserType == UserType.Nurse ||
          User.getInstance().loggedInUserType == UserType.Doctor ||
          User.getInstance().loggedInUserType == UserType.NurseRoomsupervisor ||
          User.getInstance().loggedInUserType ==
              UserType.RoomDoctorSuperviosor) {
        if (!talk10AMvisible) {
          setState(() {
            talk10AMvisible = true;
          });
        }
      }
      if (!widget.room.timeforUpdate1) {
        // set timeforUpdate to true  and nurseAcceptedTalk and  docAcceptedTalk to false to start enabling talk functionality
      }
    }

    if (hour == 15) {
      if (User.getInstance().loggedInUserType == UserType.Nurse ||
          User.getInstance().loggedInUserType == UserType.Doctor ||
          User.getInstance().loggedInUserType == UserType.NurseRoomsupervisor ||
          User.getInstance().loggedInUserType ==
              UserType.RoomDoctorSuperviosor) {
        if (!talk15AMvisible) {
          setState(() {
            talk15AMvisible = true;
          });
        }
      }
      if (!widget.room.timeforUpdate2) {
        // set timeforUpdate to true  and nurseAcceptedTalk and  docAcceptedTalk to false to start enabling talk functionality
      }
    }
  }
}
