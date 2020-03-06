import 'dart:async';
import 'package:BridgeTeam/Model/enumTypes.dart' ;
import 'package:BridgeTeam/Model/User.dart' ;

//import 'package:BridgeTeam/Model/enumTypes.dart';
import 'package:BridgeTeam/services/crud.dart';
import 'package:flutter/material.dart';

import 'package:BridgeTeam/Model/bed.dart';

class NotificationCard extends StatefulWidget {
  final BedInstruction bedInstruction;
  final roomId;
  final bedId;
 CrudMethods crudObj = new CrudMethods();
  NotificationCard({Key key, @required this.bedInstruction,@required this.roomId,@required this.bedId});
  _NotificationCard createState() => _NotificationCard();
}

class _NotificationCard extends State<NotificationCard> {
  int count = 0;
  bool popMenueBtnEnaled = false;
  Color cardColor;
  String currentTimer = "00:00";
  int diffInMints = 0;
  Timer timer;
  bool allowChangeInstrStatus = false;
  User loggedInUser= User.getInstance();

  List<PopupMenuEntry<int>> _listOfBedStatuses = [
    new PopupMenuItem<int>(
      value: 1,
      child: ListTile(
        trailing: Icon(
          Icons.done,
          color: Color.fromRGBO(64, 75, 96, 9),
        ),
        title: Text('בצע הוראה'),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
        //
       // color: Color.fromRGBO(134, 165, 195, 9), //Color.fromRGBO(64, 75, 96, 9),
        child: Container(
          decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [
                        const Color(0xFF003C64), const Color(0xFF428879)
                        //const Color(0xFF003C64),
                        //const Color(0xFF00885A)
                      ],
                      
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp)),
          child:ListTile(
          // leading: buildLeading(),
          title: Center(
            child: Text(
              widget.bedInstruction.notificationText,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          subtitle: buildSubTrial(),
          trailing: buildTrial(),
          onTap: () => doAction(context),
        )
        ) );
  }

  Widget buildLeading() {
    if (allowChangeInstrStatus) {
      return new PopupMenuButton(
        //enabled: popMenueBtnEnaled,
        onSelected: (value) => _selectInstructionAction(value),
        itemBuilder: (BuildContext context) {
          return _listOfBedStatuses;
        },
      );
    } else
      return null;
  }

  Widget buildSubTrial() {
    return new Center(
      child: Text(currentTimer,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }

  Widget buildTrial() {
    return new Container(
        width: 25.0,
        height: 25.0,
        //  padding: const EdgeInsets.(20.0),//I used some padding without fixed width and height
        decoration: new BoxDecoration(
          shape: BoxShape
              .circle, // You can use like this way or like the below line
          //borderRadius: new BorderRadius.circular(30.0),
          color: widget.bedInstruction.color
        ));
  }

  @override
  void initState() {
    timer = Timer.periodic(
        Duration(seconds: 60), (Timer t) => calculatePassedTime());

    allowChangeInstrStatus = loggedInUser.userPermessions[BridgeOperation.RemoveInstruction];

    calculatePassedTime();
    super.initState();
  }

  void _selectInstructionAction(int choice) {}

  void calculatePassedTime() {
    DateTime now = DateTime.now();
    setState(() {
      diffInMints = now.difference(widget.bedInstruction.createdAt).inMinutes;
      int hours = diffInMints ~/ 60;
      int minutes = diffInMints % 60;

      currentTimer = hours.toString().padLeft(2, "0") +
          ":" +
          minutes.toString().padLeft(2, "0");
    });
  }

  void doAction(BuildContext context) {
    if (allowChangeInstrStatus) {
      alertDialog(context);
    }
  }

  void alertDialog(BuildContext context) {
    var alert = new Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: new Text("הודעה",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          content: new Text("הפקודה נצפתה ותבוצע",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                setInstructionAsSeen();
              },
              child: new Text("כן",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
               // setInstructionAsSeen();
              },
              child: new Text("לא",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            )
          ],
        ));
    showDialog(
        context: context,
        builder: (BuildContext c) {
          return alert;
        });
  }

  void setInstructionAsSeen() {

setState(() {
  widget.crudObj.removeInstruction(widget.roomId, widget.bedId, widget.bedInstruction.notificationId);
});
    
    

  } // To  be implemented when implementing server side Crud method.
}
