import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hello_world/Model/User.dart';
import 'package:hello_world/Model/bed.dart';
import 'package:hello_world/Model/session.dart';

class NotificationCard extends StatefulWidget {
  final BedInstruction bedInstruction;

  NotificationCard({Key key, @required this.bedInstruction});
  _NotificationCard createState() => _NotificationCard();
}

class _NotificationCard extends State<NotificationCard> {
  int count = 0;
  bool popMenueBtnEnaled = false;
  Color cardColor;
  int diffInMints = 0;
  Timer timer;

  List<PopupMenuEntry<int>> _listOfBedStatuses = [
    new PopupMenuItem<int>(
      value: 1,
      child: Text('בצע הוראה'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
        //
        color: Color.fromRGBO(64, 75, 96, 9),
        child: ListTile(
          // leading: buildLeading(),
          title: Center(
            child: Text(
              widget.bedInstruction.notificationText,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          subtitle: buildSubTrial(),
          trailing: buildTrial(),
          onTap: () => doAction(context),
        ));
  }

  Widget buildLeading() {
    return new PopupMenuButton(
      enabled: popMenueBtnEnaled,
      onSelected: (value) => _selectInstructionAction(value),
      itemBuilder: (BuildContext context) {
        return _listOfBedStatuses;
      },
    );
  }

  Widget buildSubTrial() {
    return new Center(
      child: Text("passed more than :" + diffInMints.toString(),
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
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
          color: Colors.green,
        ));
  }

  @override
  void initState() {
    if (Session.instance().iSNursePermessions) {
      popMenueBtnEnaled = true;
    } else {
      popMenueBtnEnaled = false;
    }

    /*   timer = Timer.periodic(
        Duration(seconds: 15), (Timer t) => calculatePassedTime());*/
    super.initState();
  }

  void _selectInstructionAction(int choice) {}

  void calculatePassedTime() {
    DateTime now = DateTime.now();
    setState(() {
      diffInMints = now.difference(widget.bedInstruction.createdAt).inMinutes;
    });
  }

  void doAction(BuildContext context) {
    UserType userType = User.getInstance().loggedInUserType;

    if (userType == UserType.Nurse || userType == UserType.NurseShiftManager) {alertDialog(context);}
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
                setInstructionAsSeen();
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

void setInstructionAsSeen() {} // To  be implemented when implementing server side Crud method.
}


