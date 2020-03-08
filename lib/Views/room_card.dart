import 'dart:async';
//import 'dart:js';

import 'package:BridgeTeam/Model/PopupMenuEntries.dart';
import 'package:BridgeTeam/Model/User.dart';
import 'package:BridgeTeam/Model/enumTypes.dart';
import 'package:BridgeTeam/services/crud.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:BridgeTeam/Model/room.dart';
import 'package:BridgeTeam/Views/listview_beds.dart';

class RoomCard extends StatefulWidget {
  final Room room;
  List rooms = [];
    CrudMethods crudObj = new CrudMethods();
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
User loggedInUser = User.getInstance();

  void _updateNotificationcounter() {
    var totalNotifications = widget.room.getTotalNumberOfNotifications();
    totalNotifications += 1;
    count = totalNotifications;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 210,
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
                child: Column(
                  children: <Widget>[
                    Container(
                        height: 105,

                        // decoration:
                        //BoxDecoration(color: Theme.of(context).cardColor),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6.0),
                               leading: buildLeading(),

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
                           trailing: buildTrial(),
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
                          child: Text(
                              "רופא/ה:" + (widget.room).responsibleDoctor,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          child: Text(
                              "אח/אחות:" + (widget.room).responsibleNurse,
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
                                    visible: true,
                                    child: IconButton(
                                        icon: Icon(Icons.people),
                                        iconSize: 25,
                                        tooltip:
                                            "זמן לדבר ולהתעדכן על  הסטאטוס של חדר " +
                                                (widget.room).roomName,
                                        color: setIconTalkColor(1),
                                        onPressed: () => handleTalk1(context)))),
                            Center(
                                child: Visibility(
                                    visible: true,
                                    child: IconButton(
                                        icon: Icon(Icons.people),
                                        iconSize: 25,
                                        tooltip:
                                            "זמן לדבר ולהתעדכן על  הסטאטוס של חדר " +
                                                (widget.room).roomName,
                                        color: setIconTalkColor(2),
                                        onPressed: () => handleTalk2(context)))),
                          ],
                        )),
                      ],
                    ))
                  ],
                ))));
  }

  Widget buildTrial() {
    return Visibility(
      visible: widget.room.infected,
      child:  IconButton(
          // alignment: Alignment(10.0, 10.0),
          icon: Icon(Icons.warning),
          iconSize: 30,
          color: iconTalkColor,
          onPressed: () => {},
    ));
       
  }

  Widget buildSubTrial() {
    String text1;
    if (widget.room.getTotalNumberOfNotifications() == 0)
      text1 = "אין הוראות חדשות";
    else {
      String txt1 = "הוראות שעדין לא נצפו ";

      text1 = txt1 + widget.room.getTotalNumberOfNotifications().toString();
    }

    String text2;
    if (widget.room.getTotalNumberOfReleases() == 0)
      text2 = "אין שחרורים מתוכננים";
    else {
      String txt2 = "שחרורים מתוכננים בחדר זה ";

      text2 = txt2 + widget.room.getTotalNumberOfReleases().toString();
    }

    return new Align(
        alignment: Alignment(0, -2.8),
        child: new Stack(children: <Widget>[
          Container(
            height: 40,
            child: Column(children: <Widget>[
              new Text(
                text1,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
                overflow: TextOverflow.visible,
                maxLines: 1,
                softWrap: false,
              ),
              new Text(
                text2,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
                overflow: TextOverflow.visible,
                maxLines: 1,
                softWrap: false,
              )
            ]),
          )
        ]));
  }



Widget buildLeading() {
    if (loggedInUser.userPermessions[BridgeOperation.SetRoomAsInfected] || loggedInUser.userPermessions[BridgeOperation.CancelRoomInfectectionStatus] ) {
      return new PopupMenuButton(
        color: Theme.of(context).popupMenuTheme.color,
        icon: Icon(
          Icons.list,
          color: Colors.white,
        ),
        // enabled: popMenueBtnEnaled1,
        onSelected: (value) => _selectRoomStatus(value, context),
        itemBuilder: (BuildContext context) {
          return PamonMenus.Roomctions;
        },
      );
    }
    return null;
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


  void _selectRoomStatus(RoomAction choice, BuildContext context) {
  
      switch (choice) {
        case RoomAction.Infected:
            widget.crudObj.updateRoomField(widget.room.roomId,'infected',true);

        break;
           case RoomAction.CancelInfection:
            widget.crudObj.updateRoomField(widget.room.roomId,'infected',false);

        break;
      }
  }
  @override
  void initState() {
    count = this.widget.room.getTotalNumberOfNotifications();
    if (count > 0) cardColor = Colors.red;
    // else
    //  cardColor = Colors.green.withOpacity(0.7);

    timer = Timer.periodic(Duration(seconds: 60), (Timer t) => onTimeElapsed());


  if(!widget.room.nurseAcceptedTalk1 && !widget.room.docAcceptedTalk1) 
    iconTalkColor = Colors.grey;
  else if (!widget.room.nurseAcceptedTalk1 && widget.room.docAcceptedTalk1)
           iconTalkColor = Colors.yellow;
  else if (widget.room.nurseAcceptedTalk1 && widget.room.docAcceptedTalk1)
           iconTalkColor = Colors.green;


  if(!widget.room.nurseAcceptedTalk2 && !widget.room.docAcceptedTalk2) 
    iconTalkColor2 = Colors.grey;
  else if (!widget.room.nurseAcceptedTalk2 && widget.room.docAcceptedTalk2)
           iconTalkColor2 = Colors.yellow;
  else if (widget.room.nurseAcceptedTalk2 && widget.room.docAcceptedTalk2)
           iconTalkColor2 = Colors.green;

     

    super.initState();
  }



Color setIconTalkColor(int select){

  if(select ==1)
  {
      if(!widget.room.nurseAcceptedTalk1 && !widget.room.docAcceptedTalk1) 
    iconTalkColor = Colors.grey;
  else if (!widget.room.nurseAcceptedTalk1 && widget.room.docAcceptedTalk1)
           iconTalkColor = Colors.yellow;
  else if (widget.room.nurseAcceptedTalk1 && widget.room.docAcceptedTalk1)
           iconTalkColor = Colors.green;

           return iconTalkColor;

  }

else{

  if(!widget.room.nurseAcceptedTalk2 && !widget.room.docAcceptedTalk2) 
    iconTalkColor2 = Colors.grey;
  else if (!widget.room.nurseAcceptedTalk2 && widget.room.docAcceptedTalk2)
           iconTalkColor2 = Colors.yellow;
  else if (widget.room.nurseAcceptedTalk2 && widget.room.docAcceptedTalk2)
           iconTalkColor2 = Colors.green;
           
   return iconTalkColor2;
}

}

  handleTalk1(BuildContext context) {
    var date = DateTime.now();
    var hour = date.hour;

    if (hour < 10) {
      // Show dialog
      // העדכון  הבא ב 10:00
      showDialog(
          context: context,
          child: new AlertDialog(
            title: Text('עדכון'),
            content: const Text('העדכון  הבא ב 10:00'),
            actions: <Widget>[
              FlatButton(
                child: Text('סגור'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
    }

    else if (hour >= 15) {
      // What to do here to show message that this updat eis not relevant anymore
      showDialog(
          context: context,
          child: new AlertDialog(
            title: Text('עדכון'),
            content: const Text('העדכון של שעה 10:00 הסתיים'),
            actions: <Widget>[
              FlatButton(
                child: Text('סגור'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
    } else {
      setState(() {
        if (User.getInstance().loggedInUserType ==
            UserType.NurseShiftManager  || User.getInstance().loggedInUserType ==
            UserType.Nurse) {
          if (widget.room.docAcceptedTalk1) {
            iconTalkColor = Colors.green;
            // set nurseAcceptedTalk to true
            widget.crudObj.updateRoomTalkUpdates(widget.room.roomId, "nurseAcceptedTalk", true,false);
          } else {
            showDialog(
                context: context,
                child: new AlertDialog(
                  title: Text('עדכון'),
                  content:
                      const Text('הרופא עדיין לא אשר עדיין עדכון של שעה 10:00'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('סגור'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ));
          }
        }

        if ( User.getInstance().loggedInUserType == UserType.Doctor) {
          if (!widget.room.nurseAcceptedTalk1) iconTalkColor = Colors.yellow;
           widget.crudObj.updateRoomTalkUpdates(widget.room.roomId, "docAcceptedTalk", true , false);
        }
      });
    }
  }

  handleTalk2(BuildContext context) {
    var date = DateTime.now();
    var hour = date.hour;

    if (hour < 15) {
      // Show dialog
      // העדכון  הבא ב 10:00
      showDialog(
          context: context,
          child: new AlertDialog(
            title: Text('עדכון'),
            content: const Text('העדכון  הבא ב 15:00'),
            actions: <Widget>[
              FlatButton(
                child: Text('סגור'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
    }

   else if (hour >= 23) {
      // What to do here to show message that this updat eis not relevant anymore
      showDialog(
          context: context,
          child: new AlertDialog(
            title: Text('עדכון'),
            content: const Text('העדכון של שעה 15:00 הסתיים'),
            actions: <Widget>[
              FlatButton(
                child: Text('סגור'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
    } else {
      setState(() {
        if (User.getInstance().loggedInUserType ==
            UserType.NurseShiftManager) {
          if (widget.room.docAcceptedTalk2) {
            iconTalkColor2 = Colors.green;
            // set nurseAcceptedTalk to true
            widget.crudObj.updateRoomTalkUpdates(widget.room.roomId, "nurseAcceptedTalk2", true,false);
          } else {
            showDialog(
                context: context,
                child: new AlertDialog(
                  title: Text('עדכון'),
                  content:
                      const Text('הרופא עדיין לא אשר עדיין עדכון של שעה 15:00'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('סגור'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ));
          }
        }

        if (User.getInstance().loggedInUserType == UserType.Doctor) {
          if (!widget.room.nurseAcceptedTalk2) iconTalkColor2 = Colors.yellow;
          // set docAcceptedTalk to true
            widget.crudObj.updateRoomTalkUpdates(widget.room.roomId, "docAcceptedTalk2", true ,false);
        }
      });
    }
  }

  void onTimeElapsed() {
    var date = DateTime.now();
    var hour = date.hour;

    // Set icons for update to  initial state
    if ((hour < 8)) {
      //set all to false in room  and prepare fo r10 AM fot talk
      iconTalkColor = Colors.grey;
      iconTalkColor2 = Colors.grey;

      if (widget.room.docAcceptedTalk1 ||
          widget.room.nurseAcceptedTalk1 ||
          widget.room.nurseAcceptedTalk2 ||
          widget.room.docAcceptedTalk2) {
        // update those fields in  Database as false preparing for the coming sheduled updates
          widget.crudObj.updateRoomTalkUpdates(widget.room.roomId, null, null ,true);

      }
    }

    if (hour >= 10) {
      if (!widget.room
          .docAcceptedTalk1) // Doctor still  not accepted talk  with  nurse
      {
        iconTalkColor = Colors.red;
      }
    }

    if (hour >= 15) {
      if (!widget.room
          .docAcceptedTalk2) // Doctor still  not accepted talk  with  nurse
      {
        iconTalkColor2 =
            Colors.red; // Waiting for doctor  to accept  the updat erequest
      }
    }
  }
}
